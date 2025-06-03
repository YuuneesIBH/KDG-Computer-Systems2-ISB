# OvertredingenAnalyse.ps1
$path = "./a_overtredingen.csv"

if (!(Test-Path $path)) {
    Write-Host "Bestand is NIET gevonden!" -ForegroundColor Red
    exit 1 
}

$data = Import-Csv -Delimiter "," $path

if ($data.Count -eq 0) {
    Write-Host "Je hebt een leeg bestand geimporteerd!" -ForegroundColor Red
    exit 1
}

# 1. Filter op roodlichtovertredingen boven grens
function More-Overtredingen {
    param (
        [array]$data,
        [int]$grens
    )

    return $data | Where-Object {
        [int]$_.aantal_overtredingen_roodlicht -ge $grens
    } | Sort-Object { [int]$_.aantal_overtredingen_roodlicht } -Descending |
    Select-Object datum_vaststelling, opnameplaats_straat, aantal_passanten, aantal_overtredingen_roodlicht
}


# 2. Geef unieke lijst van straten
function Get-Straten {
    param ([array]$data)

    return $data | Select-Object -ExpandProperty opnameplaats_straat | Sort-Object -Unique
}


# 3. Totaal aantal overtredingen in 1 straat
function Sum-Overtredingen {
    param (
        [array]$data,
        [string]$straat
    )

    $filter = $data | Where-Object {
        $_.opnameplaats_straat -ilike "*$straat*"
    } | Measure-Object -Property aantal_overtredingen_roodlicht -Sum |
    Select-Object -ExpandProperty Sum

    return $filter
}

# Aanroepen
# Toon de gefilterde overtredingen in de terminal
$filtered = More-Overtredingen -data $data -grens 15
$filtered | Format-Table

# Toon unieke straten in de terminal
$straten = Get-Straten -data $data
$straten | Format-Table

# Vraag gebruiker om een straat en toon totaal
$search = Read-Host "Welke straat wens je op te zoeken?"
$totaal = Sum-Overtredingen -data $data -straat $search
Write-Host "`nTotaal aantal roodlichtovertredingen in ${search}: ${totaal}" -ForegroundColor Yellow