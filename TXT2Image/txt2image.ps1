function txt-img {
[CmdletBinding()]
param (

[Parameter (Mandatory = $True, ValueFromPipeline = $True)]
[string]$txtPath,

[Parameter (Mandatory = $False)]
[string]$imgPath
)

if (!$imgPath) {$imgPath = "$Env:USERPROFILE\Desktop\foo.jpg"}

$content = [IO.File]::ReadAllText($txtPath)
Add-Type -AssemblyName System.Drawing
$bmp = new-object System.Drawing.Bitmap 1920,1080 
$font = new-object System.Drawing.Font Consolas,18 
$brushBg = [System.Drawing.Brushes]::White 
$brushFg = [System.Drawing.Brushes]::Black 
$graphics = [System.Drawing.Graphics]::FromImage($bmp) 
$graphics.FillRectangle($brushBg,0,0,$bmp.Width,$bmp.Height) 
$graphics.DrawString($content,$font,$brushFg,500,100) 
$graphics.Dispose() 
$bmp.Save($imgPath) 
}
