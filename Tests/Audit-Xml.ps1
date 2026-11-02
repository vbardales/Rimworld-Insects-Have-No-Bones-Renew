param([Parameter(Mandatory=$true)][string]$Game,
      [Parameter(Mandatory=$true)][string]$Workshop)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'lib\Fixture.ps1')
$mod = Join-Path $PSScriptRoot '..\Mod'
$patches = @(Get-ChildItem $mod -Recurse -Filter *.xml | Where-Object FullName -Match '\\Patches\\')
$checks = 0
foreach ($combo in 0..3) {
    $merged = Get-MergedDefs $Game $Workshop $combo
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
        $checks += $counts.Count
        "PASS: combination $combo, $($file.Name), matches $($counts -join ',')"
    }
}
"PASS: $($patches.Count) patch documents, $checks selector hit counts over 4 combinations."
'Scope: actual pre-inheritance XML selectors only; no RimWorld patch engine or butchering simulation. XML parsing is Check-ModBasics.ps1.'
