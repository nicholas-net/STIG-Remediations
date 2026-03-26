<#
.SYNOPSIS

    Disables saved credentials in the Remote Desktop Client by setting the DisablePasswordSaving registry value to 1.

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-26
    Last Modified   : 2026-03-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000270

.TESTED ON
    Date(s) Tested  : 2026-03-26
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
    
    if (-not (Test-Path -Path $regPath)) {
        
        #Create path if it doesn't exist
        New-Item -Path $regPath
    }

    Set-ItemProperty -Path $regPath -Name "DisablePasswordSaving" -Value 1

    #Check that the script ran and succesfully created register key

    if ((Get-ItemPropertyValue -Name "DisablePasswordSaving" -Path $regPath) -eq 1) {
    
        Write-Output "Password saving in the Remote Desktop Client disabled.`nDisablePasswordSaving Value: 1"

    }

    else {

        Write-Output "Error: DisablePasswordSaving was not set correctly. Please check permissions and registry path."
    }

  
  }
