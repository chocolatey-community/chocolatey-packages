# IntuneWinAppUtil usage

## Sample usage

Sample commands to use for the Microsoft Win32 Content Prep Tool:

- IntuneWinAppUtil -v
  - This will show the tool version (Only available starting version 1.8.2).
- IntuneWinAppUtil -h
  - This will show usage information for the tool.
- IntuneWinAppUtil -c &lt;setup_folder&gt; -s &lt;source_setup_file&gt; -o &lt;output_folder&gt; &lt;-q&gt;
  - This will generate the .intunewin file from the specified source folder and setup file.
  - For MSI setup file, this tool will retrieve required information for Intune.
  - If -a is specified, all catalog files in that folder will be bundled into the .intunewin file.
  - If -q is specified, it will be in quiet mode. If the output file already exists, it will be overwritten.
  - Also if the output folder does not exist, it will be created automatically.
- IntuneWinAppUtil
  - If no parameter is specified, this tool will guide you to input the required parameters step by step.

## Parameters

Command-line parameters available

- -h Help
- -v Tool version (Only available starting version 1.8.2).
- -c &lt;setup_folder&gt; Setup folder for all setup files. All files in this folder will be compressed into .intunewin file.
  - Only the setup files for this app should be in this folder.
- -s &lt;setup_file&gt; Setup file (e.g. setup.exe or setup.msi).
- -o &lt;output_file&gt; Output folder for the generated .intunewin file.
- -a &lt;catalog_folder&gt; Catalog folder for all catalog files. All files in this folder will be treated as catalog file for Win10 S mode.

**Note: The generated .intunewin file contains all compressed and encrypted source setup files and the encryption information to decrypt it. Please keep it in the safe place as your source setup files.**