# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/autohotkey.png" width="48" height="48"/> [autohotkey.install](https://chocolatey.org/packages/autohotkey.install)


AutoHotkey is a free, open source macro-creation and automation software utility that allows users to automate repetitive tasks. It is driven by a custom scripting language that is aimed specifically at providing keyboard shortcuts, otherwise known as hotkeys.

**You can use AutoHotkey to**:

- Automate almost anything by sending keystrokes and mouse clicks.
- You can write a mouse or keyboard macro by hand or a macro recorder.
- Remap keys and buttons on your keyboard, joystick, and mouse.
- Create hotkeys for keyboard, joystick, and mouse.
- Essentially any key, button or combination can become a hotkey.
- Expand abbreviations as you type them.
- Retrieve and change the clipboard's contents.
- Convert any AHK script into an executable file that can be run on computers where AutoHotkey is not installed.

**You can also**:

- Create custom data-entry forms, user interfaces and menu bars.
- See GUI for details (you can use a Gui editor).
- Automate data entry jobs by reading data from text files, XML, CSV, Excel and various database formats.
- Read signals from hand-held remote controls via the WinLIRC client script.
- Use the Component Object Model (COM).
- Use array/associative array/OOP (Objects).
- Use variadic functions.
- Use DLL calls and Windows Messages.
- Use Perl Compatible Regular Expressions (PCRE).
- Use interactive debugging features and more.

**Package Parameters**:

If you want the default version to be Unicode32/64-bit or ANSI 32-bit you can choose this by passing one of the following commands:

- UNICODE 64-bit - `choco install autohotkey.install --params="'/DefaultVer:U64'"`
- UNICODE 32-bit - `choco install autohotkey.install --params="'/DefaultVer:U32'"`
- ANSI 32-bit - `choco install autohotkey.install --params="'/DefaultVer:A32'"`

If no paramater is specified then UNICODE 32-bit or 64-bit will automatically be selected depending on your CPU Architecture and whether you have Windows 32-bit or 64-bit installed.
