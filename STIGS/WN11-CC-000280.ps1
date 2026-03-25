<#
.SYNOPSIS
    
    This PowerShell script ensures that Remote Desktop Services always prompts for a password upon connection by configuring the appropriate registry value.

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-25
    Last Modified   : 2026-03-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000280 

.TESTED ON
    Date(s) Tested  : 2026-03-25
    Tested By       : Nicholas Colon
    Systems Tested  : Windows 11 Pro (Azure VM) - Build 26200
    PowerShell Ver. : 5.1
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\"

if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"

}

else {
    
    # Create the path
    if (-Not (Test-Path -Path $regPath)) {
        
        New-Item -Path $regPath 
        
    }

    # Enable password prompts for Remote Desktop Services
    Set-ItemProperty -Path $regPath -Name "fPromptForPassword" -Value 1


    if ((Get-ItemPropertyValue -Path $regPath -Name "fPromptForPassword") -eq 1) {
        
        Write-Output "Password prompts for Remote Desktop Services successfully enabled`nfPromptForPassword Value: 1"

    }

    else {

        Write-Output "Error: fPromptForPassword was not set correctly. Please check permissions and registry path."
    }

}
