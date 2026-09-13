param([Parameter(Mandatory=$true)][string]$Game,
      [Parameter(Mandatory=$true)][string]$Workshop)
$ErrorActionPreference = 'Stop'
$mod = Join-Path $PSScriptRoot '..\Mod'
$managed = Join-Path $Game 'RimWorldWin64_Data\Managed'
[void][Reflection.Assembly]::LoadFrom((Join-Path $managed 'UnityEngine.CoreModule.dll'))
$gameAssembly = [Reflection.Assembly]::LoadFrom((Join-Path $managed 'Assembly-CSharp.dll'))
# Profiling reads live game preferences; disable it only in this test process.
$gameAssembly.GetType('Verse.DeepProfiler', $true).GetField('enabled').SetValue($null, $false)
$moAssembly = [Reflection.Assembly]::LoadFrom((Join-Path $Workshop '3219596926\1.6\Assemblies\MedievalOverhaul.dll'))
$extensionType = $moAssembly.GetType('MedievalOverhaul.ButcherProperties', $true)
if ($extensionType.BaseType.FullName -ne 'Verse.DefModExtension') { throw 'Wrong extension base class' }
foreach ($name in 'hasBone','hasFat') {
    if ($extensionType.GetField($name).FieldType -ne [bool]) { throw "Invalid field: $name" }
}
'PASS: ButcherProperties extends DefModExtension; hasBone and hasFat are bool.'

$patchLoader = $gameAssembly.GetType('Verse.DirectXmlToObject').GetMethod('ObjectFromXml').MakeGenericMethod($gameAssembly.GetType('Verse.PatchOperation'))
function New-Patch([System.Xml.XmlElement]$node) {
    $patch = $patchLoader.Invoke($null, @($node, $false))
    if (!$patch -or $patch.GetType().Name -ne $node.GetAttribute('Class')) { throw 'Native patch deserialization failed' }
    return $patch
}
function Assert-Payloads($patchXml, $defs) {
    foreach ($operation in $patchXml.SelectNodes('//*[@Class="PatchOperationAdd" or @Class="PatchOperationAddModExtension"]')) {
        foreach ($target in $defs.SelectNodes($operation.xpath)) {
            if ($operation.GetAttribute('Class') -eq 'PatchOperationAdd') {
                $values = @($target.SelectNodes('Outland_BoneAmount'))
                if ($values.Count -ne 1 -or $values[0].InnerText -ne '0') { throw 'Incorrect or duplicate Outland bone stat' }
            } else {
                $extensions = @($target.SelectNodes('modExtensions/li[@Class="MedievalOverhaul.ButcherProperties"]'))
                if ($extensions.Count -ne 1) { throw 'Missing or duplicate direct butcher extension' }
                foreach ($field in 'hasBone','hasFat') {
                    if ($extensions[0].SelectSingleNode($field).InnerText -ne $operation.value.li.SelectSingleNode($field).InnerText) {
                        throw "Wrong $field value"
                    }
                }
            }
        }
    }
}
$load = [xml](Get-Content (Join-Path $mod 'LoadFolders.xml') -Raw)
foreach ($animals in 0..3) {
    $roots = @((Join-Path $Game 'Data\Core\Defs'))
    if ($animals -band 1) { $roots += Join-Path $Workshop '1541721856\1.6\Defs' }
    if ($animals -band 2) { $roots += Join-Path $Workshop '1055485938\1.6\Defs' }
    $baseline = [xml]'<Defs/>'
    foreach ($root in $roots) {
        if (!(Test-Path $root)) { throw "Missing fixture directory: $root" }
        foreach ($file in Get-ChildItem $root -Recurse -Filter *.xml) {
            $doc = [xml]::new(); $doc.Load($file.FullName)
            foreach ($def in $doc.DocumentElement.ChildNodes) {
                if ($def.NodeType -eq 'Element') { [void]$baseline.DocumentElement.AppendChild($baseline.ImportNode($def,$true)) }
            }
        }
    }
    foreach ($integrations in 0..3) {
        $active = @()
        if ($integrations -band 1) { $active += 'DankPyon.Medieval.Overhaul' }
        if ($integrations -band 2) { $active += 'Neronix17.Outland.Core' }
        $defs = $baseline.CloneNode($true)
        $untouched = @{}
        foreach ($def in $defs.SelectNodes('/Defs/ThingDef[defName="Muffalo" or defName="Cow"]')) { $untouched[$def.defName] = $def.OuterXml }
        $applied = 0
        foreach ($folder in $load.SelectNodes('/loadFolders/v1.6/li')) {
            $condition = $folder.GetAttribute('IfModActive')
            if ($condition -and $condition -notin $active) { continue }
            $patchRoot = Join-Path (Join-Path $mod $folder.InnerText.TrimStart('/')) 'Patches'
            if (!(Test-Path $patchRoot)) { continue }
            foreach ($file in Get-ChildItem $patchRoot -Recurse -Filter *.xml | Sort-Object Name) {
                $xml = [xml]::new(); $xml.Load($file.FullName)
                foreach ($node in $xml.SelectNodes('/Patch/Operation')) {
                    $patch = New-Patch $node
                    if (!$patch.Apply($defs)) { throw "Patch failed: $($file.Name)" }
                    $applied++
                }
                Assert-Payloads $xml $defs
            }
        }
        $expected = 3 * $active.Count
        if ($applied -ne $expected) { throw "Wrong folder selection: $applied / $expected" }
        foreach ($name in $untouched.Keys) {
            if ($defs.SelectSingleNode("/Defs/ThingDef[defName='$name']").OuterXml -ne $untouched[$name]) { throw "Non-target changed: $name" }
        }
        if (!$integrations -and $defs.OuterXml -ne $baseline.OuterXml) { throw 'Inactive mod changed definitions' }
        "PASS: animals=$animals integrations=$integrations; $applied real PatchOperation.Apply calls; payload and non-target checks passed."
    }
}
'Scope: native DirectXmlToObject patch deserialization and real game patch methods, on real pre-inheritance Def XML.'
'Excluded: full Def deserialization, dependency patch ordering, inheritance, live butchering, saves and game UI.'
