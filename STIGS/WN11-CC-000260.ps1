<#
.SYNOPSIS

    Configures Windows 11 to enforce a minimum PIN length of eight characters for authentication. 
    Ensures the required registry path and value exist, sets MinimumPINLength to a compliant value, and verifies the configuration to strengthen security against brute-force attempts.

.NOTES
    Author          : Nicholas Colon
    LinkedIn        : linkedin.com/in/nick-colon
    GitHub          : github.com/nicholas-net
    Date Created    : 2026-03-26
    Last Modified   : 2026-03-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000260

.TESTED ON
    Date(s) Tested  : 2026-03-26
    Tested By       : Nicholas Colon
    Systems Tested  : Windows 11 Pro (Azure VM) - Build 26200
    PowerShell Ver. : 5.1
#>

$targetPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity\"
$basePath = "HKLM:"


if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"

}

else {

    if (-not(Test-Path -Path $targetPath)) {

        # Split the string into an array
        $targetPath = $targetPath -split "\\"
        
        # Slice the array to begin at the first sub-key
        $subKeys = $targetPath[1..$targetPath.Length]
        

        # Loop through each subkey 
        foreach ($level in $subKeys) {
            
           $basePath = $basePath + "\\" + $level
           $regPath = $basePath

           if (-not(Test-Path -Path $basePath)) {

                New-Item -Path $basePath
                
           }
           
        }

        Set-ItemProperty -Path $regPath -Name "MinimumPINLength" -Value 8
    }
    
    #Check that the script ran and succesfully created register key

    if ((Get-ItemPropertyValue -Name "MinimumPINLength" -Path $regPath) -eq 8) {
    
        Write-Output "Minimum pin length of 8 characters enabled.`nMinimumPINLength Value: 8"

    }

    else {

        Write-Output "Error: MinimumPINLength was not set correctly. Please check permissions and registry path."
    }

  
  }
