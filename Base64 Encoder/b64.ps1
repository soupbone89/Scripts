function B64 {
[CmdletBinding(DefaultParameterSetName="encFile")]
param(
    [Parameter(Position=0, ParameterSetName="encFile")]
    [Alias("ef")]
    [string]$encFile,

    [Parameter(Position=0, ParameterSetName="encString")]
    [Alias("es")]
    [string]$encString,

    [Parameter(Position=0, ParameterSetName="decFile")]
    [Alias("df")]
    [string]$decFile,

    [Parameter(Position=0, ParameterSetName="decString")]
    [Alias("ds")]
    [string]$decString

)

if ($psCmdlet.ParameterSetName -eq "encFile") {
		$encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content -Path $encFile -Raw -Encoding UTF8)))
		return $encoded
		}

elseif ($psCmdlet.ParameterSetName -eq "encString") {
		$encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($encString))
		return  $encoded
		}

elseif ($psCmdlet.ParameterSetName -eq "decFile") {
		$data = Get-Content $decFile
		$decoded = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($data))
		return $decoded		
		}

elseif ($psCmdlet.ParameterSetName -eq "decString") {		
		$decoded = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($decString))
		return $decoded
		}
}
