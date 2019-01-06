# <img src="https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@04a664cc932597e990efa9772dfc16114f18bed8/icons/datagrip.png" width="48" height="48"/> [datagrip](https://chocolatey.org/packages/datagrip)


DataGrip is the multi-engine database environment.
We support MySQL, PostgreSQL, Microsoft SQL Server, Oracle, Sybase, DB2, SQLite,
HyperSQL, Apache Derby and H2. If the DBMS has a JDBC driver you can connect to
it via DataGrip. For any of supported engines it provides database introspection
and various instruments for creating and modifying objects.

## Features
- Intelligent query console
- Efficient schema navigation
- Explain plan
- Smart code completion
- On-the-fly analysis and quick-fixes
- Refactorings that work in SQL files and schemas
- Version control integration

## Package Parameters
- `/InstallDir:`- Installation directory, defaults to the 'Program Files (x86)\DataGrip*' directory.

**note** the InstallDir folder should be an empty folder.

Example: `choco install datagrip --params "/InstallDir:C:\your\install\path"`