# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/freecad.svg" width="48" height="48"/> [freecad](https://chocolatey.org/packages/freecad)

FreeCAD is a general purpose feature-based, parametric 3D modeler for CAD, MCAD, CAx, CAE and PLM, aimed directly at mechanical engineering and product design but also fits a wider range of uses in engineering, such as architecture or other engineering specialties. It is 100 % Open Source and extremely modular, allowing for very advanced extension and customization.

FreeCAD is based on OpenCasCade, a powerful geometry kernel, features an Open Inventor-compliant 3D scene representation model provided by the Coin 3D library, and a broad Python API. The interface is built with Qt. FreeCAD runs exactly the same way on Windows, Mac OSX and Linux platforms.


## Key Features
- A complete Open CASCADE Technology-based geometry kernel allowing complex 3D operations on complex shape types, with native support for concepts like Boundary Representation (brep), Non-uniform rational basis spline (nurbs) curves and surfaces, a wide range of geometric entities, boolean operations and fillets, and built-in support of STEP and IGES formats
- A full parametric model. All FreeCAD objects are natively parametric, meaning their shape can be based on properties or even depend on other objects. All changes are recalculated on demand, and recorded by an undo/redo stack. New object types can be added easily, and can even be fully programmed in Python.
- A modular architecture that allows plugin extensions (modules) to add functionality to the core application. An extension can be as complex as a whole new application programmed in C++ or as simple as a Python script or self-recorded macro. You have complete access to almost any part of FreeCAD from the built-in Python interpreter, macros or external scripts, be it geometry creation and transformation, the 2D or 3D representation of that geometry (scenegraph) or even the FreeCAD interface
- Import/export to standard formats such as STEP, IGES, OBJ, STL, DXF, SVG, STL, DAE, IFC or OFF, NASTRAN, VRML in addition to FreeCAD's native FCStd file format. The level of compatibility between FreeCAD and a given file format can vary, since it depends on the module that implements it.
- A Sketcher with integrated constraint-solver, allowing you to sketch geometry-constrained 2D shapes. The constrained 2D shapes built with Sketcher may then be used as a base to build other objects throughout FreeCAD.
- A Robot simulation module that allows you to study robot movements in a graphical environment.
- A technical drawing module with options for detail views, cross sectional views, dimensioning and others, allowing you to generate 2D views of existing 3D models. The module then produces ready-to-export SVG or PDF files. An older Drawing module with sparse Gui-commands but a powerful Python functionality also exists.
- A Rendering module that can export 3D objects for rendering with external renderers. It currently only supports povray and LuxRender, but is expected to be extended to other renderers in the future.
- An Architecture module that allows Building Information Modeling (BIM)-like workflow, with Industry Foundation Classes (IFC) compatibility.
- A Path module dedicated to mechanical machining for Computer Aided Manufacturing (CAM). Using the Path module you may output, display and adjust the G code used to control the target machine.
- An Integrated Spreadsheet and an expression parser which may be used to drive formula-based models and organize model data in a central location.

## Package parameters
** Used only for Portable or Pre Releases Currently **
- `/UnzipLocation` - This is the location inside the Chocolatey lib folder specific to this package.
- `/WorkingDirectory` - This will use the same location as the Unziplocation unless designated to be different.
- `/TargetPath` - This is the location of the FreeCAD.exe file when unziped from the archive file.
- `/IconLocation` - Icon location is same as FreeCAD.exe file unless designated to be different.
- `/Arguments` - This will allow you to specify any of the FreeCAD command line arguements.
- `/NoShortcut` - This will set not place the Shortcut on the Desktop by default.
- `/WindowStyle` - The normal window setting for most Applications is as a Window. Maximised Window would be 3.

Example: `choco install freecad --params "/UnzipLocation:'C:\FreeCAD' /NoShortcut"`
