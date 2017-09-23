# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/thunderbird.png" width="48" height="48"/> [thunderbird](https://chocolatey.org/packages/thunderbird)


Thunderbird is a free email application that's easy to set up and customize  and it's loaded with great features!


## Notes

- This package installs Thunderbird in the first language which matches this list:
  1. Install arguments override parameter if present, e.g. `choco install Thunderbird -packageParameters "l=en-GB"`.
  1. If Thunderbird is already installed: the same language as the already installed Thunderbird.
  1. The Windows system language where the Thunderbird package gets installed.
  1. If Thunderbird does not support the system language, it will fallback to `en-US`.
- To get a list of all available locales have a look at http://releases.mozilla.org/pub/thunderbird/releases/latest/README.txt.