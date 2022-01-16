$packageName = 'ruby.portable'

# 1.8.7
#$url = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-1.8.7-p374-i386-mingw32.7z?direct'
#$checksum = '2eabeb3bb210d088083c0c04fdf94c7e'

# 1.9.3
# $url = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-1.9.3-p551-i386-mingw32.7z?direct'
# $checksum = '73ba6e292d3afec5cecc68ec64fd85bf'

# 2.0.0
# $url = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.0.0-p645-i386-mingw32.7z?direct'
# $checksum = '57422903090e7001698c5b94ca47e1a6ee492c54'
# $url64 = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.0.0-p645-x64-mingw32.7z?direct'
# $checksum64 = 'af37b28c15449d7adf05acd0717a9804460d8738'

# 2.1.x
# $url = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.1.6-i386-mingw32.7z?direct'
# $checksum = '2b1e96081fd3010b11591a39c31f195b2f657f1d'
# $url64 = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.1.6-x64-mingw32.7z?direct'
# $checksum64 = 'b6315bc57b4e5f453bb59f640e1992702bd04d51'

# 2.2.3
# $url = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.2.3-i386-mingw32.7z?direct'
# $checksum = '8d7d94856bd7c9498c48a9b8d155c926'
# $url64 = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.2.3-x64-mingw32.7z?direct'
# $checksum64 = '77bfcf4b65ec8d5ba0cd84779f3eff7c'

# 2.3.0
$url = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.3.0-i386-mingw32.7z?direct'
$checksum = 'c8daba86954ddb59a8ff3b1bb5dbb24fb0c4c06810d9067fabac870b9316b029'
$url64 = 'http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.3.0-x64-mingw32.7z?direct'
$checksum64 = 'e930827ecd075b7fc9cca50df2824c6b8fba26f90e92eae2e41d58edf74dbfc9'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Join-Path $toolsDir "ruby"
$file = Join-Path $toolsDir "$($packageName).7z"

#Get-ChocolateyWebFile "$packageName" "$file" "$url" -checksum "$checksum"
Get-ChocolateyWebFile "$packageName" "$file" "$url" "$url64" `
  -checksum $checksum -checksumType 'sha256' `
  -checksum64 $checksum64 -checksumType64 'sha256'

Get-ChocolateyUnzip "$file" "$installDir" -packageName "$packageName"
