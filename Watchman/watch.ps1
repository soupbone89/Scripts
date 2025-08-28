
# Import Windows Forms once at the top
Add-Type -AssemblyName System.Windows.Forms

function Target-Comes {
    $originalPOS = [System.Windows.Forms.Cursor]::Position.X
    $o = New-Object -ComObject WScript.Shell

    while ($true) {
        $pauseTime = 3
        if ([System.Windows.Forms.Cursor]::Position.X -ne $originalPOS) {
            break
        }
        else {
            $o.SendKeys("{CAPSLOCK}")
            Start-Sleep -Seconds $pauseTime
        }
    }
}

function Target-Leaves {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [Int]$Seconds
    ) 

    while ($true) {
        $originalPOS = [System.Windows.Forms.Cursor]::Position.X
        Start-Sleep -Seconds $Seconds
        if ([System.Windows.Forms.Cursor]::Position.X -eq $originalPOS) {
            break
        }
        else {
            Start-Sleep -Seconds 1
        }
    }
}
