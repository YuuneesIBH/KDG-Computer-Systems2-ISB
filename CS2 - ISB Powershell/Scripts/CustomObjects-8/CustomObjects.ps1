#Hash Table Key/value pair is een simpele manier omgestructureerde data op te slaan.
$person = @{
    Name = "Bob"
    Age = 22
}

Write-Host "Hash Table:"
Write-Host "Naam: $($person["Name"])"
Write-Host "Leeftijd: $($person["Age"])"

#Dit hier is redelijk simpel nu kunnen we ook Custom Objects definieren en deze zijn veel krachtiger dan een Hash Table. Dit is meer OOP.
[array]$personlist = $null

$person1 = [PSCustomObject]@{
    Name = "Younes"
    Age = 22
}
$personlist += $person1

#tweede object aanmaken
$person2 = [PSCustomObject]@{
    Name = "Danny"
    Age = 31
}
$personlist += $person2

Write-Host "Alle objecten in de personlist:" -ForegroundColor Green
$personlist

#nu gaan we werken met een csv fruit.csv --> import --> aantal van fruit casten naar een int
$csvPath = "$HOME/fruit.csv"
@"
Fruit,Aantal
Appels,10
Peren,8
Kersen,5
Bananen,23
"@ | Set-Content $csvPath

$fruit = Import-Csv $csvPath
Write-Host "`nInhoud fruit.csv:"
$fruit

#converteren naar een custom object met integer voor het aantal
[array]$Copiedfruit = $null
$fruit | ForEach-Object {
    $Copiedfruit += [PSCustomObject]@{
        Fruit = $_.Fruit
        Aantal = [int]$_.Aantal
    }
}

#gesorteerde view
Write-Host "Fruit gesorteerd op aantal:"
$Copiedfruit | Sort-Object Aantal

#PS C:\Users\Younes> $Copiedfruit | Sort-Object Aantal

#Fruit   Aantal
#-----   ------
#Kersen       5
#Peren        8
#Appels      10
#Bananen     23

#nu gaan we een script maken dat punten opvraagt voor een aantal vakken en studenten 
#deze gaan we wegschrijven in een .csv 
#daarna het gemiddelde berekenen per vak 

function Lees-Punten {
    param (
        [int]$aantalVakken,
        [int]$aantalStudentens
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
    $data = Import-Csv punten.csv -Header("Vak1", "S1", "S2", "S3", "S4", "S5")
    $data | ForEach-Object {
        $gem = ($_.S1,$_.S2,$_.S3,$_.S4,$_.S5 | Where-Object {$_ -match "\d"} | Measure-Object -Average).Average
        Write-Host "$($_.Vak): Gemiddelde = {0:N2}" -f $gem
    }
}

#nu ga ik een script maken om te zien of een bepaalde website up is en schrijf ik dit weg in een log
function Check-Site {
    $logfile = "$HOME\site_check.log"
    while ($true) {
        $tijd = Get-Date
        $pingStatus = if (Test-Connection -ComputerName "localhost" -Count 1 -Quiet) { "SERVER UP" } else { "SERVER DOWN" }
        $httpStatus = if ((Invoke-WebRequest -Uri "http://localhost" -UseBasicParsing -ErrorAction SilentlyContinue).StatusCode -eq 200) { "WEB UP" } else { "WEB DOWN" }

        Add-Content $logfile "$pingStatus $tijd localhost"
        Add-Content $logfile "$httpStatus $tijd localhost"

        Start-Sleep 2
    }
}

#eerst ga ik de overtredingen CSV inlezen
$overtredingen = Import-Csv "$PSScriptRoot/../../datasets/a_overtredingen.csv"

#$overtredingen

#nu ga ik een functie maken waarbij ik more overtredingen eruit filter en alle records toon waarbij roodlicht overtredingen groter of gelijk aan is aan de grenswaarde
function More-Overtredingen($lijst, $grens){
    $lijst | Where-Object {
        [int]$_.aantal_overtredingen_roodlicht -ge $grens
    } | Select-Object datum_vaststelling, opnameplaats_straat, aantal_passanten, aantal_overtredingen_roodlicht
}

#Usage:
#More-Overtredingen $overtredingen 20
#een functie om alle UNIEKE straten eruit te filteren
function Get-Streets($lijst) {
    $lijst | Select-Object -ExpandProperty opnameplaats_straat -Unique
}

#Usage:
#Get-Streets $overtredingen

#nu maak ik een functie om het aantal overtredingen te tonen per straat 
function Sum-Overtredingen($lijst, $straat){
    ($lijst | Where-Object {
        $_.opnameplaats_straat -eq $straat
    } | Measure-Object -Property aantal_overtredingen_roodlicht -Sum).Sum 
}

#Usage
Sum-Overtredingen $overtredingen "MERKSEMHEIDELAAN"

























