<#
.SYNOPSIS

    Disables indexing of encrypted files in Windows by setting the AllowIndexingEncryptedStoresOrItems registry value to 0

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-26
    Last Modified   : 2026-03-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000305

.TESTED ON
    Date(s) Tested  : 2026-03-26
    Tested By       : Nicholas Colon
    Systems Tested  : Windows 11 Pro (Azure VM) - Build 26200
    PowerShell Ver. : 5.1
#>

# Define the registry path
$regPath = "\SOFTWARE\Policies\Microsoft\Windows\Windows Search\"


if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"

}

else {
    
    if (-not (Test-Path -Path $regPath)) {
        
        #Create path if it doesn't exist
        New-Item -Path $regPath
    }

    Set-ItemProperty -Path $regPath -Name "AllowIndexingEncryptedStoresOrItems" -Value 0

    #Check that the script ran and succesfully created register key

    if ((Get-ItemPropertyValue -Name "AllowIndexingEncryptedStoresOrItems" -Path $regPath) -eq 0) {
    
        Write-Output "Encrypted file indexing disabled.`nAllowIndexingEncryptedStoresOrItems Value: 0"

    }

    else {

        Write-Output "Error: AllowIndexingEncryptedStoresOrItems was not set correctly. Please check permissions and registry path."
    }

  
  }
