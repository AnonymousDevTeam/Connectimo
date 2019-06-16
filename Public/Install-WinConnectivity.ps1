function Install-WinConnectity {
    [CmdletBinding()]
    param(
        [ValidateSet('MSOnline', 'AzureAD', 'SharePoint', 'ExchangeOnline','Teams' )][string[]] $Module,
        [switch] $All,
        [switch] $Force
    )

    $Splat = @{
        Force = $Force
    }

    if ($Module -eq 'MSOnline' -or $All) {
        Write-Verbose "Installing MSOnline Powershell Module"
        Install-Module -Name MSOnline @Splat
    }
    if ($Module -eq 'AzureAD' -or $All) {
        Write-Verbose "Installing AzureAD Powershell Module"
        Install-Module -Name AzureAD @Splat
    }
    #Install-Module SkypeOnlineConnector
    if ($Module -eq 'SharePoint' -or $All) {
        Write-Verbose "Installing Microsoft SharePoint Online Powershell Module"
        Install-Module -Name Microsoft.Online.SharePoint.PowerShell @Splat
    }
    if ($Module -eq 'ExchangeOnline' -or $All) {
        Write-Verbose "Checking for Microsoft Exchange Online Powershell Module"
        $App = Test-InstalledApplication -DisplayName "Microsoft Exchange Online Powershell Module"
        if ($null -eq $App) {
            # Manifest for Exchange Online Click Once App
            Write-Verbose "Installing Microsoft Exchange Online Powershell Module"
            Install-ApplicationClickOnce -Manifest "https://cmdletpswmodule.blob.core.windows.net/exopsmodule/Microsoft.Online.CSE.PSModule.Client.application" -ElevatePermissions
        }
    }
    if ($Module -eq 'Teams' -or $All) {
        Write-Verbose "Installing Microsoft Teams Powershell Module"
        Install-Module -Name MicrosoftTeams @Splat
    }
}