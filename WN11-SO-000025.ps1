<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-19
    Last Modified   : 2026-03-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000025

.TESTED ON
    Date(s) Tested  : 2026-03-19
    Tested By       : Nicholas Colon
    Systems Tested  : Windows 11 Pro (Azure VM) - Build 26200
    PowerShell Ver. : 5.1
#>

# Define the obfuscated target name
$NewName= "LocalApp_Svc"

# Retrieve account by immutable SID
$GuestAccount = Get-LocalUser -SID S-1-5-21-800289325-3076522124-3339412034-501

# Check if the current name differs from the target name
if ($NewName -ne $GuestAccount.Name) {

    # Apply the obfuscated name to the Guest object
    Rename-LocalUser -Name $GuestAccount.Name -NewName $NewName

    # Ensure the Guest account is disabled 
    Disable-LocalUser -InputObject $GuestAccount

}
