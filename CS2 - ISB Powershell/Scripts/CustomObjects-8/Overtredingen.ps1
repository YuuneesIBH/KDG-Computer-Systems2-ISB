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