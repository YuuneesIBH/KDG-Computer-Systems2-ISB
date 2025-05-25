<#
.SYNOPSIS
Maakt de som van twee getallen

.DESCRIPTION
Drukt de som af van 2 getallen die als paramter gegeven worden. 

.EXAMPLE
PS> Maak-Som 3 4 
3 + 4 = 7
#>

#hieronder maak ik het effectieve script (logica):
if ($args.count -ne 2) {
	Write-Output "Gebruik: Maak-Som.ps1 getal1 getal2"
} else {
	Write-Output ($args[0] + $args[1])
}