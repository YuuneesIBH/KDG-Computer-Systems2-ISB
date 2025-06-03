param(
    [string]$mode,
    [string]$value
)

# Laad de cereal.csv in
$cereal = Import-Csv -Delimiter ";" ./cereal.csv

# Functie: Get-CerealByType
# Doel: Toon alle granen van een bepaald type (bv. "H")
function Get-CerealByType {
    param(
        [array]$cerealData,
        [string]$type
    )

    # TODO: Filter op type gelijk aan $type
    $filter = $cereal | Where-Object {
        [string]$_.type -eq $type
    }

    $filter
}

# Functie: Count-LowCalorieCereals
# Doel: Tel hoeveel granen ≤ 50 calorieën hebben
function Count-LowCalorieCereals {
    param(
        [array]$cerealData
    )

    # TODO: Filter en tel granen met calorieën ≤ 50
    $filter = $cerealData | Where-Object {
        [int]$_.calories -le 100
    }

    $filter | Measure-Object | Select-Object -ExpandProperty Count
}

# Functie: Get-WeightType
# Doel: Bepaal het type van de 'weight'-property
function Get-WeightType {
    param(
        [array]$cerealData
    )

    # TODO: Gebruik GetType() op de weight-property
    $cerealData[0].weight.GetType().Name

}

# Functie: Total-WeightLowCalories
# Doel: Som van gewichten van granen met calorieën ≤ 50
function Total-WeightLowCalories {
    param(
        [array]$cerealData
    )

    # Filter op granen waarvan calorieën kleiner of gelijk zijn aan 50
    $filtered = $cerealData | Where-Object {
        [int]$_.calories -le 100
    }

    # Zet 'weight' om naar een getal (double) zodat we kunnen optellen
    $converted = $filtered | Select-Object @{Name="weight"; Expression={[double]$_.weight}}

    # Bereken en toon de som van het gewicht
    $converted | Measure-Object -Property weight -Sum | Format-Table Count, Sum
}


# Hoofdprogramma - kies wat er gebeurt op basis van $mode
switch ($mode) {
    "type"       { Get-CerealByType -cerealData $cereal -type $value }
    "count"      { Count-LowCalorieCereals -cerealData $cereal }
    "typecheck"  { Get-WeightType -cerealData $cereal }
    "total"      { Total-WeightLowCalories -cerealData $cereal }
    default      { Write-Host "Gebruik: -mode type|count|typecheck|total [-value <waarde>]" }
}
