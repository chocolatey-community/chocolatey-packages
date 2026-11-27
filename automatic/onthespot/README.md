# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@22708b171074cdcdeb8443c11e1103153fedba24/icons/onthespot.png" width="48" height="48"/> [onthespot](https://chocolatey.org/packages/onthespot)

`OnTheSpot` is an easy-to-use music downloader written in Python. It supports a number of music services and, unlike similar projects, the downloaded files and their metadata are sourced directly from the service of your choosing. The application ships with a GUI, a CLI and a web UI.

This package installs OnTheSpot in an isolated virtual environment inside the Chocolatey package directory, using a uv-managed Python interpreter. No system-wide Python installation is required.

## Features

* Download tracks, albums, playlists and podcasts from Spotify, YouTube Music, Apple Music, Tidal, Deezer, Qobuz, SoundCloud, Bandcamp and Crunchyroll.
* Download the audio and its metadata directly from the service of your choosing.
* Three frontends: a Qt desktop application (`onthespot-gui`), a command-line interface (`onthespot-cli`) and a web UI (`onthespot-web`).
* Fully isolated from any Python installation on the system.

## Usage

```powershell
onthespot-gui
onthespot-cli --download https://open.spotify.com/track/4cOdK2wGLETKBW3PvgPWqT
onthespot-web --port 5000
```

## Notes

* This package requires 64-bit Windows.
* An internet connection is required during installation to download the managed Python interpreter and the OnTheSpot sources.
* A uv-managed Python 3.12 interpreter is downloaded during installation.
* The `ffmpeg` package is installed as a dependency because OnTheSpot uses it to convert the downloaded audio.
* The `uv` package is installed as a dependency and remains installed after this package is uninstalled.
* Start menu shortcuts are created for the desktop application and for the web UI.
* The 2.x releases are a web application that is distributed as Docker images and provides neither a Windows build nor the desktop and command-line frontends, so this package tracks the 1.x releases.
* Uninstalling the package removes the virtual environment and the managed Python interpreter along with the rest of the package directory.

## License

GPL-2.0. See the [project license](https://github.com/ots-downloader/onthespot/blob/master/LICENSE).
