# Committers Guidelines

This file details what is needed for different operations in the repository that can not be handled by opening pull requests.

<!-- markdownlint-disable -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<details>
<summary>Table of Contents</summary>

- [Providing A Fixed Version](#providing-a-fixed-version)
  - [Request A Standard Fix Version Creation](#request-a-standard-fix-version-creation)
  - [Request A Standard Fix Version Creation For A Stream](#request-a-standard-fix-version-creation-for-a-stream)
    - [Request A Fixed Version Update](#request-a-fixed-version-update)
    - [Requesting A Fix For A Package Using 4 Part Version Number](#requesting-a-fix-for-a-package-using-4-part-version-number)

</details>
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<!-- markdownlint-enable -->

## Providing A Fixed Version

Before providing a fixed package version, you need to determine the existing version specified in the repository, what type of version it uses, and whether the package contains additional handling for creating fixed versions.

### Request A Standard Fix Version Creation

A standard fix version creation is intended for packages that do not use streams and does not use a 4-part version number - usually determined by whether there is no JSON file available in the package directory and the package metadata file uses a 2 or 3-part version number.

To request a fixed version, create an empty commit with the message `[AU packageName]`. This can be done by using the following command line call: `git commit --allow-empty-commit -m "[AU packageName]"` (replace packageName with the actual name of the package). Ensure you don't make any changes, as this can prevent your ability to push the commit.

### Request A Standard Fix Version Creation For A Stream

To request a standard fixed version for a stream, you need to figure out the name of the stream you want to force the fixed version of. All packages that support streams are expected to have a JSON file next to their metadata file that contains a list of the different streams and the last version found for that stream. Find the stream in this file, and make sure that the stream uses a 2 or 3-part version number.
Commonly, the highest version is located in the stream name `latest` (however, not always). It is also not guaranteed that all streams listed in the file are available.

To request a fixed version, in this case, you create an empty commit with the message `[AU packageName\streamName]`. This can be done by using the following command line call: `git commit --allow-empty-commit -m "[AU packageName\streamName]` (replace packageName with the actual name of the package, and streamName with the name of the stream). Ensure you don't make any changes, as this can prevent your ability to push the commit.

#### Request A Fixed Version Update

If you need to update the same version the updater had previously submitted, or if the package you want uses a 4-part version number, you may need to specify the exact version you want to push.
It is crucial to note here that the version used will only change the version specified in the metadata file of the pushed package and not decide which version of the software will be pulled down from any upstream location.

To create a fixed version update, you may use `[AU packageName:packageVersion]` for standard packages and `[AU packageName\streamVersion:packageVersion]` for stream packages using the same git command mentioned previously. Ensure you don't make any changes, as this can prevent your ability to push the commit.

#### Requesting A Fix For A Package Using 4 Part Version Number

If you need to create a fixed version for a package that already uses four parts of the version number, you must first add or update the updater script.
Before setting the `Version` parameter to the returned object in `au_GetLatest`, add a call to the function `Get-FixVersion`. This call should also include the parameter `-OnlyFixBelowVersion` that it set to the next patch version of the package.
See [gom-player](https://github.com/chocolatey-community/chocolatey-packages/blob/1849e4d17c66ff11cd48f4b8c9bf861add15bb68/automatic/gom-player/update.ps1#L38) for an example of this. Do note that you may need to create these changes as part of a PR if you cannot bypass the required checks in the repository.

After committing this change, you can do a standard fix version creation.
