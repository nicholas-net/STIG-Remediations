<#
.SYNOPSIS

    Enables authentication request after a system wakes up from Sleep mode. ACSettingIndex value set to 1

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-26
    Last Modified   : 2026-03-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000150

.TESTED ON
    Date(s) Tested  : 2026-03-26
    Tested By       : Nicholas Colon
    Systems Tested  : Windows 11 Pro (Azure VM) - Build 26200
    PowerShell Ver. : 5.1
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51\"
# Start at the root key
$currentPath = "HKLM:"


if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"

}

else {
    
    # Check if the registry path exists
    if (-not (Test-Path -Path $regPath)) {
    
        #Split the path into multiple strings in an array
         $regPath = $regPath -split "\\"

        # Slice the array to start at the first subkey
        $subKeys = $regPath[1..($regPath.Length - 1)]

        # Loop through each sub key
        foreach ($level in $subKeys) {

            $currentPath = $currentPath + "\\" + $level
            
            # If the current path does not exist in the registry, create that path
            if ( -not (Test-Path -Path $currentPath)) {

               New-Item -Path $currentPath
             
            }
        
        }

    }
    
    Set-ItemProperty -Path $regPath -Name "ACSettingIndex" -Value 1

    # Check that the script ran and succesfully created register key

    if ((Get-ItemPropertyValue -Name "ACSettingIndex" -Path $regPath) -eq 1) {
    
        Write-Output "Post sleep mode authentication request enabled.`nACSettingIndex Value: 1"

    }

    else {

        Write-Output "Error:  ACSettingIndex was not set correctly. Please check permissions and registry path."
    }

  
  }
