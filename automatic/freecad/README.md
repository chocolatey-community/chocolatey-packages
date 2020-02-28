# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/freecad.svg" width="48" height="48"/> [freecad](https://chocolatey.org/packages/freecad)

FreeCAD is a general purpose feature-based, parametric 3D modeler for CAD, MCAD, CAx, CAE and PLM, aimed directly at mechanical engineering and product design but also fits a wider range of uses in engineering, such as architecture or other engineering specialties. It is 100 % Open Source and extremely modular, allowing for very advanced extension and customization.

FreeCAD is based on OpenCasCade, a powerful geometry kernel, features an Open Inventor-compliant 3D scene representation model provided by the Coin 3D library, and a broad Python API. The interface is built with Qt. FreeCAD runs exactly the same way on Windows, Mac OSX and Linux platforms.

## Features
- A full parametric model,and modular architecture that allows plugin extensions (modules) to add functionality to the core application.
- Import/export to standard formats such as STEP, IGES, OBJ, STL, DXF, SVG, STL, DAE, IFC or OFF, NASTRAN, VRML in addition to FreeCAD's native FCStd file format.
- A Robot simulation module that allows you to study robot movements in a graphical environment.
- A technical drawing module with options for detail views, cross sectional views, dimensioning and others, allowing you to generate 2D views of existing 3D models.
- A Rendering module that can export 3D objects for rendering with external renderers. 
- A Path module dedicated to mechanical machining for Computer Aided Manufacturing (CAM). 

## Package parameters
#### Used only for Portable or Pre Releases Currently
- `/InstallDir` - This is the location inside the Chocolatey lib folder specific to this package.
- `/Arguments` - This will allow you to specify any of the FreeCAD command line arguements.
- `/NoShortcut` - This will not set a Shortcut on the Desktop.
- `/WindowStyle` - The normal window setting for most Applications is as a Window. Maximised Window would be 3.

Example: `choco install freecad --params "/InstallDir:'C:\FreeCAD' /NoShortcut"`
