param(
    [string]$mode,
    [string]$value
)

# Functie: More-Overtredingen
# Doel: Toon enkel de rijen met >= $value roodlichtovertredingen
function More-Overtredingen {
    param(
        [array]$overtredingen,
        [int]$aantal
    )
    # Filter alle rijen waar het aantal roodlichtovertredingen groter of gelijk is aan het opgegeven aantal
    $filter = $overtredingen | Where-Object {
        [int]$_.aantal_overtredingen_roodlicht -ge $aantal
    }

    # Toon enkel de relevante kolommen
    $filter | Select-Object datum_vaststelling, opnameplaats_straat, aantal_passanten, aantal_overtredingen_roodlicht
}

# Functie: Get-Streets
# Doel: Geef een unieke lijst van alle straten in het CSV-bestand
function Get-Streets {
    param(
        [array]$overtredingen
    )
    # Haal de unieke straatnamen op uit de kolom opnameplaats_straat
    $overtredingen | Select-Object -ExpandProperty opnameplaats_straat -Unique
}

# Functie: Sum-Overtredingen
# Doel: Geef het totaal aantal overtredingen in één bepaalde straat ($value)ifunction Sum-Overtredingen {
    param(
        [array]$overtredingen,
        [string]$straat
    )
    # Filter de rijen die overeenkomen met de opgegeven straat
    $filter = $overtredingen | Where-Object {
        $_.opnameplaats_straat -eq $straat
    }

    # Bereken het totaal van alle roodlichtovertredingen in die straat
    $totaal = ($filter | Measure-Object -Property aantal_overtredingen_roodlicht -Sum).Sum

    # Toon het resultaat
    Write-Host "Totaal aantal overtredingen in $straat = $totaal." -ForegroundColor Yellow
}

# Functie: All-Overtredingen
# Doel: Toon totaal overtredingen per straat, gesorteerd aflopend
function All-Overtredingen {
    param(
        [array]$overtredingen
    )
    # Groepeer alle rijen per straatnaam, bereken per groep de som van roodlichtovertredingen
    $result = $overtredingen | Group-Object opnameplaats_straat | ForEach-Object {
        [PSCustomObject]@{
            Straat = $_.Name
            TotaalOvertredingen = ($_.Group | Measure-Object -Property aantal_overtredingen_roodlicht -Sum).Sum
        }
    } | Sort-Object TotaalOvertredingen -Descending

    # Toon alles in tabelvorm
    $result | Format-Table Straat, TotaalOvertredingen
}

# CSV inlezen
# Deze lijn leest het CSV-bestand in als een array van objecten
$overtredingen = Import-Csv ./a_overtredingen.csv -Delimiter ","

# Hoofdprogramma: beslist welke functie moet worden uitgevoerd op basis van de opgegeven mode
if (-not $mode) {
    # Geen mode meegegeven → toon alle overtredingen per straat
    All-Overtredingen -overtredingen $overtredingen
}
elseif ($mode -eq "-more") {
    # Filter op aantal overtredingen
    More-Overtredingen -overtredingen $overtredingen -aantal $value
}
elseif ($mode -eq "-streets") {
    # Toon unieke straten
    Get-Streets -overtredingen $overtredingen
}
elseif ($mode -eq "-sum") {
    # Toon totaal overtredingen in opgegeven straat
    Sum-Overtredingen -overtredingen $overtredingen -straat $value
}
else {
    # Ongeldige parameter
    Write-Host "Gebruik: ./Overtredingen.ps1 [-more aantal] | [-streets] | [-sum straatnaam]" -ForegroundColor Yellow
}
