# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop'; # stop on all errors

$script = $MyInvocation.MyCommand.Definition

$accessrtTempFolder = Join-Path $env:Temp 'chocolatey\Access2016RT'
$configFile = Join-Path $(Split-Path -parent $script) 'configuration64.xml'

$packageArgs = @{
  packageName   = 'access2016runtime'
  fileType      = 'exe'
  url           = 'https://download.microsoft.com/download/D/B/D/DBD20EF9-A945-4768-AEB0-617BCEA2214A/accessruntime_4288-1001_x64_en-us.exe'
  softwareName  = 'Access2016Runtime*'
  checksum      = 'a62b4e6dbaa1ace71b992877fa053c654f8cb568c08d38fcccaa5e0dbcb1870c'
  checksumType  = 'sha256'
  silentArgs   = "/quiet /extract:`"$accessrtTempFolder`""
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

$packageArgs['file'] = "$accessrtTempFolder\Setup.exe"
$packageArgs['silentArgs'] = "/quiet"

Install-ChocolateyPackage @packageArgs 

if (Test-Path "$accessrtTempFolder") {
  Remove-Item -Recurse "$accessrtTempFolder"
}
