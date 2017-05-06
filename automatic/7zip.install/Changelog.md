# Package changelog

## Version: 16.4.0.20170506 (2017-05-06)
### Bugs
- Removed check and restart of explorer, this is no longer necessary as 7zip no longer closes explorer. (Issue [#714][i714])

## Version: 16.4.0.20170420 (2017-04-20)
### Improvements
- Added check to test for existence before starting explorer.exe

## Version: 16.4.0.20170403 (2017-04-03)
### Bugs
- Fixed wrong architecture used during install

## Version: 16.4.0.20170402 (2017-04-02)
### Bugs
- Fixed package source url

### Features/Improvements
- Added missing cross-platform and cli tags
- Added shimming (Issue [#549][i549])

## Version: 16.04 (2017-01-18)
- Migrated to the Core Team Repository

[i714]: https://github.com/chocolatey/chocolatey-coreteampackages/issues/714
[i549]: https://github.com/chocolatey/chocolatey-coreteampackages/issues/549
