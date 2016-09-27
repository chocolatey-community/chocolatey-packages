# Setup

## Ketarin / ChocolateyPackageUpdater Automatic Packaging

* Review `ketarin_setup.ps1` to ensure all items are set appropriately. Uncomment/change anything you need to now.
* Run `ketarin_setup.ps1`
* Open ketarin after installing it, open the settings and import `KetarinSettings.xml`.
* Set up push for Chocolatey community feed with your API key.
* Ensure `git push` doesn't require credentials.
* Review `ops/ketarinupdate.cmd` to ensure it is good to go.

**Note**: Use `ops/ketarinupdate.cmd` or similar to schedule updates.

## Automatic Updater (AU)

* Review `au_setup.ps1` to ensure all items are set appropriately. Uncomment/change anything you need to now.
* Run `au_setup.ps1`.
* Log into https://gist.github.com with the user you want to use to perform commits and pushes to git.
* Create an empty gist (secret or not). Grab the id at the end of it - `https://gist.github.com/name/{id}`. You will need that for `appveyor.yml` and `update_vars.ps1`.
* Now we need to set up AppVeyor and our local runs.

### Set up AppVeyor for packaging
* Go to AppVeyor and sign up/sign in. https://ci.appveyor.com/
* Set up an appveyor job - https://ci.appveyor.com/projects/new
* Select your repository to create a new job.
* Go to settings ensure the following items are set (these items cannot be configured in the yaml):
  * In Build Schedule, we want to run this three times a day - set it like this: `5 */6 * * * *`. This ensures it runs at 06:05, 12:05, and 18:05.
  * "Ensure Skip branches without `appveyor.yml`" is checked.
  * "Enable secure variables in Pull Requests from the same repository only" is checked.
  * Click Save.

* Get encrypted values for - https://ci.appveyor.com/tools/encrypt (requires login first)
  * github password (or auth token for 2FA)
  * email password
  * Chocolatey API key
* Edit the appveyor.yml to add those values in.
* Edit the appveyor.yml with the other configuration related items.

### Setup Local Runs
* Edit `au/update_vars.ps1` and set the same variables there.
* As part of setup, you ensured that you have the Ruby gem `gist` installed. Please run `gist --login` to provide your credentials
* Ensure `git push` doesn't require credentials.

**Note**: You can also set up a scheduled task for local runs.

### AU Notes

* If you use Google mail for error notifications on a build server such as AppVeyor, Google may block authentication from unknown device. To receive those emails enable less secure apps - see [Allowing less secure apps to access your account](https://support.google.com/accounts/answer/6010255?hl=en). In any case, do not use your private email for this but create a new Google account and redirect its messages to your private one. This wont affect you if you run the scripts from your own machine from which you usually access the email.
* If you are using AppVeyor you should schedule your build under the _General_ options using [Cron](http://www.nncron.ru/help/EN/working/cron-format.htm) syntax, for example `0 22 * * * *` runs the updater every night at 22h. `5 * * * * *` runs the updater every hour at five past the hour.
* For gist to work the over proxy you need to set console proxy environment variable. See [Update-CLIProxy](https://github.com/majkinetor/posh/blob/master/MM_Network/Update-CLIProxy.ps1) function.


## Additional Notes

### Preparing `settings.xml` for this repo

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

### Splitting multiple jobs

If someone exports a lot of jobs in a single file - like in the case of [adding @adgellida's packages](https://github.com/chocolatey/chocolatey-coreteampackages/pull/46) - we can split them into multiple files for single jobs.

[__ketarin-jobs-splitter.bat__](https://github.com/chocolatey/chocolatey-coreteampackages/blob/master/bin/ketarin-jobs-splitter.bat) (Windows)
[__ketarin-jobs-splitter.sh__](https://github.com/chocolatey/chocolatey-coreteampackages/blob/master/bin/ketarin-jobs-splitter.sh) (Linux)

__Example usage:__

Imagine we have a batch of jobs called `ketarin.xml`. Running `ketarin-jobs-splitter.sh ketarin.xml` will generate single `{{PackageName}}.ketarin.xml` files __in their respective `/automatic/{{PackageName}}/` directories.__
