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

## Genral Features

- multi-platform. FreeCAD runs and behaves exactly the same way on Windows, Linux, macOS and other platforms.
- full GUI application. FreeCAD has a complete Graphical User Interface based on the Qt framework, with a 3D viewer based on Open Inventor; allowing fast rendering of 3D scenes and a very accessible scene graph representation.
- runs as a command line application. In command line mode, FreeCAD runs without its interface but with all its geometry tools. In this mode it has a relatively low memory footprint and can be used, for example, as a server to produce content for other applications.
- can be imported as a Python module FreeCAD can be imported into any application that can run Python scripts. As in command line mode, the interface part of FreeCAD is unavailable, but all geometry tools are accessible.
- workbench concept. In the FreeCAD interface, tools are grouped by workbenches. This allows you to display only the tools used to accomplish a certain task, keeping the workspace uncluttered and responsive, and allowing the application to load rapidly.
- plugin/module framework for late loading of features/data-types. FreeCAD is divided into a core application with modules that are loaded only when needed. Almost all tools and geometry types are stored in modules. Modules behave like plugins; in addition to delayed loading, individual modules can be added to or removed from an existing installation of FreeCAD.
- parametric associative document objects. All objects in a FreeCAD document can be defined by parameters. Those parameters can be modified and recomputed at any time. Since object relationships are maintained, the modification of one object will automatically propagate to any dependent objects.
- parametric primitive creation. Primitive objects such as box, sphere, cylinder, etc. can be created by specifying their geometry constraints.
- graphical modification operations. FreeCAD can perform translation, rotation, scaling, mirroring, offset (either trivial or as described in Jung/Shin/Choi) or shape conversion, in any plane of the 3D space.
- constructive solid geometry (boolean operations). FreeCAD can do constructive solid geometry operations (union, difference, intersect).
- graphical creation of planar geometry. Lines, wires, rectangles, b-splines, and circular or elliptic arcs can be created graphically in any plane of the 3D space.
- modeling with straight or revolved extrusions, sections and fillets.
- topological components like vertices, edges, wires and planes.
- testing and repairing. FreeCAD has tools for testing meshes (solid test, non-two-manifolds test, self-intersection test) and for repairing meshes (hole filling, uniform orientation).
- annotations. FreeCAD can insert annotations for text or dimensions.
- Undo/Redo framework. Everything in FreeCAD is undo/redoable, with user access to the undo stack. Multiple steps can be undone at one time.
- transaction oriented. The undo/redo stack stores document transactions, not single actions, allowing each tool to define exactly what must be undone or redone.
- built-in scripting framework. FreeCAD features a built-in Python interpreter, with an API that covers almost any part of the application, the interface, the geometry and the  representation of this geometry in the 3D viewer. The interpreter can run complex scripts as well as single commands; entire modules can be programmed completely in Python.
- built-in Python console. The Python interpreter includes a console with syntax highlighting, autocomplete and a class browser. Python commands can be issued directly in FreeCAD and immediately return results, permitting script writers to test functionality on the fly, explore the contents of FreeCAD's modules and easily learn about FreeCAD internals.
- mirrors user interaction. Everything the user does in the FreeCAD interface executes Python code, which can be printed on the console and recorded in macros.
- full macro recording and editing capabilities. The Python commands issued when the user manipulates the interface can be recorded, edited if needed, and saved to be reproduced later.
- compound (ZIP based) document save format. FreeCAD documents are saved with a .FCStd extension. The document can contain many different types of information such as geometry, scripts or thumbnail icons. The .FCStd file is itself a zip container; a saved FreeCAD file has already been compressed.
- fully customizable/scriptable Graphical User Interface. The Qt-based interface of FreeCAD is entirely accessible via the Python interpreter. Aside from simple functions FreeCAD itself provides to workbenches, the entire Qt framework is accessible. The user may perform any operation on the GUI such as creating, adding, docking, modifying or removing widgets and toolbars.
- thumbnailer. (currently only Linux systems) FreeCAD document icons show the contents of the file in most file manager applications such as Gnome's Nautilus.
- modular MSI installer. FreeCAD's installer allows flexible installations on Windows systems. Packages for Ubuntu systems are also maintained.

## Package parameters
** Used only for Portable or Pre Releases Currently **
- `/UnzipLocation` - This is the location inside the Chocolatey lib folder specific to this package.
- `/WorkingDirectory` - This will use the same location as the Unziplocation unless designated to be different.
- `/TargetPath` - This is the location of the FreeCAD.exe file when unziped from the archive file.
- `/IconLocation` - Icon location is same as FreeCAD.exe file unless designated to be different.
- `/Arguments` - This will allow you to specify any of the FreeCAD command line arguements.
- `/ShortcutFilePath` - This will place the shortcut if wanted on your Desktop.
- `/Shortcut` - This is set to place the Shortcut only if listed in the Package Parameters ( ex: /Shortcut ). The default is to not place any Shortcut.
- `/WindowStyle` - The normal window setting for most Applications is as a Window. Maximised Window would be 3.

Example: `choco install freecad --params "/UnzipLocation:'C:\FreeCAD' /Shortcut"`



