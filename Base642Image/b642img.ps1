<#
.SYNOPSIS
    Convert images to Base64 and back.
.DESCRIPTION
    Contains two functions:
    1. img-b64 : Converts an image file to a Base64 string and saves it as encImage.txt
    2. b64-img : Decodes a Base64 string from a file and saves it as a JPG image
#>

function img-b64 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string]$img,

        [Parameter(Mandatory = $False)]
        [ValidateSet('desk', 'temp')]
        [string]$location
    )

    if (!$location) {$location = "desk"}

    $loc = switch ($location) {
        "desk" { "$Env:USERPROFILE\Desktop" }
        "temp" { "$env:TMP" }
    }

    [Convert]::ToBase64String((Get-Content -Path $img -Encoding Byte)) >> "$loc\encImage.txt"
    Write-Host "Encoded $img to $loc\encImage.txt"
}

function b64-img {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        [string]$file,

        [Parameter(Mandatory = $False)]
        [ValidateSet('desk', 'temp')]
        [string]$location
    )

    if (!$location) {$location = "desk"}

    $loc = switch ($location) {
        "desk" { "$Env:USERPROFILE\Desktop" }
        "temp" { "$env:TMP" }
    }

    Add-Type -AssemblyName System.Drawing

    $Base64 = Get-Content -Raw -Path $file
    $Image = [Drawing.Bitmap]::FromStream([IO.MemoryStream][Convert]::FromBase64String($Base64))
    $Image.Save("$loc\decImage.jpg")
    Write-Host "Decoded $file to $loc\decImage.jpg"
}
