$proc = Get-Process | Where-Object { $_.Name -like "m*" }
$proc | Stop-Process

#a - toon inhoud van het process
$proc

#b - welke soort variabele is proc?
$proc | Get-Member

#c - toon het 4de element van $proc
$proc[3]

#hoeveel processen heb ik gevonden?
$proc.Count