<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-20
    Last Modified   : 2026-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110

.TESTED ON
    Date(s) Tested  : 2026-03-20
    Tested By       : Nicholas Colon
    Systems Tested  : Windows 11 Pro (Azure VM) - Build 26200
    PowerShell Ver. : 5.1
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\"

if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"

}

else {
    
    if (-Not (Test-Path -Path $regPath) ) {

    # Create the path
    New-Item -Path $regPath    

    } 

    # Disables printing over HTTP protocol
    Set-ItemProperty -Path $regPath -Name DisableHTTPPrinting -Value 1

    # Verify DisableHTTPPrinting's value
    if ((Get-ItemPropertyValue -Path $regPath -Name DisableHTTPPrinting) -eq 1) {

        Write-Output "HTTP Printing successfully disabled`nDisableHTTPPrinting Value: 1"

    } 
    
    else {
        
        Write-Output "Error: DisableHTTPPrinting was not set correctly. Please check permissions and registry path."

        exit
    }

}


