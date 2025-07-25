param(
    [Parameter(Mandatory=$true)]
    [Alias("o")]
    [string]$OutputDir
)

# Resolve the output directory path
$resolvedOutput = Resolve-Path $OutputDir -ErrorAction SilentlyContinue
if (-not $resolvedOutput) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
    $resolvedOutput = Resolve-Path $OutputDir
} else {
    $resolvedOutput = $resolvedOutput.Path
}

# Get current timestamp
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Get all user directories under C:\Users
$users = Get-ChildItem "C:\Users" | Where-Object { $_.PSIsContainer }

foreach ($user in $users) {
    $UserName = $user.Name
    $OutputFile = Join-Path $resolvedOutput "$UserName-history_$timestamp.txt"
    
    "Command History for $UserName" | Out-File -FilePath $OutputFile -Encoding UTF8
    "===================================" | Out-File -FilePath $OutputFile -Append -Encoding UTF8
    "`n" | Out-File -FilePath $OutputFile -Append -Encoding UTF8

    # Append PowerShell History
    $PSHistoryPath = "C:\Users\$UserName\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
    if (Test-Path $PSHistoryPath) {
        "[PowerShell History]" | Out-File -FilePath $OutputFile -Append -Encoding UTF8
        Get-Content $PSHistoryPath | Out-File -FilePath $OutputFile -Append -Encoding UTF8
        "`n" | Out-File -FilePath $OutputFile -Append -Encoding UTF8
    }

    # Append CMD History using DOSKEY (session-based)
    "[CMD History]" | Out-File -FilePath $OutputFile -Append -Encoding UTF8
    $cmdHistory = cmd.exe /c "doskey /history"
    $cmdHistory | Out-File -FilePath $OutputFile -Append -Encoding UTF8
}

Write-Host "Command history saved to $resolvedOutput"
