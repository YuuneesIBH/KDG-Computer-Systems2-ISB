function Top-StratenRoodlicht {
    param([int]$topaantal)
    $data = Import-Csv ./a_overtredingen.csv -Delimiter ","

    $top3 = $data |
        Group-Object opnameplaats_straat |
        ForEach-Object {
            [PSCustomObject]@{
                opnameplaats_straat = $_.Name
                Totaal = ($_.Group | Measure-Object -Property aantal_overtredingen_roodlicht -Sum).Sum
            }
        } |
        Sort-Object Totaal -Descending |
        Select-Object -First $topaantal

    Write-Host "Top 3 straten met de meeste overtredingen:" -ForegroundColor Green
    $top3 | Format-Table opnameplaats_straat, Totaal
}

$keuze = Read-Host "Welke top (x) wens je op te stellen geef een cijfer in:"
Top-StratenRoodlicht -topaantal $keuze
