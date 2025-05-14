[array] $fibo = 1,1,2,3,5,8

#a - tel het 4de en 5de element op converteer naar een string en zet ze in $som
$som = [string]($fibo[3] + $fibo[4])

#b - converteer $som naar een integer en voeg toe aan de array
$fibo += [int]$som

$fibo

#Hoe kan je externe commando's opstarten die niet in een directory van het path staan? 
& "C:\MijnScripts\mijnprogramma.exe"

#of
$pad = "C:\MijnScripts\mijnprogramma.exe"
& $pad