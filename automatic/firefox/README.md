# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/firefox.png" width="48" height="48"/> [Firefox](https://chocolatey.org/packages/Firefox)


Bringing together all kinds of awesomeness to make browsing better for you.


## Features
- **Freedom is fast:** Go anywhere you want on the Web with a quickness.
- **Freedom is personal:** Enjoy the most built-in privacy tools of any browser.
- **Freedom is yours:** people, not profit.

## Notes
- Looking for Firefox Developer Edition? Install the [firefox-dev](/packages/firefox-dev) package.
- Looking for Firefox Extended Support Release? Install the [FirefoxESR](/packages/FirefoxESR) package.
- This package installs Firefox in the first language which matches this list:
1. Install arguments override parameter if present, e.g. `choco install Firefox -packageParameters "l=en-GB"`.
To get a list of all available locales have a look at this file: https://releases.mozilla.org/pub/firefox/releases/latest/README.txt.
2. If Firefox is already installed: the same language as the already installed Firefox.
3. The Windows system language where the Firefox package gets installed.
4. If Firefox does not support the system language, it will fall back to `en-US`.

