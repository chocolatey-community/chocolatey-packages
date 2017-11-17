# Contributing

    [Packages](#1-packages)                                                                                 [Source Files](#2-source-files)    [Teamwork](#3-teamwork)  
    [Basics](#11-basics) - [Metadata](#12-metadata) - [AU Script](#13-au-script) - [UI Automation](#14-ui-automation)

---

This repository presents **the latest and highest package standards**. The purpose of this repository is to provide packages that are:

* **Stable** - Current and earlier versions should generally work so you could depend on them. The most stable packages are those that are embedded (see [1.1.4](#114-embed-a-package-if-allowed)).
* **High quality** - Packages should be resilient and should provide parameters where adequate.
* **Free** - Packages shold be generally usable by anybody without any special prerequisites.

To achieve those goals we are using the following priorities when adding new or maintaing existing packages:

1. Cross platform FOSS packages.
1. Windows only FOSS packages.
1. Freeware packages.
1. Commercial packages with unrestricted trials.

The following rules also apply: 
1. When packages have the same priorities, software with higher number of users will generally be considered more important.
1. Applications without english localization are not accepted in this repository.
1. The core team may decide to stop supporting a package after a discussion. This may happen if the package requires too much dedication during maintenance. 

For existing packages that no longer fit above principles chocolatey user will be removed from the list of the maintainers.

The following sections present complete set of guideliness, please read them carefully, especially since some of the rules are enforced and if broken will result in the failed PR build.

# 1. Packages

## 1.1 Basics

### 1.1.1 Conform to guidelines 

Conform with the [official package creation guidelines](https://chocolatey.org/docs/create-packages) and take a look at [quick start guide](https://chocolatey.org/docs/CreatePackagesQuickStart) on how to create packages.

You should also know how to [deprecate a package](https://chocolatey.org/docs/how-to-deprecate-a-chocolatey-package).

### 1.1.2 Manual or automatic

Decide if package is **manual or automatic**. Generally, packages without vendor updates for **minimum 3 years** should be considered manual. Automatic packages must use [AU](https://github.com/majkinetor/au) module.

### 1.1.3 Naming

Both *package root directory* and  *nuspec file* should be named **the same as the package Id** with all lower letters. *This is only relevant for new packages, as changing casing on existing packages may have negative side effects*

### 1.1.4 Embed a package if allowed

_Embedded_ packages include the packaged software directly in the nupkg archive instead of downloading it. Only tools that allow redistribution in their license can be embedded and such packages must include two additional files in the directory `legal` - `VERIFICATION.txt` and `License.txt`.

Its **recommended to create embedded packages** because they don't depend on vendor site working and substantially reduce the network related problems - 404 (file not found) problem and potential vendor bandwidth leaching issues are completely solved by embedding. 

Binary files can not be generally checked in into this repository because that will bloat it too much.  The repository is ignoring binary files via `.gitignore`. Automatic packages use AU functions to produce correct package that includes binaries during automatic update procedure. See the following packages as an example: [qbittorent](https://github.com/chocolatey/chocolatey-coreteampackages/tree/master/automatic/qbittorrent), [less](https://github.com/majkinetor/au-packages/tree/master/less), [smplayer](https://github.com/majkinetor/au-packages/tree/master/smplayer).

For software that explicitelly doesn't allow redistribution via adequate license the one may **contact the vendor**, ask for the redistribution rights and provide proof in the package in the form of:

- PDF of a signed license
- signed letter
- PDF of an email chain granting that permission

As an example take a look at the [activepresenter](https://github.com/chocolatey/chocolatey-coreteampackages/tree/master/automatic/activepresenter/legal) package. Embeding non allowed binaries may have [legal repercussions](https://chocolatey.org/docs/legal). 

**NOTE**: 300MB is the maximum size of the package. Larger tools must be downloaded from a vendor site or mirror.

### 1.1.5 Support multiple versions

Packages should **support multiple versions** if possible - do not use URLs that are not version specific with non-embedded packages as they will install wrong version when user provides `--version` parameter to `choco install`. If this is not possible, add a note that package doesn't support multiple versions.

### 1.1.6 Support multiple architectures

* If the package doesn't support x64 bit version, do not use `url64bit` and related x64 parameters of `Install-ChocolateyPackage`.
* If package is only x64, do not use `url` and related x32 parameters for future Windows Nano server compatibility.
* If the same url is provided for both x64 bit and x32 bit versions, only use the `url` and the related parameters. Do not use `url64bit` and its related x64 bit parameters.

### 1.1.7 Clean code

Remember, code is written for humans, not for computers. Otherwise we'd all write assembly. So it's better to be able to reason about code than it is to take shortcuts that make code harder to decipher.

If you created custom helper functions put them all in the `helpers.ps1` to keep installer clean and understandable ([example](https://github.com/chocolatey/chocolatey-coreteampackages/tree/master/automatic/virtualbox/tools)).

If you use aliases limit them to the default ones and ensure they are [compatible with PowerShell v2+](#1112-ensure-compatibility-with-powershell-v2).

Chocolatey extension [chocolatey-core.extension](https://github.com/chocolatey/chocolatey-coreteampackages/tree/master/extensions/chocolatey-core.extension) provides functions that can make the code even more understandable.

### 1.1.8 Set `softwareName`

If the package uses [Install-ChocolateyPackage](https://github.com/chocolatey/choco/wiki/HelpersInstallChocolateyPackage)
`softwareName` should be set to represent software _Display Name_ correctly. You can use [myuninstaller](https://chocolatey.org/packages/myuninst) package to quickly determine it (it's called _Entry Name_ here). 

This information is used for the licensed edition of chocolatey to detect if the software is installed (Business edition) and when the software have been uninstalled (Pro edition).

### 1.1.9 Test locally

Before pull request **make sure package can install and uninstall correctly** using the [chocolatey test environment](https://github.com/majkinetor/chocolatey-test-environment). It is used as a reference machine to prevent _it works on my computer syndrome_. AU function `Test-Package -Vagrant` can speed this up.

_Although all PR's are tested on appveyor, all packages are expected to have been locally tested before the PR was submitted_

### 1.1.10 Dependency versions

1. When taking a dependency **on an extension, specify the minimum version**.
Without this, any version satisfies the dependency. That means unless someone upgrades the extension outside of their process or incidentally install some package that uses newer version explicitly set, it will not automatically upgrade to the latest version.
1. When creating a dependency **for virtual package, use exact version** of the dependent package (.install or .portable) which should be the same as that of virtual package. 
1. When taking a dependency on **anything else, specify minimum or exact version**.

### 1.1.11 Provide uninstaller only if needed

Packages should have uninstaller if auto uninstall doesn't work.

### 1.1.12 Ensure compatibility with PowerShell v2+

Chocolatey supports PowerShell v2+ because it supports Windows 7+/Windows Server 2008+ (Windows Server 2003 is supported currently, but is deprecated and expected to be removed in a future version). Due to that, PowerShell v2 is expected to work when you run anything here.

## 1.2 Metadata

### 1.2.1 Obligatory metadata

 Make sure the following metadata is present and correct (unless it doesn't apply): `packageSourceUrl`, `projectSourceUrl`, `docsUrl`, `bugTrackerUrl`, `releaseNotes`, `licenseUrl`, `iconUrl`.

`packageSourceUrl` **must not point to the repository root** but to the package root directory.

### 1.2.2 Obligatory tags

Keep tags **lowercase**. Use `-` between words. The following tags are mandatory to use if they apply:

|tag|meaning|
|---|---|
| `foss` | for all free and open source packages|
| `cross-platform` | for all packages available on other platforms then Windows|
| `freeware` | for all freeware but not open source packages|
| `trial` | for all propriatery commercial tools that require license|
| `cli` | for all command line tools|
| `games` | for all games |

**Note**: If the software provides both free and paid variant within the same executable so that free version doesn't have a time limit, mark them as both `freeware` and `trial`.

### 1.2.3 Informative description

Description is maintained in the `README.md` file in the root of the package and automatically set in the nuspec by AU during an update. It should include the following **2nd level headers (##) in the given order**:

|header                |meaning                                        |
|---                   |---                                            |
| `Features`           | Bullet list with basic software functionality |
| `Package parameters` | Bullet list with of all package parameters    |
| `Notes`              | Bullet list with any special information to the user if any |

### 1.2.4 Add chocolatey among owners

Keep any exisiting owners and add `chocolatey` user before all others. 

### 1.2.5 Provide icon

Packages **must have an icon** if one is available. The icon must be named the same as the package and is placed in the [icons](https://github.com/chocolatey/chocolatey-coreteampackages/tree/master/icons) directory.

If the package name ends with either `.install` or `.portable` those suffixes may be ignored in the icon name.

When icon is added to this folder **it will automatically be set** in the _nuspec file_ and README.md that contains `<img>` tag.   

**NOTE**: If the packaged software do not provide an icon, add the following to the package metadata file: `<!-- IconUrl: Skip check -->`.

## 1.3 AU Script

### 1.3.1 Use `UseBasicParsing` [Optional]

If you use `Invoke-WebRequest` to download a web page, try to use `UseBasicParsing` if possible. Otherwise, the script will require IE engine installed on Windows Server used to run the updater and may also break due to the _accept cookie_ popup (see [#382](https://github.com/chocolatey/chocolatey-coreteampackages/issues/382)).

### 1.3.2 Do not download large files

Unless the package installer/executable/archive needs some special handling (like the need to read version from file, or something else not available to be handled by AU), anything bigger then few MB should never be downloaded within `au_GetLatest` function. Normally, the files are downloaded during the embeding process by the `au_BeforeUpdate`.

### 1.3.3 Specify correct `NuspecVersion`

Since commit message is used to push packages to the community repository (CR), prior to commit of the AU package specify correct `NuspecVersion` in the nuspec file as follows:

1. If you want to fix the exisiting CR package version for which no update is available at vendor specify the `NuspecVersion` the same as `RemoteVersion`.
1. If you want to push new package version to CR and `RemoteVersion` doesn't exist on CR, set `NuspecVersion` to `0.0`. AU updater will then bring the version to correct one during the next AU run and commit it to the git repository.
1. If you want to fix package that is pushed but not yet approved (for example it fails verifier) do the same as in first case but request in PR comment that you want version explicitelly set.

__NOTE__: Automatic fix version doesn't work if package is using the _revision_ part of the version (4th number). In that case _explicit version_ must be used: `[AU package:version]`.
## 1.4 UI Automation

Some installers do not provide silent arguments and can be difficult to automate.

If the package needs to perform tasks that cannot be done with command line switches, e.g. clicking away a prompt during installation that cannot be suppressed like for example in the [dropbox](https://chocolatey.org/packages/dropbox) package, you can use [AutoHotkey](https://chocolatey.org/packages/autohotkey.portable). Make [autohotkey.portable](https://chocolatey.org/packages/autohotkey.portable) a dependency of the package. Prefer AutoHotkey over [AutoIt](https://chocolatey.org/packages/autoit.commandline), because AutoHotkey is more lightweight, FOS and more actively developed than AutoIt.

### 1.4.1 Work on all locales

Script must work on every locale available for Windows, so be careful when using strings of text of window in the script that could be different in another language.

### 1.4.2 Avoid brittle scripts

Do not create brittle scripts that work only when user doesn't interfer. All script elements should be as precise as possible - for instance, instead of using [Send](https://autohotkey.com/docs/commands/Send.htm) function which will work correctly only if the desired window is active, use [ControlSend](https://autohotkey.com/docs/commands/ControlSend.htm) which doesn't require window activation or use [BlockInput](https://autohotkey.com/docs/commands/BlockInput.htm) for short period of time.

# 2. Source Files

### 2.1 Encoding 

Always __use UTF-8 without BOM__ for the `*.nuspec` and __UTF-8 with BOM__ for the `*.ps1` files. See [character encodings](https://chocolatey.org/docs/create-packages#character-encoding).

### 2.2 Code style

Do not commit code with obvious styling problems such as irregular indentation levels, very long lines, too many comments, too much of empty lines etc.

The project contains [.editorconfig](https://github.com/chocolatey/chocolatey-coreteampackages/blob/master/.editorconfig) 
 file that can be used with many editors via [EditorConfig](http://editorconfig.org/) plugins.

Keep the package source files clean and remove obsolete or outdated code and unnecessary comments. Comment non-obvious code so that others can easily understand what it does.

# 3. Teamwork

Good communiction is essential so please take a look at [etiquette](https://github.com/chocolatey/choco/blob/master/README.md#etiquette-regarding-communication) regarding it.

### 3.1 Single package per push request

All contributors should issue pull request containing single package. In special cases multiple packages per PR can be allowed.

### 3.2 Pull request expires after 6 months

PRs that remain open for 6 months without any feedback may be closed with label [Unresolved](https://github.com/chocolatey/chocolatey-coreteampackages/issues?utf8=%E2%9C%93&q=label%3AUnresolved%20).

### 3.3 Open issue expires after 6 months

Issues that remain open for 6 months without any feedback may be closed with label [Unresolved](https://github.com/chocolatey/chocolatey-coreteampackages/issues?utf8=%E2%9C%93&q=label%3AUnresolved%20).

### 3.4 Pull request one package

Do not mix multiple packages in single pull request unless in specific special cases that fix common problem. 

### 3.5 Understanding labels

Most of the labels are self describing, here are few that require explanation:

- [Push required](https://github.com/chocolatey/chocolatey-coreteampackages/pulls?utf8=%E2%9C%93&q=label%3A%224%20-%20Push%20required%22%20)  
Package is done when its pushed to community repository - If you fix the package source code and commit PR, the job is generally not over if its not pushed. Using AU package can be pushed with commit commands but sometimes its overseen.
- [Wontfix](https://github.com/chocolatey/chocolatey-coreteampackages/issues?utf8=%E2%9C%93&q=label%3Awontfix%20)  
Team doesn't think there is anything to fix here or that time required to fix it doesn't justify the benfit.
- [Unresolved](https://github.com/chocolatey/chocolatey-coreteampackages/issues?utf8=%E2%9C%93&q=label%3AUnresolved%20)  
The issue is unresolved - no feedback, no interest and it probably expired.
- [Triaging](https://github.com/chocolatey/chocolatey-coreteampackages/issues?utf8=%E2%9C%93&q=label%3ATriaging%20)  
Team is checking, confirming and measuring out the request.
- [Pending closure](https://github.com/chocolatey/chocolatey-coreteampackages/labels/Pending%20closure)  
The issue is approaching end of issue life time. This is annoucement that issue will soon get closed in few weeks unless there is some new activity.
- [Waiting feedback](https://github.com/chocolatey/chocolatey-coreteampackages/labels/Waiting%20feedback)  
The team is waiting for somebody to respond. Until that happens, there will be no activity.
