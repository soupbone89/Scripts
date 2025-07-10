## About 
Extracts different types of browser data

## Syntax 

1) Get Chrome History

`Get-BrowserData -Browser chrome -DataType history
`

2) Get Edge Bookmarks

`Get-BrowserData -Browser edge -DataType bookmarks
`

3) Attempt naive Firefox history extraction

`Get-BrowserData -Browser firefox -DataType history
`

4) Provide a search pattern (e.g., only match "facebook")

`Get-BrowserData -Browser chrome -DataType history -Search "facebook"`
