## About
Retrieves SSH keys from a target system, and ssh attempts from powershell history.

## Syntax
By default it will check the expected directory, though you have the option to supply one yourself

1. Obtain data and assign it to a variable. Your loot will be base64 encoded
$data = Get-Ssh

You can also specify the directory yourself
$data = Get-Ssh -sshKeyDirectoryPath "C:\Custom\Path\To\.ssh

2. Decode the loot
[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($base64))
