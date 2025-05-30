function Search-Oldest {
    $data = Import-Csv -Delimiter "," ./MacTable.csv
    $datums = $data | Select-Object -ExpandProperty date | ForEach-Object { Get-Date $_}
    $oudste = $datums | Sort-Object -Descending | Select-Object -First 1

    #descending en ik pak de nieuwste
    Write-Host "Oudste vermelding in de MAC-table: $oudste"
}

Search-Oldest