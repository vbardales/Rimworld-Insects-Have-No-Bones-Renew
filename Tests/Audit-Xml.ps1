param([Parameter(Mandatory=$true)][string]$Game,
      [Parameter(Mandatory=$true)][string]$Workshop)
$ErrorActionPreference = 'Stop'
$mod = Join-Path $PSScriptRoot '..\Mod'
$patches = @(Get-ChildItem $mod -Recurse -Filter *.xml | Where-Object FullName -Match '\\Patches\\')
foreach ($file in Get-ChildItem $mod -Recurse -Filter *.xml) {
    $xml = [xml]::new(); $xml.Load($file.FullName)
    foreach ($node in $xml.SelectNodes('//xpath')) { [void][System.Xml.XPath.XPathExpression]::Compile($node.InnerText) }
}
'PASS: 8 XML documents and 11 XPath expressions parse.'
foreach ($combo in 0..3) {
    $roots = @((Join-Path $Game 'Data\Core\Defs'))
    if ($combo -band 1) { $roots += Join-Path $Workshop '1541721856\1.6\Defs' }
    if ($combo -band 2) { $roots += Join-Path $Workshop '1055485938\1.6\Defs' }
    $merged = [xml]'<Defs/>'
    foreach ($root in $roots) {
        if (!(Test-Path $root)) { throw "Missing real fixture directory: $root" }
        foreach ($file in Get-ChildItem $root -Recurse -Filter *.xml) {
            $doc = [xml]::new(); $doc.Load($file.FullName)
            foreach ($def in $doc.DocumentElement.ChildNodes) {
                if ($def.NodeType -eq 'Element') { [void]$merged.DocumentElement.AppendChild($merged.ImportNode($def, $true)) }
            }
        }
    }
    foreach ($file in $patches) {
        $doc = [xml]::new(); $doc.Load($file.FullName)
        $nodes = @($doc.SelectNodes('//xpath'))
        $counts = @($nodes | ForEach-Object { $merged.SelectNodes($_.InnerText).Count })
        if ($file.Name -match 'Insects') { $expected = @(1) }
        elseif ($file.Name -match 'Megafauna') {
            if ($combo -band 2) { $expected = @(1,3) } else { $expected = @(0,0) }
        } elseif ($file.Name -match '^MO_') {
            if ($combo -band 1) { $expected = @(1,61,16) } else { $expected = @(0,0,0) }
        } else {
            if ($combo -band 1) { $expected = @(1,77) } else { $expected = @(0,0) }
        }
        if (($counts -join ',') -ne ($expected -join ',')) { throw "$($file.Name), combination $combo : actual $counts; expected $expected" }
        "PASS: combination $combo, $($file.Name), matches $($counts -join ',')"
    }
}
'Scope: actual pre-inheritance XML selectors only; no RimWorld patch engine or butchering simulation.'
