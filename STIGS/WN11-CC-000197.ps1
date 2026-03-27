<#
.SYNOPSIS

    Turns off Microsoft Experiences to prevent the installation suggestions to the user.

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

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent\"

if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"

}

else {
    
    # Create the path
    if (-Not (Test-Path -Path $regPath)) {
        
        New-Item -Path $regPath 
        
    }

    # Turns off Microsoft Consumer Experiences
    Set-ItemProperty -Path $regPath -Name "DisableWindowsConsumerFeatures" -Value 1


    if ((Get-ItemPropertyValue -Path $regPath -Name "DisableWindowsConsumerFeatures") -eq 1) {
        
        Write-Output "Microsoft Experiences turned off.`nDisableWindowsConsumerFeatures Value: 1"

    }

    else {

        Write-Output "Error: DisableWindowsConsumerFeatures was not set correctly. Please check permissions and registry path."
    }
}
