# BONE-Macs.ps1
$path = "./MacTable.csv"

if (!(Test-Path $path)) {
    Write-Host "Bestand is NIET gevonden!" -ForegroundColor Red
    exit 1 
}

$macs = Import-Csv -Delimiter "," $path

if ($macs.Count -eq 0) {
    Write-Host "Je hebt een leeg bestand geimporteerd!" -ForegroundColor Red
    exit 1
}

# 1. Toon unieke MAC-adressen
function Unique-Macs ($macs) {
    # TODO: Group-Object op mac en return 1 object per groep
    return $macs | Group-Object -Property mac | ForEach-Object {
        $_.Group[0]
    }
}

# 2. Filter op computernamen die beginnen met prefix
function Filter-Computers ($macs, $prefix) {
    $result = $macs | Where-Object {
        $_.computername -match "^$prefix"
    }

    if ($result.Count -eq 0) {
        Write-Host "Geen computers gevonden met prefix '$prefix'" -ForegroundColor Red
    }

    return $result
}

# 3. Verwijder MACs ouder dan x dagen
function Clean-OldMacs ($macs, $dagen) {
    $grens = (Get-Date).AddDays(-$dagen)

    return $macs | Where-Object {
        $datum = [datetime]::ParseExact($_.date, "dd/MM/yyyy H:mm:ss", $null)
        $datum -ge $grens
    } | Export-Csv "Hallo.csv"
}

# ===================================
# Hoofdprogramma: hier niks wijzigen
# Linux: vervang alle Out-GridView door Format-Table
# Haal de lijnen uit commentaar voor de functies die werken
# Voor functies die niet werken: laat deze in commentaar staan
# Zo lever je een werkend script af
# ===================================

$prefix = "KDG"
$drempel = 30

#Unique-Macs $macs | Format-Table
#Filter-Computers $macs $prefix | Format-Table
Clean-OldMacs $macs $drempel | Format-Table