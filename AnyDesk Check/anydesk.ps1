# path to files
$blorfGix = Join-Path $PSScriptRoot "hosts.txt"
$psexecZap = Join-Path $PSScriptRoot "PsExec64.exe"

# credentials
$torakan = "DOMAIN.LOCAL\admin"
$shibPass = "password"

# reading hosts
$klomFex = Get-Content -Path $blorfGix

foreach ($nurka in $klomFex) {
    # status check
    if (Test-Connection -ComputerName $nurka -Count 1 -Quiet) {
        # PsExec if alive
        try {
            # running dir to view the output
            $dirOut = & $psexecZap "\\$nurka" -accepteula -i -s -u $torakan -p $shibPass cmd /c 'dir "C:\Program Files (x86)"'
            
            # looking for AnyDesk
            if ($dirOut -match "AnyDesk") {
                Write-Host "[$nurka] — AnyDesk found" -ForegroundColor Green
            }
            else {
                Write-Host "[$nurka] — AnyDesk not found" -ForegroundColor Yellow
            }
        }
        catch {
            Write-Host "[$nurka] — error starting PsExec: $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "[$nurka] — not accessible with ICMP" -ForegroundColor DarkGray
    }
}
