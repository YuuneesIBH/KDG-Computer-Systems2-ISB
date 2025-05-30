function Zoek-Adapter{
    param([string]$naam)
    $data = Import-Csv ./MacTable.csv
    $resultaat = $data | Where-Object { $_.adaptername -eq $naam }

    if ($resultaat.Count -eq 0) {
        Write-Host "Er zijn geen adapters gevonden met die naam!" -ForegroundColor Red
    } else {
        Write-Host "Resultaten: " -ForegroundColor Green
        $resultaat
    }
}

$naam = Read-Host "Geef een adapternaam in:"
Zoek-Adapter -naam $naam