try {
    $n = Read-Host "Geef een aantal getallen in:"
    $n = [int]$n  # getallen omzetten naar een int

    if ($n -lt 1) {
        throw "Aantal moet minstens 1 zijn."
    }

    $fibo = @(0, 1)  # start de reeks met 0 en 1

    # enkel extra getallen berekenen als n > 2
    for ($i = 2; $i -lt $n; $i++) {
        $fibo += $fibo[$i - 1] + $fibo[$i - 2]
    }

    # toon de reeks
    $fibo[0..($n -1)]
}
catch {
    Write-Host "Fout bij invoer of berekening!" -ForegroundColor Red
}

./Get-Fibo.ps1
Geef aantal getallen in: 5