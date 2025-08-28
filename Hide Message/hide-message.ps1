function Hide-Msg {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Path,

        [Parameter(Mandatory=$false)]
        [string]$Message = "Hidden message"
    )

    $tempFile = Join-Path $env:TEMP "foo.txt"
    "`n`n $Message" | Out-File -FilePath $tempFile -Encoding ascii -Force

    cmd.exe /c "copy /b `"$Path`" + `"$tempFile`" `"$Path`"" | Out-Null

    Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
}
