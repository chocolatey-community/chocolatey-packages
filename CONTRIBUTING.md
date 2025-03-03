# Contributing Guidelines

Thank you for being so interested in contributing to the Chocolatey Community Packages repository.
This document details the expectations of what is needed when contributing to this repository and what rules all contributors need to follow.

This repository presents **the latest and highest package standards**. The purpose of this repository is to provide packages that are:

- **Stable** - Current and earlier versions should generally work so that you can depend on them. The most stable packages are those that are embedded.
- **High quality** - Packages should be resilient and provide adequate parameters.
- **Free** - Packages should generally be usable by anybody without any prerequisites.

To achieve these goals, we are using the following priorities when adding new or maintaining existing packages:

1. Cross-platform FOSS packages.
2. Windows-only FOSS packages.
3. Freeware packages.
4. Commercial packages with unrestricted trials.

The following rules also apply:

1. We will first consider software with more users when packages have the same priorities.
2. Applications must have English localization before we accept these in this repository.
3. The core maintainers may stop supporting a package after a discussion when the package requires too much maintenance or if there is not enough interest in the Community to work on the package.

<!-- markdownlint-disable -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<details>
<summary>Table of Contents</summary>

- [Etiquette](#etiquette)
- [Opening Issues And Discussions](#opening-issues-and-discussions)
  - [Reporting A Bug](#reporting-a-bug)
  - [Reporting An Outdated Package](#reporting-an-outdated-package)
  - [Requesting Enhancements Or New Functionality](#requesting-enhancements-or-new-functionality)
  - [Issue Closing](#issue-closing)
- [Opening Pull Requests](#opening-pull-requests)
  - [Pull Request Title](#pull-request-title)
  - [Pull Request Body](#pull-request-body)
- [Conventions / Guidelines](#conventions--guidelines)
  - [Manual Or Automatic](#manual-or-automatic)
  - [Package Types](#package-types)
  - [Embedded Packages](#embedded-packages)
  - [Semi-Embedded Packages](#semi-embedded-packages)
  - [Remote Packages](#remote-packages)
  - [Metadata](#metadata)
    - [Naming](#naming)
    - [Dependency Versions](#dependency-versions)
    - [Conform To Guidelines](#conform-to-guidelines)
    - [Obligatory Metadata](#obligatory-metadata)
    - [Obligatory Tags And Categories](#obligatory-tags-and-categories)
    - [Description](#description)
    - [Maintainers](#maintainers)
    - [Icons](#icons)
    - [Chocolatey Compatibility](#chocolatey-compatibility)
  - [Chocolatey Scripts](#chocolatey-scripts)
    - [UI Automation](#ui-automation)
      - [Work On All Locales](#work-on-all-locales)
      - [Avoid Brittle Scripts](#avoid-brittle-scripts)
    - [Source Files](#source-files)
      - [Encoding](#encoding)
      - [Code Style](#code-style)
  - [Update Script](#update-script)
    - [Use `UseBasicParsing` When Possible](#use-usebasicparsing-when-possible)
    - [Do Not Download Large Files](#do-not-download-large-files)
- [FAQ](#faq)
  - [Why Do We Automatically Close Issues?](#why-do-we-automatically-close-issues)
  - [Why Do Not The Repository Maintainers Fix The Issues?](#why-do-not-the-repository-maintainers-fix-the-issues)
  - [How Can I Create A Fix Version Of A Package?](#how-can-i-create-a-fix-version-of-a-package)

</details>
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<!-- markdownlint-enable -->

## Etiquette

Ensure that all communications you make on this repository follow our [CODE OF CONDUCT][]. Please adhere to this document to avoid being banned from the repository.
In addition to the code of conduct document, ensure you do not unnecessarily [mention][@mention] other users when opening issues, discussions, or pull requests. Mentioning other users unneeded may lead to the current and future issues or pull requests not being addressed.

## Opening Issues And Discussions

When opening issues about packages located in this repository, there are a few things you need to find out before opening said issue or discussion.

1. Ensure the package you submit an issue or discussion about is available in this repository.
   Packages in this repository will have the user `chocolatey-community` user listed under `Package Maintainer(s)` on the sidebar of the package page on community.chocolatey.org.
2. Determine if the issue will be about a bug, a new feature, an enhancement, an outdated package or a migration of a new package.
   If you are still determining the issue type, open a general discussion about the package, or contact us through the community support channel for Chocolatey here: <https://ch0.co/community>.
3. Use the templates associated by navigating to <https://github.com/chocolatey-community/chocolatey-packages/issues/new/choose>

### Reporting A Bug

When reporting a bug, fill out the template for bug requests completely. The more information you can provide, including a list of steps to reproduce the bug found, the higher the likelihood that someone will fix the bug described.
Please include enough details about the bug to avoid the issue becoming ignored or closed if a maintainer can not reproduce the bug.
Ensure the issue title is prefixed `(packageName)` where `packageName` is the identifier of the package, and it should also contain a summary of the bug.

If you intend to fix this bug, you do not have to open an issue before submitting a pull request. Instead, see the section for [opening pull requests](#opening-pull-requests).

### Reporting An Outdated Package

Before submitting a new issue for outdated packages, ensure there is no submitted (unapproved) version available on <https://community.chocolatey.org> and that the new version has a valid stable new release.
Only open outdated package issues if there is a new stable release available. Issues for outdated pre-releases may be closed with no response given.
When reporting outdated packages, make sure you fill out the requested template completely.
Ensure the issue title is prefixed `(packageName)` where `packageName` is the identifier of the package, and it should also contain a summary of the bug.

Unlike a bug report, you do not need a summary of the issue, but it should include the word `Outdated` instead.
For example, if you report the gimp package being outdated, the issue's title should be, at a minimum: `(gimp) Outdated`.

### Requesting Enhancements Or New Functionality

Requesting new functionality for any package is not accepted as a direct pull request or a normal issue.
Any enhancement or functionality requests must be opened as a discussion.
Suppose the repository maintainers agree that the work should proceed. In that case, the maintainer will create an issue referencing the discussion.
A feature or enhancement will only be approved when it is known who will work on the implementation. If you wish to work on it, make sure to mention this in the initial discussion body.

Issues created as a bug or an outdated report may be closed if it is determined to be a new functionality request or an enhancement to an existing package. You may then have to open a discussion about the package instead (though a maintainer may choose to convert the issue to a discussion, there is no guarantee).

### Issue Closing

We have an automated bot that goes through the issues created on the repository, marking issues as stale and closing any issues marked as stale.

All issues are a candidate for becoming stale unless they have one of the following labels:

- `Security / CVE` - We always want security-related issues completed. If these issues become stale, a new maintainer will be requested.
- `0 - Backlog` - A repository maintainer will work on these issues, but it is not scheduled when to do so.
- `1. - Ready for work` - A repository maintainer will work on these issues and has been scheduled when to work on it.
- `2. - Working` - A repository maintainer has started working on these issues.
- `3. - Review` - A repository maintainer has created a pull request for these issues.
- `5. - Push required` - A package that a maintainer must push to Chocolatey Community Repository to complete these issues has not yet been pushed.

Additionally, if a user is assigned to an issue, it will not be automatically marked as stale or closed. Such issues should have an associated PR within 30 days, or the user needs to be unassigned, and it may become stale again.

## Opening Pull Requests

Pull requests fixing a bug or an outdated package do not need to have an associated issue.

**Do not open a pull request when there is already an open pull request for the same issue or bug, as this will lead to your pull request being closed.**
**Do create a branch for your pull request and not open it from the master branch, as we cannot accept pull requests from the master branch.**

When opening a new pull request, you are required to input all the information requested by the pull request template used.
An existing issue marked by a maintainer with `up for grabs` or `0 - Backlog` must exist before opening a pull request for new features, enhancements, or migrating a package.
If an issue is available, but a maintainer has yet to mark it with one of the mentioned labels, or if a different user is assigned. Please comment on the issue, asking if you can work on it. Once a maintainer assigns you to the issue, you can work on it.
However, suppose you open a pull request without an associated issue. In that case, a maintainer may close the pull request immediately without a response.

Your changes should only affect a single package unless the package(s) in question consists of a meta, `.install` and `.portable` package. In this case, you can submit all three packages in the same pull request.
There may also be other exceptions, but these will be on a case-by-case basis only when approved by a repository maintainer.

Read the [Code Conventions](#conventions--guidelines) before opening the pull request.

### Pull Request Title

Ensure the pull request title is prefixed `(packageName)` where `packageName` is the identifier of the package, and it should also contain a summary of the code changes.

### Pull Request Body

The existing template used for pull requests contains several sections you must fill out. If you have not filled out the template, a maintainer will not review the pull request, and a label with `0 - Waiting on user` will be added to the pull request.

- `Description` - Explain the changes you have made as best as you can.
- `Motivation and Context` - Explain why you made the changes, and link any issues the pull request fixes in this section.
- `Screenshot` - This section is optional. However, it's always appreciated if you can show how the code added changes/fixes the behavior of the package.
- `Types of changes` - What changes have you made in the pull request - have you fixed a bug, implemented a new feature/enhancement, or has the code added broken existing functionality (i.e. is it incompatible with previous package versions)?
- `Checklist` - This section contains a list of tasks you have done before submitting the pull request and if additional work is needed. You are required to have done everything on the checklist when appropriate. You may skip the test environment check if you only modify `update.ps1` and only need to verify the description if you have made changes there.
- `Original Location` - This section is only relevant when migrating an existing package to the repository. Remove this section if you are not migrating a package to this repository.

Before opening a pull request **make sure the package installs and uninstalls correctly** using the [Chocolatey Test Environment][] if you have made changes to files other than `update.ps1`. This environment is a reference machine to prevent the _it works on my box_ syndrome. The AU function `Test-Package -Vagrant` can speed this up.

When a reviewer requires changes to the pull request, our automated bot will mark it with the label [`0 - Waiting on User`][Waiting Label]. If you fail to update the pull request within 14 days, it will be automatically closed.
If there is no need to update, but instead, a response is needed, then adding a comment on the threads created by the reviewer/code owner is enough.
Suppose you can't update the pull request within 14 days. In that case, temporarily closing the pull request may be better to allow other users to contribute a pull request if they have time.

**NOTE: Do not add a comment to circumvent the automatic closure. Doing this may lead to the pull request being closed immediately instead.**

## Conventions / Guidelines

All packages in this repository are expected to pass all Requirement, Guideline and Suggestions checks on the Chocolatey Community Repository when possible.
All packages are also expected to follow the additional Conventions / Guidelines outlined in this section.

Keep an eye on this section occasionally, as it will evolve and change without notifications.

### Manual Or Automatic

When working on packages in this repository, you must decide whether the package should be automatic or manual.
In most cases, a package should be automatic, as these can then update themselves without manual intervention when there is a new software release.

The only time an automatic package should be a manual package is if the underlying software has not received any updates for three or more years or if it is impossible to automate.
New packages contributed/migrated to this repository should always be created as automatic packages.

All automatic packages must use the [AU][AU Source] module and work in Windows PowerShell 5.x. PowerShell Core is not supported.

The following metadata and script conventions are for automatic packages. However, manual packages need to follow the same rules where possible.

### Package Types

### Embedded Packages

_Embedded_ packages include the packaged software directly in the nupkg archive instead of downloading it. Only tools that allow redistribution in their license can be embedded. Such packages must consist of two additional files in the `legal` directory within the source folder and shipped package - `VERIFICATION.txt` and `LICENSE.txt`.

It is **recommended to create embedded packages** because they don't depend on an external site working, and substantially reduce the potential for network-related problems - 404 (file not found) problems and potential vendor bandwidth leaching issues are completely solved by embedding the binaries within the package.

Refrain from committing binary files to this repository except for images, as it will cause the repository to become unnecessarily large when pulling down any changes.
The repository has a `.gitignore`, which excludes many popular binaries. Automatic packages use AU functions to produce packages that include binaries during the automated update procedure.
See the following packages as an example: [qbittorent][qbittorrent-source], [7zip.install][7zip Source], [transifex-cli][Transifex CLI Source].

For software that explicitly doesn't allow redistribution via adequate license, then one may **contact the vendor**, ask for the redistribution rights and provide proof in the package in the form of:

- PDF of a signed license
- signed letter
- PDF of an email chain granting that permission

For example, look at the [activepresenter][Active Presenter Legals] package. Embedding non-allowed binaries may have [legal repercussions][Chocolatey Software Legal].

**NOTE**: 200MB is the maximum size of a package on the Chocolatey Community Repository. The package must download larger tools from a vendor site or mirror or, if possible, create semi-embedded packages.

### Semi-Embedded Packages

_Semi-Embedded_ packages are packages that only partially embed the software inside the nupkg archive.
A semi-embedded package is a common approach if including 32-bit and 64-bit binaries makes the package too big.
In these cases, the best approach, when possible, is to keep the 64-bit software still embedded while downloading any 32-bit software during installation if needed (as Windows is increasingly popular in a 64-bit arch).

### Remote Packages

_Remote_ packages do not include any packaged software directly in the nupkg archive. Instead, it downloads what is necessary when a user installs the package.
A remote package is the most common type seen on Chocolatey Community Repository. It is the only valid approach if the packaged software does not allow redistribution and the software authors are unwilling to grant redistribution rights.
Additionally, when a package becomes too large to be uploaded to Chocolatey Community Repository, changing an embedded package to a remote one is valid if it is not possible to use a semi-embedded package.

### Metadata

This section details the conventions and guidelines for changing or updating each package's metadata.
Metadata information is in files with the `.nuspec` file extension or a `Readme.md` file.

#### Naming

The package's name is taken from its root directory name for automatic packages. Suppose the original identifier of the existing package is not entirely lowercase. In that case, this needs to be overridden in an `update.ps1` script.
For manual packages, this is defined directly in the package metadata file. In general, this should always be in lowercase. However, existing packages should use the same casing as the original identifier.
This root directory name should always be in lowercase and follow the official [Chocolatey naming conventions](https://docs.chocolatey.org/en-us/create/create-packages#naming-your-package).

#### Dependency Versions

1. A minimum dependency version must be specified when adding a dependency. Without this, any version satisfies the dependency. That means it will only automatically upgrade to the latest version if someone upgrades the extension outside their process or incidentally installs some package that uses an explicitly set newer version. Changes to a package that does not specify a minimum or exact version will not be accepted.
2. When creating a dependency for virtual packages, specify an exact version range for the dependent package (_.install_ or _.portable). This version should be the same as that of the virtual package. An exact version in the metadata file will look like `[1.0.0]`.

#### Conform To Guidelines

Conform with the [official package creation guidelines][Chocolatey Create Packages] and take a look at the [quick start guide][Chocolatey Quickstart Guide] on how to create packages.

You should also know how to [deprecate a package][Chocolatey Package Deprecation]

#### Obligatory Metadata

You must fill in all possible elements in the metadata file when appropriate, including elements like `packageSourceUrl`, `projectSourceUrl`, `docsUrl`, `bugTrackerUrl`, `releaseNotes`, `licenseUrl` and `iconUrl` - even when one or more of these are made optional on Chocolatey Community Repository itself. If the software itself does not have any sufficient URLs to be used for these, then it can be omitted.

You can ignore the description in the nuspec metadata file. Only the Readme.md must contain the description and is required.

#### Obligatory Tags And Categories

All tags and categories should be in lowercase and in the following order.
The tags specified should always be space delimited.

- The first specified tag should always be a delimited dash name of the identifier of the package (excluding the suffixes `.install`, `.portable`, `.commandline` and `.app`).
- The second specified tag should be the category under which the packaged software falls. Only the following list of tags is allowed as the category tag (_NOTE: Existing packages may be missing a category tag, if you change a package that does not make use of one, a maintainer may ask you to include a category tag_)
  - `addon` (for packaged software that is a plugin or addon for another application as well as PowerShell Modules)
  - `browser` (For browser implementations like Google Chrome, Firefox, Microsoft Edge, Brave, and Opera.)
  - `client`
  - `driver`
  - `editor`
  - `extension` (only for Chocolatey Extensions)
  - `games`
  - `productivity`
  - `programming`
  - `server`
  - `utility`
  - `web`
- The third tag denotes the license type of the packaged software:
  - `foss` (The packaged application is a free application with its source freely viewable by anyone)
  - `freeware` (The packaged application is a free application, but its source is not available to be viewed)
  - `oss` (The packaged application has its source freely viewable by anyone but requires payment for compiled binaries)
  - `trial` (The packaged application is a commercial or paid application but includes a limited free trial)
- The fourth tag should be `cross-platform` if the application is available on multiple platforms.
- You may add additional tags after the fourth tag, which is recommended when possible. These tags should not be any previously mentioned tags used for categorization or licensing.

#### Description

You can acquire the package description from the software author's website. It should include enough information about the application for those who know nothing about it.

Additionally, there are a few descriptive headers that are required to be specified in the description as well.

| Header Name          | Meaning |
|----------------------|---------|
| `Features`           | Bullet list that summarizes the available functionality of the packaged application |
| `Package Parameters` | Bullet list of the available package parameters that can be used when installing the package. This section can be omitted if there are no package parameters |
| `Notes`              | Bullet list with any particular information about the software or package that the user should know about, e.g. recent breaking changes to the installation, uninstall or unusual edge cases |

#### Maintainers

Maintainers of the package, in our case, are folk that have edited a package - either by being the original maintainer of the package or by contributing one or more changes to the package after it was added to the repository.
The metadata file should always include the package's current and historical maintainers. If you are editing a package, add yourself using a comma-delimited list format.
If the user `chocolatey-community` is not already specified as the package's maintainer, this user must be added as the first maintainer in the `owners` element.
One or more of the maintainers listed in the `owners` element should be similar to a name listed in our `CODE_OWNERS` file and will be considered the primary maintainer of the package.

#### Icons

A package must have an icon available if the packaged software has an icon. This icon must be named the same as the package and is placed in the [icons][] directory.
If the package name ends with either `.install` or `.portable`, the suffix may be ignored in the icon name.
When an icon is added to this folder with the correct name, it will **automatically** be set in the metadata file and the README file when our build server updates the package, if the metadata file contains an `<IconUrl>` element.

**IMPORTANT: If no icon is available, the comment `<!-- IconUrl: Skip check -->` should be added to the metadata file**

#### Chocolatey Compatibility

All packages are expected to be compatible with the oldest version of Chocolatey CLI we list as supported on our [Wiki Page][].
If that is not possible, and the package needs a version of Chocolatey CLI released later, it will need to include a dependency for that Chocolatey CLI version.

### Chocolatey Scripts

All PowerShell scripts are expected to be compatible with Windows PowerShell v2 through v5.1. If this is not possible, a dependency on the package `PowerShell` is required, with its minimum version set to the earliest version that the scripts in the package are expected to work with.

#### UI Automation

Some installers do not provide silent arguments, and can be challenging to automate.

Suppose the package needs to perform tasks that cannot be done with command line switches, e.g. clicking away a prompt during installation that cannot be suppressed as in the [dropbox][Dropbox Package] package. In that case, you can use [AutoHotkey][Autohotkey Package].

Make [autohotkey.portable][Autohotekey Package] a dependency of the package. Community maintainers generally prefer AutoHotkey over [AutoIt][AutoIt Package] because AutoHotkey is more lightweight, FOSS, and more actively developed than AutoIt.

##### Work On All Locales

Scripts must work on every locale available for Windows. Be careful when using text strings for windows in the script that could differ in another language.

##### Avoid Brittle Scripts

Do not create brittle scripts that work only when the user doesn't interfere. All script elements should be as precise as possible - for instance, instead of using the [Send][AHK Send Docs] function, which will work correctly only if the desired window is active, use [ControlSend][AHK ControlSend Docs] which doesn't require window activation or use [BlockInput][AHK BlockInput Docs] for short periods.

#### Source Files

##### Encoding

Always __use UTF-8 without BOM__ for the `*.nuspec` and __UTF-8 with BOM__ for the `*.ps1` files. See [character encodings][].

##### Code Style

Refrain from committing code with obvious styling problems such as irregular indentation levels, very long lines, too many comments, too many empty lines, and other styling issues. Please follow the [PoshCode PowerShell Practice and Style Guide][].

The project contains a [`.editorconfig`][Editorconfig Source]
 file that you can use with many editors via [EditorConfig][] plugins. Ensure you use an editor with this support and have the support enabled.

Keep the package source files clean and remove outdated code and unnecessary comments. Comment on non-obvious code so that others can easily understand what it does.

### Update Script

Update scripts are the PowerShell scripts responsible for getting information about the software's most current version, where it can be acquired from, and how to modify the source code to produce the package. It is typically called `update.ps1`.
These scripts should be located in the root of the package directory, right next to the metadata (`.nuspec`) file.
The update script should be compatible with Windows PowerShell v5 and may not need to be compatible with PowerShell Core.

#### Use `UseBasicParsing` When Possible

If you use the PowerShell cmdlet `Invoke-WebRequest` in the update script, always make sure to also pass in `-UseBasicParsing` to this cmdlet. There may be cases where using this parameter is not possible. Add a comment before the call about why `-UseBasicParsing` can not be used in these cases.
Any script that does not use this argument requires the Internet Explorer engine to be available and the web browser to have launched at least once before.

#### Do Not Download Large Files

Unless a package installer/executable/archive needs some special handling (like reading the version from the file or something else not automatically handled by AU), do not download anything bigger than a few MB within `au_GetLatest` function. Usually, the files are downloaded during the updating process automatically or in the `au_BeforeUpdate` function.
Try finding alternatives to reading the version from the file when needed to prevent the need to download the file if no version elsewhere is available, like checking the headers of the response before doing a download.

## FAQ

### Why Do We Automatically Close Issues?

The Chocolatey Packages repository is a shared repository that is worked on by the entire Chocolatey Community. When an issue lives for a long enough time to become stale, it needs more interest in the Community for the issue to become fixed. As there needs to be more interest in the Community, it is unlikely the issue will be fixed anytime soon, and it will instead be automatically closed.

### Why Do Not The Repository Maintainers Fix The Issues?

While there may be times that a repository maintainer will take steps to fix problems with a package, it is not the main reason for the repository maintainers here.
The repository maintainers' main tasks are to keep order in the repository, triage issues, ensure that the appropriate people review pull requests and that package changes are up to the quality expected for packages in the repository.

Repository maintainers are not responsible for fixing issues with the automated updater, automated checks on Chocolatey Community Repository that are failing, or implementing features or enhancements.
That does not mean it will not happen, but it is not one of their responsibilities.

### How Can I Create A Fix Version Of A Package?

A maintainer with repository write access must create a fixed package version.
If you do not have write access, please open an issue in our repository by filling out all the information being asked of you when using the [outdated template][Outdated Template]
Make sure the title of the issue says: `(packageName) Outdated` (_replace packageName with the name of the package_)
If you have write access to the repository and can push directly, see the appropriate section in the [COMMITTERS](COMMITTERS.md#providing-fix-versions) documentation file.

[@mention]: https://github.blog/2011-03-23-mention-somebody-they-re-notified/
[7zip Source]: https://github.com/chocolatey-community/chocolatey-packages/tree/33ff3de69acedcac88f44b670fcb44b6422728db/automatic/7zip.install
[Active Presenter Legals]: https://github.com/chocolatey-community/chocolatey-packages/tree/33ff3de69acedcac88f44b670fcb44b6422728db/automatic/activepresenter/legal
[AHK BlockInput Docs]: https://www.autohotkey.com/docs/v2/lib/BlockInput.htm
[AHK ControlSend Docs]: https://www.autohotkey.com/docs/v2/lib/ControlSend.htm
[AHK Send Docs]: https://www.autohotkey.com/docs/v2/lib/Send.htm
[AU Source]: https://github.com/chocolatey-community/chocolatey-au
[Autohotkey Package]: https://community.chocolatey.org/packages/autohotkey.portable
[AutoIt Package]: https://community.chocolatey.org/packages/autoit.commandline
[character encodings]: https://docs.chocolatey.org/en-us/create/create-packages#character-encoding
[Chocolatey Create Packages]: https://docs.chocolatey.org/en-us/create/create-packages
[Chocolatey Package Deprecation]: https://docs.chocolatey.org/en-us/community-repository/maintainers/deprecate-a-chocolatey-package
[Chocolatey Quickstart Guide]: https://docs.chocolatey.org/en-us/create/create-packages-quick-start
[Chocolatey Software Legal]: https://docs.chocolatey.org/en-us/information/legal
[Chocolatey Test Environment]: https://github.com/chocolatey-community/chocolatey-test-environment
[Code of Conduct]: https://github.com/chocolatey-community/.github/blob/main/CODE_OF_CONDUCT.md
[Dropbox Package]: https://community.chocolatey.org/packages/dropbox
[EditorConfig Source]: https://github.com/chocolatey-community/chocolatey-packages/blob/master/.editorconfig
[EditorConfig]: https://editorconfig.org/
[icons]: https://github.com/chocolatey-community/chocolatey-packages/tree/master/icons
[Outdated Template]: https://github.com/chocolatey-community/chocolatey-packages/issues/new?assignees=&labels=Outdated&template=outdated-report.yml&title=%28packageName%29+
[PoshCode PowerShell Practice and Style Guide]: https://github.com/PoshCode/PowerShellPracticeAndStyle
[qbittorrent-source]: https://github.com/chocolatey-community/chocolatey-packages/tree/fa0d822f437b91fcd9be0730bfc8639098e3f3a9/automatic/qbittorrent
[Transifex CLI Source]: https://github.com/chocolatey-community/chocolatey-packages/tree/33ff3de69acedcac88f44b670fcb44b6422728db/automatic/transifex-cli
[Waiting Label]: https://github.com/chocolatey-community/chocolatey-packages/labels/0%20-%20Waiting%20on%20User
[Wiki Page]: https://github.com/chocolatey-community/chocolatey-packages/wiki/Supported-Chocolatey-CLI-versions
