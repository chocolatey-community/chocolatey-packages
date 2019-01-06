# [<img src="https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@c34f28fa8b47318d55fc0eb48dc53161af85e43b/icons/mono.png" height="48" width="48" /> mono](https://chocolatey.org/packages/mono)

Mono is a software platform designed to allow developers to easily create cross platform applications. Sponsored by Novell, Mono is an open source implementation of Microsoft’s .NET Framework based on the ECMA standards for C# and the Common Language Runtime. A growing family of solutions and an active and enthusiastic contributing community is helping position Mono to become the leading choice for development of Linux applications.


## Features
- [Multi-Platform][]: Runs on *Linux*, *OS X*, *BSD* and *Microsoft Windows*, including *x86*, *x86-64*, *ARM*, *s390*, *PowerPC* and much more.
- [Multi-Language][]: Develop in *C# 4.0* (including LINQ and `dynamic`), *VB 8*, *Java*, *Python*, *Ruby*, *Eiffel*, *F#*, *Oxygene* and more.
- **Binary Compatible**: Built on an implementation of the *ECMA's Common Language Infrastructure* and *C#*.
- [Microsoft Compatible API][]: Run *ASP.NET*, *ADO.NET*, *Silverlight* and *Windows.Forms* applications without recompilation.
- [Open Source, Free Software][Open Source]: Mono's runtime, compilers, and libraries are distributed using the MIT license.
- [Comprehensive Technology Coverage][]: Bindings and managed implementations of many popular libraries and protocols.

## Notes
- Starting from package version 5.8.0.127 and onwards 64bit is supported, unfortunately the 64bit version does not contain the GTK# runtime. Please either install the 32bit edition (`chocol install mono --x86`), or the [gtksharp](https://chocolatey.org/packages/gtksharp) package if this is needed.
