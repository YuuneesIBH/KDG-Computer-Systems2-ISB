function Zoek-Overtredingen {
    param (
        [string]$straat
    )
    $data = Import-Csv -Delimiter "," ./a_overtredingen.csv

    $gevonden = $data | Where-Object { $_.opnameplaats_straat -like "*$straat*" }

    if ($gevonden.Count -eq 0) {
        Write-Host "Er zijn geen overtredingen gevonden in de '$straat'" -ForegroundColor Red
    } else {
        Write-Host "Aantal gevonden overtredingen in de '$straat'" -ForegroundColor Yellow
        $gevonden | Select-Object datum_vaststelling, opnameplaats_straat, aantal_overtredingen_roodlicht
    }
}

$straat = Read-Host "Geef een straatnaam in (hoeft niet exact te zijn)"
Zoek-Overtredingen -straat $straat