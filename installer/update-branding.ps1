param(
  [string]$SourceImage = "$PSScriptRoot\..\CPP\7zip\UI\FileManager\AmurelLogo.png"
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$root = (Resolve-Path "$PSScriptRoot\..").Path
$logoPath = Join-Path $root 'CPP\7zip\UI\FileManager\AmurelLogo.png'
if ((Resolve-Path $SourceImage).Path -ne $logoPath) {
  Copy-Item -LiteralPath $SourceImage -Destination $logoPath
}
$source = [Drawing.Image]::FromFile($logoPath)
function New-LogoBitmap([int]$size) {
  $bitmap = New-Object Drawing.Bitmap($size, $size)
  $graphics = [Drawing.Graphics]::FromImage($bitmap)
  try {
    $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.DrawImage($source, 0, 0, $size, $size)
  } finally { $graphics.Dispose() }
  return $bitmap
}
try {
  $sizes = @(16, 20, 24, 32, 48, 64, 128, 256)
  $frames = @()
  foreach ($size in $sizes) {
    $bitmap = New-LogoBitmap $size
    $stream = New-Object IO.MemoryStream
    try {
      $bitmap.Save($stream, [Drawing.Imaging.ImageFormat]::Png)
      $frames += ,$stream.ToArray()
    } finally { $bitmap.Dispose(); $stream.Dispose() }
  }
  $iconPath = Join-Path $root 'CPP\7zip\UI\FileManager\Amurel.ico'
  $writer = New-Object IO.BinaryWriter([IO.File]::Create($iconPath))
  try {
    $writer.Write([uint16]0); $writer.Write([uint16]1); $writer.Write([uint16]$sizes.Count)
    $offset = 6 + 16 * $sizes.Count
    for ($i = 0; $i -lt $sizes.Count; $i++) {
      $dimension = $sizes[$i] % 256
      $writer.Write([byte]$dimension); $writer.Write([byte]$dimension)
      $writer.Write([byte]0); $writer.Write([byte]0)
      $writer.Write([uint16]1); $writer.Write([uint16]32)
      $writer.Write([uint32]$frames[$i].Length); $writer.Write([uint32]$offset)
      $offset += $frames[$i].Length
    }
    foreach ($frame in $frames) { $writer.Write([byte[]]$frame) }
  } finally { $writer.Dispose() }
  # Keep all existing resource paths and archive format resource IDs stable.
  $targets = @(Get-ChildItem "$root\CPP" -Recurse -Filter *.ico) +
             @(Get-ChildItem "$root\C" -Recurse -Filter *.ico)
  foreach ($target in $targets) {
    if ($target.FullName -ne $iconPath) { Copy-Item $iconPath $target.FullName }
  }
  # LoadBitmap uses a classic bitmap with a white menu background.
  $menu = New-Object Drawing.Bitmap(13, 13, ([Drawing.Imaging.PixelFormat]::Format24bppRgb))
  $graphics = [Drawing.Graphics]::FromImage($menu)
  try {
    $graphics.Clear([Drawing.Color]::White)
    $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.DrawImage($source, 0, 0, 13, 13)
    $menu.Save((Join-Path $root 'CPP\7zip\UI\Explorer\MenuLogo.bmp'), [Drawing.Imaging.ImageFormat]::Bmp)
  } finally { $graphics.Dispose(); $menu.Dispose() }
} finally { $source.Dispose() }
