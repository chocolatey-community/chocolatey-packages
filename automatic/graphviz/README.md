# [<img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@00f392142cdbdbda147d3cc3ccb1cb593afb996d/icons/graphviz.png" width="48" height="48"/> graphviz](https://chocolatey.org/packages/graphviz)

Graph visualization is a way of representing structural information as diagrams of abstract graphs and networks. It has important applications in networking, bioinformatics, software engineering, database and web design, machine learning, and in visual interfaces for other technical domains.

Graphviz is open source graph visualization software. It has several main layout programs. See the gallery for sample layouts. It also has web and interactive graphical interfaces, and auxiliary tools, libraries, and language bindings. We're not able to put a lot of work into GUI editors but there are quite a few external projects and even commercial tools that incorporate Graphviz. You can find some of these in the Resources section.

The Graphviz layout programs take descriptions of graphs in a simple text language, and make diagrams in useful formats, such as images and SVG for web pages; PDF or Postscript for inclusion in other documents; or display in an interactive graph browser.

Graphviz has many useful features for concrete diagrams, such as options for colors, fonts, tabular node layouts, line styles, hyperlinks, and custom shapes.

## Notes

- Starting from version [2.44.1](https://chocolatey.org/packages/Graphviz/2.44.1.20201124) this package contains cmake builds of Graphviz. If you encounter problems with missing executables for the time being continue using the last msbuild version [2.38](https://chocolatey.org/packages/Graphviz/2.38.0.20190211). You can also try to use alternative syntax, for example instead calling `neato.exe` directly, use `dot.exe -Kneato` instead. For more details see [this topic](https://github.com/chocolatey-community/chocolatey-coreteampackages/pull/1535#issuecomment-704700216).

![screenshot](https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/master/automatic/graphviz/screenshot.svg)
