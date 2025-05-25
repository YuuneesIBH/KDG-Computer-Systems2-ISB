function Lees-Punten {
    param (
        [int]$aantalVakken,
        [int]$aantalStudenten
    )

    $regels = @()
    for ($i = 1; $i -le $aantalVakken; $i++) {
        $lijn = "vak$i"
        for ($j = 1; $j -le $aantalStudenten; $j++) {
            $punt = Read-Host "Geef punt voor vak $i voor student $j"
            $lijn += ",$punt"
        }
        $regels += $lijn
    }
    $regels | Set-Content punten.csv
}

function Schrijf-Gemiddelde {
    $data = Import-Csv punten.csv -Header("Vak", "S1", "S2", "S3", "S4", "S5")
    $data | ForEach-Object {
        $gem = ($_.S1,$_.S2,$_.S3,$_.S4,$_.S5 | Where-Object {$_ -match "\d"} | Measure-Object -Average).Average
        Write-Host ("{0}: Gemiddelde = {1:N2}" -f $_.Vak, $gem)
    }
}

# ============================
# Hoofdprogramma
# ============================
$aantalVakken = Read-Host "Hoeveel vakken?"
$aantalStudenten = Read-Host "Hoeveel studenten?"

Lees-Punten -aantalVakken $aantalVakken -aantalStudenten $aantalStudenten
Schrijf-Gemiddelde
