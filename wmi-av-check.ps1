<#
.SYNOPSIS
    Query AV product on a list of remote hosts via WMI.

.DESCRIPTION
    Reads hostnames (or IPs) from hosts.txt (one entry per line), prompts
    once for local Administrator credentials, then for each host:
     1. Tests network connectivity via Test-Connection.
     2. If alive, runs Get-WmiObject against root\SecurityCenter2 to retrieve
        AntiVirusProduct entries.
     3. Outputs either the AV details or a descriptive error.

.NOTES
    Run this script from an elevated PowerShell session.
    Ensure File and Printer Sharing (RPC/DCOM) is allowed through any firewalls.
#>

# Prompt for local Administrator credential once
$credential = Get-Credential -UserName 'Администратор' -Message 'Enter local admin credentials for remote hosts'

# Path to the file containing your list of hosts (one per line)
$hostsFile = Join-Path $PSScriptRoot 'hosts.txt'

if (-Not (Test-Path $hostsFile)) {
    Write-Error "Cannot find hosts.txt in $PSScriptRoot; please create it with one host per line."
    exit 1
}

# Read all non-empty, non-comment lines
$hosts = Get-Content $hostsFile | ForEach-Object { $_.Trim() } | Where-Object { $_ -and -Not $_.StartsWith('#') }

foreach ($host in $hosts) {
    Write-Host "== $host ==" -ForegroundColor Cyan

    # Ping-test
    if (-Not (Test-Connection -ComputerName $host -Count 1 -Quiet -TimeoutSeconds 1)) {
        Write-Host "$host: No network response." -ForegroundColor DarkGray
        continue
    }

    # Query WMI for AV products
    try {
        $av = Get-WmiObject `
            -Namespace 'root\SecurityCenter2' `
            -Class AntiVirusProduct `
            -ComputerName $host `
            -Credential $credential `
            -ErrorAction Stop

        if ($av) {
            $av | Select-Object PSComputerName, displayName, pathToSignedProductExe, productState |
                Format-Table -AutoSize
        }
        else {
            Write-Host "$host: No AV product registered." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "$host: WMI query failed – $($_.Exception.Message)" -ForegroundColor Red
    }

    Write-Host  # blank line
}
