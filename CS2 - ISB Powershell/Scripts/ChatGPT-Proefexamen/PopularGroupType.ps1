function Popular-Group {
    $data = Import-Csv -Delimiter ";" ./cereal.csv
    $group = $data | Group-Object type | Sort-Object Count -Descending
    $top = $group[0]

    if ($null -eq $top) {
        Write-Host "Geen gegevens beschikbaar!" -ForegroundColor Red
    } else {
        Write-Host "Populairste graantype: $($top.Name) $($top.Count) keer" -ForegroundColor Green
    }   
}

Popular-Group