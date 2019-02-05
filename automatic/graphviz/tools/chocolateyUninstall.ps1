$ErrorActionPreference = 'Stop'

@('dot','circo','sfdp','twopi') |% {Uninstall-BinFile $_}
