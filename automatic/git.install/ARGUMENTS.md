# Git Package Parameters

The following package parameters are available to be used together with the `git` and `git.install` packages.
**NOTE: Not all parameters may be available for all versions of these two packages**

- `/GitOnlyOnPath` - Puts gitinstall\cmd on path. This is also done by default if no package parameters are set.
- `/GitAndUnixToolsOnPath` - Puts gitinstall\bin on path. This setting will override `/GitOnlyOnPath`.
- `/NoAutoCrlf` - Ensure _'Checkout as is, commit as is'_. This setting **only affects new installs**, it will not override an existing `.gitconfig`.
- `/WindowsTerminal` - Makes `vim` use the regular Windows terminal instead of MinTTY terminal.
- `/NoShellIntegration` - Disables open GUI and open shell integration ( _"Git GUI Here"_ and _"Git Bash Here"_ entries in context menus).
- `/NoGuiHereIntegration` - Disables open GUI shell integration ( _"Git GUI Here"_ entry in context menus).
- `/NoShellHereIntegration` - Disables open git bash shell integration ( _"Git Bash Here"_ entry in context menus).
- `/NoCredentialManager` - Disable _Git Credential Manager_ by adding `$Env:GCM_VALIDATE='false'` user environment variable.
- `/NoGitLfs` - Disable Git LFS installation.
- `/SChannel` - Configure Git to use the Windows native SSL/TLS implementation (SChannel) instead of OpenSSL. This aligns Git HTTPS behavior with other Windows applications and system components and increases manageability in enterprise environments.
- `/NoOpenSSH` - Git will not install its own OpenSSH (and related) binaries but use them as found on the PATH.
- `/WindowsTerminalProfile` - Add a Git Bash Profile to Windows Terminal.
- `/Symlinks` - Enable symbolic links (requires the SeCreateSymbolicLink permission). Existing repositories are unaffected by this setting.
- `/DefaultBranchName:default_branch_name` - Define the default branch name.
- `/Editor:Nano|VIM|Notepad++|VisualStudioCode|VisualStudioCodeInsiders|SublimeText|Atom|VSCodium|Notepad|Wordpad|Custom editor path` - Default editor used by Git. The selected editor needs to be available on the machine (unless it is part of git for windows) for this to work.

## Experimental parameters

Warning: the following parameters are experimental in the git installer and could stop working at any point.

- `/PseudoConsoleSupport` - Enable experimental support for pseudo consoles. Allows running native console programs like Node or Python in a Git Bash window without using winpty, but it still has known bugs.
- `/FSMonitor` - Enable experimental built-in file system monitor. Automatically run a built-in file system watcher, to speed up common operations such as `git status`, `git add`, `git commit`, etc in worktrees containing many files.

Example: `choco install git.install --params "/GitAndUnixToolsOnPath /NoGitLfs /SChannel /NoAutoCrlf"`
