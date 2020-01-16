# PS STIG Scanner

## About the PS STIG Scanner

PS STIG Scanner (PowerShell module) can be used to verify compliance against using audit files. This PowerShell module makes it simple to scan a single standalone system and verify a configuration has been applied to a system in a non-domain context.

Note that Nessus is not required to be installed on the system that is being checked with the script.

## Getting started

To get started using the tools:

1. [Download](#downloading-the-repository) the repository as a zip file
1. [Configure PowerShell](#configuring-the-powershell-environment)
1. [Load the code](#loading-the-code)
1. [Apply the policies](#applying-the-policies)
1. [Check compliance](#checking-compliance)

## Downloading the repository

Download the [current code](https://github.com/michalzobec/PS-STIG-Scanner/archive/master.zip) to your **Downloads** folder. It will be saved as **PS-STIG-Scanner-master.zip** by default.

## Configuring the PowerShell environment

The PowerShell commands are meant to run from a system with at least PowerShell 3.0 installed. PowerShell may need to be configured to run the commands.

### Changing the PowerShell execution policy

Users may need to change the default PowerShell execution policy. This can be achieved in a number of different ways:

* Open a command prompt and run **powershell.exe -ExecutionPolicy Unrestricted** and run scripts from that PowerShell session. 
* Open a PowerShell prompt and run **Set-ExecutionPolicy Unrestricted -Scope Process** and run scripts from the current PowerShell session. 
* Open an administrative PowerShell prompt and run **Set-ExecutionPolicy Unrestricted** and run scripts from any PowerShell session. 

### Unblocking the PowerShell scripts

Users will need to unblock the downloaded zip file since it will be marked as having been downloaded from the Internet which PowerShell will block from executing by default. Open a PowerShell prompt and run the following commands to unblock the PowerShell code in the zip file:

1. `cd $env:USERPROFILE`
1. `cd Downloads`
1. `Unblock-File -Path '.\PS-STIG-Scanner-master.zip'`

Running the PowerShell scripts inside the zip file without unblocking the file will result in the following warning:

*Security warning*
*Run only scripts that you trust. While scripts from the internet can be useful, this script can potentially harm your computer. If you trust this script, use the Unblock-File cmdlet to allow the script to run without this warning message. Do you want to run C:\users\user\Downloads\script.ps1?*
*[D] Do not run [R] Run once [S] Suspend [?] Help (default is "D"):*

If the downloaded zip file is not unblocked before extracting it, then all the individual PowerShell files that were in the zip file will have to be unblocked. You will need to run the following command after Step 5 in the [Loading the code](#loading-the-code) section:

```Get-ChildItem -Path '.\PS-STIG-Scanner' -Recurse -Include '*.ps1','*.psm1' | Unblock-File -Verbose```

See the [Unblock-File command's documentation](https://technet.microsoft.com/en-us/library/hh849924.aspx) for more information on how to use it.

### Loading the code

Now extract the downloaded zip file and load the PowerShell code used for apply the policies.

1. Right click on the zip file and select **Extract All**
1. At the dialog remove **PS-STIG-Scanner-master** from the end of the path since it will extract the files to a PS-STIG-Scanner-master folder by default
1. Click the **Extract** button
1. Rename the **PS-STIG-Scanner-master** folder to **PS-STIG-Scanner**

## Compliance Checks

Nessus audit files are included in this repository. Compliance checks are available for:

* Adobe Reader DC
* Chrome
* Internet Explorer
* Windows
* Windows Firewall

## Running Compliance Checks

Use a the provided Compliance PowerShell script (Nessus not required).

## Standalone Scan with PowerShell

The **Test-Compliance** command in the [Compliance PowerShell module](./Compliance/) can be used to verify compliance against using any of the above listed .audit files. This PowerShell script makes it simple to scan a single standalone system and verify a configuration has been applied to a system in a non-domain context. Note that Nessus is not required to be installed on the system that is being checked with the script. The following instructions can be used to execute a compliance check locally.

1. Open a PowerShell prompt as an administrator
1. Change directory to the Compliance directory (e.g. **cd PS-STIG-Scanner\Compliance**)
1. Import the [Compliance PowerShell module](./Compliance/) to load the code into the PowerShell session: `Import-Module -Name .\PS-STIG-Scanner\Compliance\Compliance.psm1`
1. Copy and paste the desired line(s) below into the PowerShell prompt and press Enter twice
    * ```Test-Compliance -Path '..\Adobe Reader\AdobeReaderDC.audit'```
    * ```Test-Compliance -Path '..\Chrome\GoogleChrome.audit'```
    * ```Test-Compliance -Path '..\Internet Explorer\InternetExplorer11.audit'```
    * ```Test-Compliance -Path '..\Windows\Windows10.audit'```
    * ```Test-Compliance -Path '..\Windows Firewall\WindowsFirewall.audit'```

The Compliance script supports a **-Verbose** option that show details for checks that fail. Without the verbose option a simple pass/fail is displayed for each compliance check as shown in the image below. 

![compliance_script_example](./images/compliance_script_example.jpg?raw=true)

Verbose example:
```Test-Compliance -Path '..\Adobe Reader\AdobeReaderDC.audit' -Verbose```

Verbose example with capturing the output into a file:

```Test-Compliance -Path '..\Adobe Reader\AdobeReaderDC.audit' -Verbose .\*>ComplianceReport.txt```

After capturing the output into a file, the failed STIG checks can be filtered using this PowerShell command:

```Select-String -Path .\ComplianceReport.txt -Pattern 'FAILED'```

## Links

* [Nessus Compliance Checks Reference (PDF)](https://docs.tenable.com/nessus/compliancechecksreference/Content/Resources/PDF/NessusComplianceChecksReference.pdf)
* [Nessus Compliance Checks Reference (HTML)](https://docs.tenable.com/nessus/compliancechecksreference/Content/ComplianceCheckTypes.htm)
* [Nessus Compliance Checks Overview (PDF)](https://support.tenable.com/support-center/nessus_compliance_checks.pdf)

## License

See [LICENSE](./LICENSE.md).

## Disclaimer

See [DISCLAIMER](./DISCLAIMER.md).
