<#
.SYNOPSIS

    This PowerShell script ensures the Windows Installer ‘Always install with elevated privileges’ setting is disabled by configuring the appropriate registry value.

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-25
    Last Modified   : 2026-03-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315 

.TESTED ON
    Date(s) Tested  : 2026-03-25
    Tested By       : Nicholas Colon
    Systems Tested  : Windows 11 Pro (Azure VM) - Build 26200
    PowerShell Ver. : 5.1
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer\"

if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    
    Write-Output "You do not have Administrator rights to run this script!nPlease re-run this script as an Administrator!"

}

else {
    
    if (-Not (Test-Path -Path $regPath) ) {

    # Create the path
    New-Item -Path $regPath    

    } 

    # Disables "Always install with elevated privileges"
    Set-ItemProperty -Path $regPath -Name "AlwaysInstallElevated" -Value 0
    
    if ((Get-ItemPropertyValue -Name "AlwaysInstallElevated" -Path $regPath) -eq 0) {
        
         Write-Output "Windows Installer feature 'Always install with elevated privileges'`nSuccessfully disabled AlwaysInstallElevated Value: 0"
    }

    else {
        
        Write-Output "Error: AlwaysInstallElevated was not set correctly. Please check permissions and registry path."
    }

}
