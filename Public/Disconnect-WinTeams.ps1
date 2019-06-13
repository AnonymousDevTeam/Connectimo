function Disconnect-WinTeams {
    [CmdletBinding()]
    param(
        [string] $SessionName = 'Microsoft Teams',
        [switch] $Output
    )
    $Object = @()
    try {
        Disconnect-MicrosoftTeams -ErrorAction Stop
    } catch {
        $ErrorMessage = $_.Exception.Message -replace "`n", " " -replace "`r", " "
        if ($ErrorMessage -like "*Object reference not set to an instance of an object.*") {
            $Object += @{ Status = $false; Output = $SessionName; Extended = "Disconnection failed. No connection exists." }
        } else {
            $Object += @{ Status = $false; Output = $SessionName; Extended = "Disconnection failed. Error: $ErrorMessage" }
        }
        if ($Output) {
            return $Object
        } else {
            Write-Warning "Disconnect-MicrosoftTeams - Failed with error message: $ErrorMessage"
            return
        }
    }
    if ($Output) {
        $Object += @{ Status = $true; Output = $SessionName; Extended = "Disconnection succeeded." }
        return $Object
    }
}