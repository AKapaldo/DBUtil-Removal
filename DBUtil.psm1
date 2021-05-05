<#
.Synopsis
Removal tool for DSA-2021-088 / CVE-2021-21551.

.Description
Removal tool for the DBUtil_2_3.sys Dell driver vulnerability in accordance with DSA-2021-088.

.Parameter ComputerName
System name of the remote host to connect to.

.Notes
To install this module, place the file in your C:\users\<Username>\Documents\WindowsPowerShell\Modules\DBUtil\ folder. You may need to create this path, as these folders don't exist by default.
Author: A. Kapaldo
Date: May 5, 2021
#>

function Remove-DBUtil {
[cmdletbinding()]
param(
  [Parameter()]
  [String[]]$ComputerName=$(Read-Host -Prompt "Enter system name: ")
)
Process{

Invoke-Command -ComputerName $ComputerName -ScriptBlock {
$WinPath = "C:\Windows\Temp\DBUtil_2_3.sys"
$UserPath = "C:\Users"
$UserChildPath = "AppData\Local\Temp\DBUtil_2_3.sys"

Get-ChildItem $UserPath -Directory -Exclude Default,Public | foreach {
  $JoinedPath = Join-Path -Path $_.FullName -ChildPath $UserChildPath
  If (Test-Path $JoinedPath) {
  Write-Warning "DBUtil_2_3 found at $JoinedPath. Removing..."
  Remove-Item $JoinedPath}
}  

If (Test-Path $WinPath) {
  Write-Warning "DBUtil_2_3 found at $WinPath. Removing..."
  Remove-Item $WinPath}
}

}
}
