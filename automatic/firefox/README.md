# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/firefox.png" width="48" height="48"/> [Firefox](https://chocolatey.org/packages/Firefox)

Bringing together all kinds of awesomeness to make browsing better for you.

## Features

- A powerful, new engine that’s built for rapidfire performance.
- Better, faster page loading that uses less computer memory.
- Gorgeous design and smart features for intelligent browsing.
- Instantly import your online info and favorites from any other browser.
- The most powerful private browsing mode with added tracking protection.
- Firefox Quantum features: screenshots, pocket, gaming & VR, library.
- Customization Features - addons & extensions, themes, toolbar.
- Synced across devices - passwords, bookmarks, tabs and more.
- Ad tracker blocking.
- Password manager.

## Package Parameters

- `l=<locale>` - Install given Firefox locale. For example `choco install Firefox --params "l=en-GB"`. See the [official page](https://releases.mozilla.org/pub/firefox/releases/latest/README.txt) for a complete list of available locales.

## Notes

- Looking for Firefox Developer Edition? Install the [firefox-dev](/packages/firefox-dev) package.
- Looking for Firefox Extended Support Release? Install the [FirefoxESR](/packages/FirefoxESR) package.
- If locale package parameter is not present, this package installs Firefox in the first language which matches this list:
  1. If Firefox is already installed it uses the same language as the already installed one.
  1. The Windows system language.
  1. If Firefox does not support the system language, it will fall back to `en-US`.
