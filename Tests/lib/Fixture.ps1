# Shared by Audit-Xml.ps1 and Audit-PatchEngine.ps1: one place for the Workshop ids and the fixture merge.
$WorkshopId = @{ AlphaAnimals = '1541721856'; Megafauna = '1055485938'; MedievalOverhaul = '3219596926' }

# Core Defs plus, by bit of $Animals (1 = Alpha Animals, 2 = Megafauna), the real Def files of that mod,
# merged into one <Defs/> document.
function Get-MergedDefs([string]$Game, [string]$Workshop, [int]$Animals) {
    $roots = @(Join-Path $Game 'Data\Core\Defs')
    if ($Animals -band 1) { $roots += Join-Path $Workshop "$($WorkshopId.AlphaAnimals)\1.6\Defs" }
    if ($Animals -band 2) { $roots += Join-Path $Workshop "$($WorkshopId.Megafauna)\1.6\Defs" }
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
    return $merged
}
