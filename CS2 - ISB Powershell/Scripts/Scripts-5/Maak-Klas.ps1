#maak een klassen.csv aan 
/Users/youneselazzouzi/Downloads/klas1,student,8
/Users/youneselazzouzi/Downloads/klas2,leerling,5


@'
/Users/youneselazzouzi/Downloads/klas1,student,8
/Users/youneselazzouzi/Downloads/klas2,leerling,5
'@ | Set-Content -Path klassen.csv

Get-Content klassen.csv


#nu moet ik een script maken dat een folder maakt van het eerste veld --> klas1
#lege bestanden maken van de studenten
#hiervoor gebruik maken van de functie klas
#als optie -Remove wordt gegeven worden de folders uit de csv verwijderd

param (
    [switch]$Remove
)

function Klas($klas) {
    $pad = $klas[0]
    $prefix = $klas[1]
    $aantal = [int]$klas[2]

    if ($Remove) {
        if (Test-Path $pad) {
            Remove-Item -Path $pad -Recurse -Force
            Write-Host "Folder verwijderd: $pad"
        }
    }
    else {
        if (-Not (Test-Path $pad)) {
            New-Item -Path $pad -ItemType Directory
            Write-Host "Folder aangemaakt: $pad"
        }

        for ($i = 1; $i -le $aantal; $i++) {
            $file = "$pad/$prefix$i"
            New-Item -Path $file -ItemType File
            Write-Host "Bestand aangemaakt: $file"
        }
    }
}

$klassen = Import-Csv -Path klassen.csv -Header "Pad", "Prefix", "Aantal"

foreach ($klas in $klassen) {
    Klas @($klas.Pad, $klas.Prefix, $klas.Aantal)
}

./Maak-Klas.ps1

./Maak-Klas.ps1 -Remove