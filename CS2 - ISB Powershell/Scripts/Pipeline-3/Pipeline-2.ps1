#Object $datum aanmaken met huidige datum
$datum = Get-Date
$datum

$datum.AddDays(1)

$datum.DayOfWeek
(Get-Date).DayOfWeek

Get-Process | Get-Member
$processes = Get-Process
$processes[9]
$processes[9].ProcessName
$processes.ProcessName

#String methods en array methods
"" | Get-Member
"Hallo Wereld".Substring(2,5)

$rij = 1,2
Get-Member -InputObject $rij

$rij.Length

#Where-Object, Foreach-Object

Get-Process | Where-Object { $_.Name -like "w*" }
Get-Process | Where-Object { $_.Id -lt 1000 }
Get-Service | ? { $_.Status -eq "Running" } | Select-Object FullName

#$_ is het laatst gebruikte object
#vergelijkingsoperatoren -eq, -ne, -lt, -le, -gt, -ge, -like, -not, !, -and, -or

#Foreach verkorte vorm voor de lus
Get-Process notepad | ForEach-Object { $_.Id }
Get-Process notepad | % { $_.Kill() }
Get-Process | % { $a += $_.Id }; $a