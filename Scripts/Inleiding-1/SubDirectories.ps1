$sourcePath = "C:\Program Files"
$outputFile = "$home\Documents\out.txt"

Get-ChildItem -Path $sourcePath -Directory | Where-Object { $_.Name -like "w*" } | Out-File -FilePath $outputFile

#a - toon de inhoud van de file met Linux alias
cat "$home\Documents\out.txt"