## Preparing `settings.xml` for this repo

People committing autopackages export their package-specific Ketarin `settings.xml`, which contains certain values that they used in their own setup. The core team has expressed a certain preference for settings that need to be in a specific way:

* Remove `Category`
* Set `TargetPath` to `C:\Chocolatey\_work\`
* Remove `ExecuteCommand`, this is done externally
* Remove `HttpReferer`
* ... (everything else that's in the template)

These specific settings can be set [in a template](https://github.com/chocolatey/chocolatey-coreteampackages/blob/master/bin/ketarin-template.xsl) so that these settings don't need to be fixed manually. Just apply the `xsl` to the exported `xml` settings in order to get the 'filtered' (AKA fixed) result.

We use Saxon Home Edition because most other tools only support `xslt 1.0` and __we need `xslt 2.0`__ for the kind of magic we use.

[__ketarin-filter-settings.bat__](https://github.com/chocolatey/chocolatey-coreteampackages/blob/master/bin/ketarin-filter-settings.bat) (Windows)  
[__ketarin-filter-settings.sh__](https://github.com/chocolatey/chocolatey-coreteampackages/blob/master/bin/ketarin-filter-settings.sh) (Linux)  

__Example usage:__

Imagine we have a 'tainted' `ultradefrag.ketarin.xml`. Running `ketarin-filter-settings.sh ultradefrag.ketarin.xml` will generate `ultradefrag.ketarin-fixed.xml`. This is what we want.

---

## Splitting multiple jobs

If someone exports a lot of jobs in a single file - like in the case of [adding @adgellida's packages](https://github.com/chocolatey/chocolatey-coreteampackages/pull/46) - we can split them into multiple files for single jobs.

[__ketarin-jobs-splitter.bat__](https://github.com/chocolatey/chocolatey-coreteampackages/blob/master/bin/ketarin-jobs-splitter.bat) (Windows)  
[__ketarin-jobs-splitter.sh__](https://github.com/chocolatey/chocolatey-coreteampackages/blob/master/bin/ketarin-jobs-splitter.sh) (Linux)  

__Example usage:__

Imagine we have a batch of jobs called `ketarin.xml`. Running `ketarin-jobs-splitter.sh ketarin.xml` will generate single `{{PackageName}}.ketarin.xml` files __in their respective `/automatic/{{PackageName}}/` directories.__
