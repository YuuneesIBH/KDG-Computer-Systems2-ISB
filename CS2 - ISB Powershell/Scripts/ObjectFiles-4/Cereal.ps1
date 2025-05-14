#path assignen naar het bestand
$path = "$HOME\Downloads\cereal.csv"

#toon alle granen van type H
Import-Csv $path -Delimiter ";" | Where-Object { $_.type -eq "H" }

#hoeveel granen met calorieen gelijk aan 50 
Import-Csv $path -Delimiter ";" | Where-Object { $_.calories -eq "50" } | Measure-Object
#count 
(Import-Csv $path -Delimiter ";" | Where-Object { $_.calories -eq "50" }).Count

#wat is het type weight na import? 
$cereals = Import-Csv $path -Delimiter ";"
$cereals[0].weight.GetType().FullName

#stop het totaalgewicht in $TotWeight voor granen met calorien = 50
$TotWeight = (
    Import-Csv $path -Delimiter ";" |
    Where-Object { $_.calories -eq "50" } |
    ForEach-Object { [double]$_.weight }
) | Measure-Object -Sum

$TotWeight.Sum