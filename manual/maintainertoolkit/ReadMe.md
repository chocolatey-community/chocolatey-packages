# Chocolatey Package Maintenance Toolkit

A metapackage that installs the complete, recommended toolset for creating, testing, and maintaining [Chocolatey](https://chocolatey.org) community packages.

## Installation

```powershell
choco install maintainertoolkit -y
```

That's it. One command sets up your entire package authoring environment.

## What Gets Installed

| Package | Version | Purpose |
|---|---|---|
| [Visual Studio Code](https://community.chocolatey.org/packages/vscode.install) | 1.111.0 | Primary editor for `.nuspec`, `chocolateyInstall.ps1`, and other package files |
| [Git](https://community.chocolatey.org/packages/git.install) | 2.53.0 | Version control for managing package source code |
| [GitHub CLI](https://community.chocolatey.org/packages/gh) | 2.87.2 | Create and manage pull requests and issues from the terminal |
| [PowerShell Extension for VS Code](https://community.chocolatey.org/packages/vscode-powershell) | 2025.4.0 | Syntax highlighting, IntelliSense, and debugging for PowerShell scripts |
| [Chocolatey Extension for VS Code](https://community.chocolatey.org/packages/chocolatey-vscode) | 0.7.2 | Snippets, linting, and tooling specific to Chocolatey package authoring |
| [Expresso](https://community.chocolatey.org/packages/expresso) | 3.0.4750 | Desktop regex builder and tester — useful for writing AU update patterns |

## Who Is This For?

This package targets **Chocolatey Community Repository maintainers** who want a consistent, reproducible development environment. Whether you are setting up a new machine or helping a new contributor get started, everything you need is installed in a single step.

## Notes

- This is a **metapackage** — it contains no binaries of its own. It exists solely to pull in its dependencies.
- All dependency versions are pinned to known-good releases. You can upgrade individual tools independently after installation with `choco upgrade <packagename>`.
- After installation, the toolkit will print a curated list of recommended online resources for package maintainers — including documentation, moderation rules, and community links.

## Recommended Resources

The following resources are displayed after installation and are useful to bookmark:

| Resource | Description |
|---|---|
| [Chocolatey Package Creation Docs](https://docs.chocolatey.org/en-us/guides/create/) | Official guide covering `.nuspec` authoring, install scripts, and best practices |
| [Chocolatey AU](https://github.com/chocolatey-community/chocolatey-au) | Framework for keeping packages automatically up to date |
| [regex101](https://regex101.com) | Interactive regex builder and debugger for AU update patterns |
| [Fiddler](https://www.telerik.com/fiddler) | Inspect HTTP responses to find stable download URLs and version info |
| [VirusTotal](https://www.virustotal.com) | Scan installer binaries and submit checksums for moderation review |
| [Chocolatey Community Discord](https://ch0.co/community) | Get help, ask questions, and discuss package maintenance with the community |

## Links

- [Package Source](https://github.com/chocolatey-community/chocolatey-packages/blob/master/manual/maintainertoolkit/)
- [Report an Issue](https://github.com/chocolatey-community/chocolatey-packages/issues)
- [Community Mailing List](https://ch0.co/community)
