# Based on FeodorFitsners screenshot function
# https://github.com/FeodorFitsner/selenium-tests/blob/master/take-screenshot.ps1

function Take-Screenshot {
  param(
    [string]$file,
    [ValidateSet('bmp','jpeg','png')]
    [string]$imagetype = 'png'
  )
  [void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
  [void][Reflection.Assembly]::LoadWithPartialName('System.Drawing')
  function screenshot([Drawing.Rectangle]$bounds, $path, [Drawing.Imaging.ImageFormat]$imageFormat) {
    $bitmap = New-Object Drawing.Bitmap $bounds.width, $bounds.height
    $graphics = [Drawing.Graphics]::FromImage($bitmap)

    $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)
    $bitmap.Save($path, $imageFormat)

    $graphics.Dispose()
    $bitmap.Dispose()
  }

  $screen = [System.Windows.Forms.Screen]::PrimaryScreen
  $bounds = $screen.Bounds

  screenshot $bounds $file $imagetype
}
