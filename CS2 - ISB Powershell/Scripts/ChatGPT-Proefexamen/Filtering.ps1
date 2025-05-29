#lees alle granen in 
$granen = Import-Csv -Delimiter ";" cereal.csv
#zien of de file te vinden is
#Test-Path $granen

#geef de granen terug met minder dan 100 calorieen --> geen
#$granen | Where-Object { $_.calories -lt 200 } | Select-Object name

#som alle weights op met sugar > 10
#$granen | Where-Object { $_.sugars -gt 10 } | Measure-Object -Property weight -Sum

$overdredingen = Import-Csv ./a_overtredingen.csv

#geef alle overtredingen met >= 5 roodlichtovertredingen
#$overdredingen | Where-Object { $_.aantal_overtredingen_roodlicht -ge 5 } | Select-Object datum_vaststelling, opnameplaats_straat, aantal_passanten, aantal_overtredingen_roodlicht

#toon alle unieke straten 
#$overdredingen | Select-Object -ExpandProperty opnameplaats_straat -Unique

#som het aantal overtredingen per straat aflopend gesorteert 
#$overdredingen | Group-Object opnameplaats_straat | ForEach-Object {
#    [PSCustomObject]@{
#        Straat = $_.Name
#        Totaal = ($_.Group | Measure-Object -Property aantal_overtredingen_roodlicht -Sum).Sum
#    }
#} | Sort-Object Totaal -Descending

$macs = Import-Csv -Delimiter ";" ./MacTable.csv

#filter op een computernaam dat KDG bevat 
#$macs | Where-Object { $_.adaptername -like "Inte*" }

#verwijder alle mac adressen die ouder zijn dan 10 dagen 
#$maxDate = (Get-Date).AddDays(-1000)

#$macs | Where-Object {
#    -not [string]::IsNullOrWhiteSpace($_.date) -and
#    ([datetime]::ParseExact($_.date, 'dd/MM/yyyy HH:mm:ss', $null)) -gt $maxDate
#} | Export-Csv ./MacTableNEW.csv -NoTypeInformation

#geef het gemiddelde aantal calorieen per type
#$granen | Group-Object type | ForEach-Object {
#    [PSCustomObject]@{
#        Type = $_.Name
#        GemCalories = ($_.Group | Measure-Object calories -Average).Average
#    }
#}

#geef de top 5 granen met de meeste vezels
#$granen | Sort-Object fiber -Descending | Select-Object name, fiber -First 5

#mac adressen csv cleanen ik wil enkel de MAC + computer kolommen
$macs = Import-Csv ./MacTable.csv

$macs | ForEach-Object {
    [PSCustomObject]@{
        mac           = $_.'mac'
        computername  = $_.'computername'
    }
} | Export-Csv ./MacTable_clean.csv -NoTypeInformation