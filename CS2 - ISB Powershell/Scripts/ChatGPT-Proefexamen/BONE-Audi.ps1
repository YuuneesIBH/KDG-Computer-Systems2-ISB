# Name: BONE-Audi.ps1
# Author: Younes El Azzouzi
# Date: 06/06/2025

<#
.SYNOPSIS
    Analyseert voertuiginformatie over Audi-wagens uit een CSV-bestand.

.DESCRIPTION
    Script verwerkt een lijst van Audi-modellen en biedt functies voor:
    - Filtering op verbruik of prijs
    - Groepering op brandstoftype
    - Gemiddeld vermogen per versnellingsbak
    - Tellen van voertuigen per kleur
    - Export van gefilterde voertuigen
    - Custom object creatie en foutafhandeling

.EXAMPLE
    .\BONE-Audi.ps1
#>

$path = "./audi_voertuigen.csv"

if (!(Test-Path $path)) {
    Write-Host "Bestand niet gevonden op pad: $path" -ForegroundColor Red
    exit 1 
}

$audi = Import-Csv -Delimiter ";" $path

if ($audi.Count -eq 0) {
    Write-Host "Leeg CSV-bestand ingeladen!" -ForegroundColor Red
    exit 1
}

# 1. Filter voertuigen met verbruik ≤ grens
function Filter-Verbruik ($audi, $grens) {
    # TODO: Filter op kolom VerbruikL_100km kleiner of gelijk aan $grens
    return $audi | Where-Object { [double]$_.VerbruikL_100km -le $grens }

}

# 2. Gemiddeld vermogen per versnellingsbak
function Avg-Vermogen-Gearbox ($audi) {
    # TODO: Group op Versnellingsbak en bereken gemiddelde VermogenPK
    return $audi | Group-Object -Property Versnellingsbak | ForEach-Object {
        [PSCustomObject]@{
            Versnellingsbak = $_.Name
            AVGPK = ($($_.Group | Measure-Object -Property VermogenPK -Average)).Average
        }
    }
}

# 3. Top 3 duurste modellen
function Top-Prijs ($audi) {
    # Sorteer op PrijsEuro aflopend, en bewaar de top 3 in een array
    $top = @()  # lege array

    $top += $audi | Sort-Object { [int]$_.PrijsEuro } -Descending | Select-Object -First 3

    return $top
}


# 4. Aantal voertuigen per kleur
function Count-Kleur ($audi) {
    # TODO: Group-Object op Kleur
    return $audi | Group-Object -Property Kleur | ForEach-Object {
        [PSCustomObject]@{
            Kleur = $_.Name
            Count = $_.Count
        }
    }
}

# 5. Filter op bouwjaar en export
function Export-Jaar ($audi, $jaar) {
    # TODO: Filter waar Bouwjaar gelijk is aan $jaar en exporteer CSV
    $audi | Where-Object { $_.Bouwjaar -eq $jaar } | Export-Csv -Path "BouwjaarAudi.csv" -Delimiter ";" -NoTypeInformation
}

# 6. Toon unieke modellen per brandstoftype
function Uniek-Model-PerBrandstof ($audi) {
    # TODO: Selecteer unieke combinaties van Model en Brandstof
    return $audi | Sort-Object Model, Brandstof | Select-Object Model, Brandstof -Unique
}

# 7. Foutafhandelingsvoorbeeld (controle op kolom PrijsEuro)
function Check-Prijzen ($audi) {
    # TODO: Loop over elke rij en controleer of PrijsEuro een geldig getal is
    # Gebruik try/catch om fouten af te handelen en een foutmelding te tonen
    foreach ($auto in $audi) {
        try {
            if (-not ($auto.PrijsEuro -match '^\d+$')) {
                throw "Ongeldige prijs gevonden: $($auto.PrijsEuro)"
            }
        } catch {
            Write-Host "FOUT: $_" -ForegroundColor Red
        }
    }
}

# ===================================
# Hoofdprogramma – niets wijzigen
# ===================================

$maxVerbruik = 7.5
$targetJaar = 2022

Filter-Verbruik $audi $maxVerbruik | Format-Table
Avg-Vermogen-Gearbox $audi | Format-Table
Top-Prijs $audi | Format-Table
Count-Kleur $audi | Format-Table
Export-Jaar $audi $targetJaar | Format-Table
Uniek-Model-PerBrandstof $audi | Format-Table
Check-Prijzen $audi