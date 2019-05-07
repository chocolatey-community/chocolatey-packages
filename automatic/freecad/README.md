# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/freecad.svg" width="48" height="48"/> [freecad](https://chocolatey.org/packages/freecad)


FreeCAD is a general purpose feature-based, parametric 3D modeler for CAD, MCAD, CAx, CAE and PLM, aimed directly at mechanical engineering and product design but also fits a wider range of uses in engineering, such as architecture or other engineering specialties. It is 100 % Open Source and extremely modular, allowing for very advanced extension and customization.

FreeCAD is based on OpenCasCade, a powerful geometry kernel, features an Open Inventor-compliant 3D scene representation model provided by the Coin 3D library, and a broad Python API. The interface is built with Qt. FreeCAD runs exactly the same way on Windows, Mac OSX and Linux platforms.

This Package Uses Package Parameters to add/adjust for the pre package.
The Default location of the following Package Parameters are:

This is the location inside the Chocolatey lib folder specific to this package
UnzipLocation "${env:ChocolateyPackageFolder}\tools\${env:ChocolateyPackageTitle}"

This will use the same location as the Unziplocation unless designated to be different
WorkingDirectory = $pp['UnzipLocation']

This is the location of the FreeCAD.exe file when unziped from the archive file.
TargetPath = $pp['WorkingDirectory']+"\bin\${env:ChocolateyPackageTitle}.exe"

Icon location is same as FreeCAD.exe file unless designated to be different
IconLocation = $pp['TargetPath']

This will allow you to specify any of the FreeCAD command line arguements
Arguments = ""

This will place the shortcut if wanted on your Desktop.
ShortcutFilePath = ( [Environment]::GetFolderPath('Desktop') )

This is set to place the Shortcut only if listed in the Package Parameters ( ex: /Shortcut ). The default is to not place any Shortcut
Shortcut = $true

The normal window setting for most Applications is as a Window. Maximised Window would be 3
WindowStyle = 1

All Package Paramaters are adjustable.
