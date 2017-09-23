# <img src="" width="48" height="48"/> [pcwrunas](https://chocolatey.org/packages/pcwrunas)


pcwRunAs works similar to the Microsoft tool `runas.exe` but it also takes on the command line additional parameter password, allowing the program to start without additional inputs.

After installing pcwRunAs you find two more tools on your hard disk: `pcwRunAsGui` used for the easy creation of links that allow you to start programs in a restricted account or an Administrator and `pcwPrivilegien.DLL` is for the status display in IE and Windows Explorer.

PcwRunAs is intended exclusively for use on your home PC.

```
PcwRunAs v0.4 by  prx@pcwelt.de

Use: pcwRunAs4 [/?] [/d <domain>] [/profile /netonly]
/u name /p password
[/dir] [/app <app>] | [/arg <cmd>]
or [/e string]

/d       domain login
/u       user name
/p       password
/profile User profile
/netonly credentials only valid for remote access (domain)
/app     path to the application
/arg     Additional parameters for application
/dir     working directory
/e       encrypted string (as the only option)
/?       Shows this help

Examples: pcwRunAs4 /u hugo /p secret /app notepad.exe
PcwRunAs4 /u hugo /p secret /app notepad.exe /arg "C:\NewFile.txt"
```

## Notes

- The software is available only on German language.

