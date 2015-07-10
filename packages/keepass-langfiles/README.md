# How to update this package

1. Navigate to http://keepass.info/translations.html copy the source into a text file.
2. Make a regex search to get the download links to the translation files: `http://downloads\.sourceforge\.net/keepass.+?2\..+?\.zip`
3. Copy the matches into a new file `url-list.txt`.
4. Download all translation files with `wget -i url-list.txt`
5. Extract all ZIP files to get the `*.lngx` files.
6. Put all `*.lngx` files into `tools\keepass_2.x_langfiles.zip`
