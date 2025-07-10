function Get-BrowserData {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('chrome','edge','firefox')]
        [string]$Browser,
        [Parameter(Mandatory)]
        [ValidateSet('history','bookmarks')]
        [string]$DataType,
        # Optional pattern if you only want to match certain URLs
        [string]$Search = '.'
    )
    # Regex to find URLs in raw text
    $Regex = '(http|https)://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
    # Identify the path for each browser/type combination
    switch ("$Browser`_$DataType") {
        'chrome_history' {
            $Path = "$Env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\History"
        }
        'chrome_bookmarks' {
            $Path = "$Env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Bookmarks"
        }
        'edge_history' {
            $Path = "$Env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\Default\History"
        }
        'edge_bookmarks' {
            $Path = "$Env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks"
        }
        'firefox_history' {
            # STILL naive, might catch some ASCII references in places.sqlite
            $Path = "$Env:USERPROFILE\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release\places.sqlite"
        }
        'firefox_bookmarks' {
            Write-Warning "Firefox bookmarks are not supported with this naive regex approach."
            return
        }
        default {
            Write-Warning "Invalid combination: $Browser $DataType"
            return
        }
    }
    # Ensure the file exists
    if (-not (Test-Path $Path)) {
        Write-Warning "File not found: $Path"
        return
    }
    # Read and regex-match
    Get-Content -Path $Path -ErrorAction SilentlyContinue |
        Select-String -AllMatches $Regex |
        ForEach-Object { $_.Matches.Value } |
        Sort-Object -Unique |
        Where-Object { $_ -match $Search } |
        ForEach-Object {
            [PSCustomObject]@{
                User     = $env:UserName
                Browser  = $Browser
                DataType = $DataType
                URL      = $_
            }
        }
}
