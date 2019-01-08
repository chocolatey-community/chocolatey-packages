# <img src="https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@6e52bf3b9392bc72475a3e254eab23578ccb9d0e/icons/PDFCreator.png" width="48" height="48"/> [PDFCreator](https://chocolatey.org/packages/PDFCreator)


PDFCreator easily creates PDFs from any Windows program. Use it like a printer in Word, StarCalc or any other Windows application.

## Features

- Convert your documents to PDF, JPG, PNG, TIF and PDF/A
- Merge and arrange multiple documents to one file
- Profiles make frequently used settings available with one click
- Use automatic saving to have a fully automated PDF printer
- Secure against opening, printing or modifying your PDFs with a password
- Support for digital signatures
- COM interface for application or scripted actions
- PDFCreator is Open Source software and licensed under the terms of the Affero General Public License (AGPL)
- You are free to use PDFCreator at home or at work
- You may access the source code and compile it on your own, as long as it stays under the AGPL

## Notes
The installer has a few options that can be configured via the --ia switch:

- `/NOICONS` - No desktop or Start Menu icons will be created
- `/TASKS=!winexplorer` - No integration with explorer. (I.E. no context menu)
- `/Printername=(name)` - Use a custom printer name (default: *PDFCreator*)

Example use:

`choco install pdfcreator --ia '"/NOICONS /TASKS=!winexplorer"'`
