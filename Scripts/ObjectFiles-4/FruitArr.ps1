$fruit = "meloen;2;stuk", "appel;3;kg", "banaan;4;kg", "kokosnoot;5;stuk"

#Converteren naar een object met propery names
$fruit = $fruit | ConvertFrom-Csv -Delimiter ";" -Header "naam", "prijs", "eenheid"

#tonen op het scherm
$fruit
$fruit.naam
$fruit[0]
$fruit[3].prijs

#converteer naar JSON
$fruit | ConvertTo-Json | Out-File fruit.json