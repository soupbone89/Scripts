function DropBox-Upload {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [Alias("f")]
        [string]$SourceFilePath
    )

    # Your Dropbox Access Token
    $DropBoxAccessToken = "YOUR-DROPBOX-ACCESS-TOKEN-HERE"

    # Helper: Check for Cyrillic characters
    function Has-Cyrillic($input) {
        return [regex]::IsMatch($input, '[\p{IsCyrillic}]')
    }

    # Helper: Generate random file name
    function Get-RandomFileName($extension) {
        return [System.IO.Path]::GetRandomFileName().Replace(".", "") + $extension
    }

    # Prepare the source
    $fileName = Split-Path $SourceFilePath -Leaf
    $targetPath = $SourceFilePath

    # If Cyrillic, generate random name and copy locally
    if (Has-Cyrillic $fileName) {
        $ext = [System.IO.Path]::GetExtension($fileName)
        $randomName = Get-RandomFileName $ext
        $publicDir = 'C:\Users\Public\Documents'
        $newPath = Join-Path $publicDir $randomName
        Copy-Item -Path $SourceFilePath -Destination $newPath -Force
        $targetPath = $newPath
        $fileName = $randomName
    }

    # Dropbox API setup (fix newline issue in JSON string)
    $dropboxArg = [Text.Encoding]::UTF8.GetBytes((@{
        path = "/$fileName"
        mode = 'add'
        autorename = $true
        mute = $false
    } | ConvertTo-Json -Compress))

    $headers = @{
        'Authorization' = "Bearer $DropBoxAccessToken"
        'Dropbox-API-Arg' = [Text.Encoding]::UTF8.GetString($dropboxArg)
        'Content-Type' = 'application/octet-stream'
    }

    # Upload
    Invoke-RestMethod -Uri 'https://content.dropboxapi.com/2/files/upload' -Method Post -InFile $targetPath -Headers $headers

    # Cleanup if needed
    if ($targetPath -ne $SourceFilePath) { Remove-Item -Path $targetPath -Force }
}
