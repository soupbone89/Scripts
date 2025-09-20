## About
This script dumps NTDS database, along with SAM and SYSTEM files from the shadow copy on the DC. On a regular machine it will dump SAM and SYSTEM files only. You can find you files in `C:\Temp`. If the direcotry does not exist, the script will add it automatically.

## Usage
`PS > .\ntds.ps1`

`PS > ls C:\Temp`
