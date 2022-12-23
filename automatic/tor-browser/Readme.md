# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/tor-browser.png" width="48" height="48"/> [tor-browser](https://chocolatey.org/packages/tor-browser)

The Tor software protects you by bouncing your communications around a distributed network of relays run by volunteers all around the world: it prevents somebody watching your Internet connection from learning what sites you visit, it prevents the sites you visit from learning your physical location, and it lets you access sites which are blocked.

## Package Parameters

- `/InstallDir:` - Allows changing the installation directory to put tor browser in.

## Notes

- Starting from version 8.5, support for 64 bit editions of tor browser is now also included.
  There is currently no check to see if a 32bit edition is already installed. Use the `--x86` argument
  if there is a wish to keep using the 32bit edition.
- Starting from version version 12.0.1, support for the `locale` parameter was removed because
  individual installers for different locales were merged into a single installer for all locales.