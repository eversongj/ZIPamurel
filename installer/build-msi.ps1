$ErrorActionPreference = "Stop"

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$wxsPath = Join-Path $PSScriptRoot "AmurelZip.wxs"
$exePath = Join-Path $projectRoot "CPP\7zip\Bundles\Fm\x64\7zFM.exe"
$guiPath = Join-Path $projectRoot "CPP\7zip\UI\GUI\x64\7zG.exe"
$codecsPath = Join-Path $projectRoot "CPP\7zip\Bundles\Format7zF\x64\7z.dll"
$shellExtensionPath = Join-Path $projectRoot "CPP\7zip\UI\Explorer\x64\7-zip.dll"
$guidePath = Join-Path $projectRoot "DOC\Guia-Amurel-ZIP.md"
$noticesPath = Join-Path $projectRoot "DOC\License.txt"
$unRarLicensePath = Join-Path $projectRoot "DOC\unRarLicense.txt"
$licensePath = Join-Path $projectRoot "DOC\AmurelLicense.rtf"
$outputDirectory = Join-Path $projectRoot "dist"
$outputPath = Join-Path $outputDirectory "AMUREL-ZIP-26.05.1-x64.msi"

foreach ($requiredFile in @($exePath, $guiPath, $codecsPath, $shellExtensionPath, $guidePath, $noticesPath, $unRarLicensePath, $licensePath)) {
  if (!(Test-Path $requiredFile)) {
    throw "Required MSI source file is missing: $requiredFile"
  }
}

$candle = Get-Command candle.exe -ErrorAction SilentlyContinue
$light = Get-Command light.exe -ErrorAction SilentlyContinue
if (!$candle -or !$light) {
  $wixBin = Join-Path ${env:ProgramFiles(x86)} "WiX Toolset v3.14\bin"
  if (!(Test-Path (Join-Path $wixBin "candle.exe")) -or
      !(Test-Path (Join-Path $wixBin "light.exe"))) {
    throw "WiX Toolset v3.14 is required. Add its bin directory to PATH or install it first."
  }
  $candlePath = Join-Path $wixBin "candle.exe"
  $lightPath = Join-Path $wixBin "light.exe"
}
else {
  $candlePath = $candle.Source
  $lightPath = $light.Source
}

New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
$workDirectory = Join-Path $env:TEMP ("AmurelZipMsi-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $workDirectory | Out-Null
try {
  $objectPath = Join-Path $workDirectory "AmurelZip.wixobj"
  & $candlePath -nologo "-dProjectRoot=$projectRoot" -out $objectPath $wxsPath
  if ($LASTEXITCODE -ne 0) {
    throw "WiX compilation failed with exit code $LASTEXITCODE."
  }

  $pdbPath = Join-Path $workDirectory "AmurelZip.wixpdb"
  & $lightPath -nologo -ext WixUIExtension -cultures:pt-BR -out $outputPath -pdbout $pdbPath $objectPath
  if ($LASTEXITCODE -ne 0) {
    throw "MSI linking failed with exit code $LASTEXITCODE."
  }
}
finally {
  Remove-Item -LiteralPath $workDirectory -Recurse -Force
}

Get-Item $outputPath | Select-Object FullName, Length, LastWriteTime
