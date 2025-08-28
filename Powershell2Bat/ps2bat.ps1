function P2B {
    param
    (
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]
        $Path
    )
 
    process
    {
        $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content -Path $Path -Raw -Encoding UTF8)))
        $newPath = [Io.Path]::ChangeExtension($Path, ".bat")
        "@echo off`npowershell -w h -NoP -NonI -Exec Bypass -enc $encoded" | Set-Content -Path $newPath -Encoding Ascii
    }
}
