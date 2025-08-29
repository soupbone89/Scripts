## About
PowerShell Base64 encoding may seem complicated at first, but it is extremely useful when dealing with small file transfers. Base64 ensures that the original state of the file is preserved, avoiding corruption or formatting issues. In fact, some commands can break if copied and pasted directly without Base64 encoding, making it a reliable method for safe and consistent execution.

## Usage
Encode a file

`B64 -encFile "C:\Users\User\Desktop\example.txt"`

Decode a file

`B64 -decFile "C:\Users\User\Desktop\example.txt"`

Encode a string (Important: When working with strings, always wrap them in single quotes)

`B64 -encString 'start notepad'`

Decode a string

`B64 -decString 'cwB0AGEAcgB0ACAAbgBvAHQAZQBwAGEAZAA='`

Copy the output to the clip

`COMMAND | clip`
