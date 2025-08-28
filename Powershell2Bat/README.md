## About
Converts PowerShell scripts (`.ps1`) to batch files (`.bat`). Since the execution of PowerShell scripts is often closely monitored, running a batch file may appear less suspicious in log files.

Batch files are more common in enterprise environments, less suspicious to casual admins, and sometimes slip through basic whitelisting controls that would block `.ps1`

The script also encodes commands in Base64 for added obfuscation.

## Usage
`"C:\file.ps1 | P2B"`

or 

`P2B -Path "C:\Users\User\Desktop\example.ps1"`
