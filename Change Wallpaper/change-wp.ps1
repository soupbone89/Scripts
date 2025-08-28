## Usage
## Set-WallPaper -Image "C:\Users\Public\Pictures\Sample.jpg" -Style Fit
## Supported image formats: BMP, JPG, PNG, but Windows internally prefers BMP. If you use JPG/PNG, Windows may convert it behind the scenes.

function Set-WallPaper {
<#
.SYNOPSIS
    Applies a specified wallpaper to the current user's desktop.

.PARAMETER Image
    Provide the full path to the image file.

.PARAMETER Style
    Specify the wallpaper style. Valid values:
    Fill, Fit, Stretch, Tile, Center, Span.

.EXAMPLE
    Set-WallPaper -Image "C:\Wallpaper\Default.jpg"
    Set-WallPaper -Image "C:\Wallpaper\Background.jpg" -Style Fit
#>

    param (
        [parameter(Mandatory = $True)]
        [string]$Image,

        [parameter(Mandatory = $False)]
        [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
        [string]$Style = "Fill"
    )

    # Map wallpaper styles to registry values
    $WallpaperStyle = switch ($Style) {
        "Fill"    { "10" }
        "Fit"     { "6" }
        "Stretch" { "2" }
        "Tile"    { "0" }
        "Center"  { "0" }
        "Span"    { "22" }
    }

    if ($Style -eq "Tile") {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value $WallpaperStyle -Force
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -Value 1 -Force
    }
    else {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value $WallpaperStyle -Force
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -Value 0 -Force
    }

    # Add P/Invoke definition for SystemParametersInfo
    Add-Type -TypeDefinition @"
using System; 
using System.Runtime.InteropServices;
  
public class Params {
    [DllImport("User32.dll", CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo(
        Int32 uAction, Int32 uParam, String lpvParam, Int32 fuWinIni);
}
"@

    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile        = 0x01
    $SendChangeEvent      = 0x02
    $fWinIni              = $UpdateIniFile -bor $SendChangeEvent

    # Apply the new wallpaper
    [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni) | Out-Null
}
