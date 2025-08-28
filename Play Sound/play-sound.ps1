function PlaySound {
    [CmdletBinding()]
    param (	
        [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
        [string]$File
    )

    if (-Not (Test-Path $File)) {
        Write-Error "File '$File' not found."
        return
    }

    try {
        $PlaySound = New-Object System.Media.SoundPlayer
        $PlaySound.SoundLocation = $File
        $PlaySound.PlaySync()   # Waits until sound finishes playing
    }
    catch {
        Write-Error "Could not play sound file: $_"
    }
}
