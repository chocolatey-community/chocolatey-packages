$ErrorActionPreference = 'Stop'

@('dot','circo','sfdp','twopi') |ForEach-Object {Uninstall-BinFile $_}
