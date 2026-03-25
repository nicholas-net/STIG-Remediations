<#
.SYNOPSIS

    Ensures the account lockout threshold is set to 3 invalid logon attempts to prevent brute-force attacks on local accounts.

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-25
    Last Modified   : 2026-03-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010 

.TESTED ON
    Date(s) Tested  : 2026-03-25
    Tested By       : Nicholas Colon
    Systems Tested  : Windows 11 Pro (Azure VM) - Build 26200
    PowerShell Ver. : 5.1
#>


if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"

}


else {
    
    # Set the maximum number of attempted logins before locking at 3 (currently configed to reset attempts every 10 minutes)
    net accounts /lockoutthreshold:3

    $output = net accounts

    $thresholdline = $output | Where-Object { $_ -match "Lockout threshold" }

    $thresholdvalue = [int]($thresholdline -split " ")[-1]


    if (($thresholdvalue) -eq 3) {
        
         Write-Output "Account lockout threshold successfully configured at 3"
    } else {

        Write-Output "Error: Account lockout threshold was not set correctly. Current value: $thresholdvalue"
    }


}

