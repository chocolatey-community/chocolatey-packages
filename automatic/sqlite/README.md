# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/sqlite.svg" width="48" height="48"/> [SQLite](https://chocolatey.org/packages/SQLite)

SQLite is a software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine.

This package also installs sqlite tools by default - sqldiff, sqlite3, sqlite3_analyzer.

## Features

- Transactions are atomic, consistent, isolated, and durable (ACID) even after system crashes and power failures.
- Zero-configuration - no setup or administration needed.
- Full-featured SQL implementation with advanced capabilities like partial indexes, indexes on expressions, JSON, and common table expressions. (Omitted features)
- A complete database is stored in a single cross-platform disk file. Great for use as an application file format.
- Supports terabyte-sized databases and gigabyte-sized strings and blobs. (See limits.html.)
- Small code footprint: less than 500KiB fully configured or much less with optional features omitted.
- Simple, easy to use API.
- Written in ANSI-C. TCL bindings included. Bindings for dozens of other languages available separately.
- Well-commented source code with 100% branch test coverage.
- Available as a single ANSI-C source-code file that is easy to compile and hence is easy to add into a larger project.
- Self-contained: no external dependencies.
- Cross-platform: Android, *BSD, iOS, Linux, Mac, Solaris, VxWorks, and Windows (Win32, WinCE, WinRT) are supported out of the box. Easy to port to other systems.
- Sources are in the public domain. Use for any purpose.
- Comes with a standalone command-line interface (CLI) client that can be used to administer SQLite databases.

## Package parameters

- `/NoTools` - Do not install sqlite tools

Example: `choco install sqlite --params "/NoTools"`
