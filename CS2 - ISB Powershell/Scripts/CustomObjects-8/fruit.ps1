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