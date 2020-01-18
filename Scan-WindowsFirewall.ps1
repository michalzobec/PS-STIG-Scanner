#Requires -RunAsAdministrator
#Requires -Version 5
Set-StrictMode -Version 5
$ScriptDir = (Split-Path $myinvocation.MyCommand.Path)
Import-Module -Name "$ScriptDir\Compliance\Compliance.psm1"
Test-Compliance -Path "$ScriptDir\AuditFiles\WindowsFirewall.audit" | Out-File $ScriptDir\audit-output.txt -Append
