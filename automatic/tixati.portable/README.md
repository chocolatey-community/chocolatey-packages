# <img src="https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@bee4bc391df114723011dbd5b8a8af2a17c6bf2e/icons/tixati.png" width="48" height="48"/> [tixati.portable](https://chocolatey.org/packages/tixati.portable)


__Tixati__ is one of the most advanced and flexible BitTorrent clients available.  And unlike many other clients, Tixati contains _NO SPYWARE, NO ADS,_ and _NO GIMMICKS._

## Features

* detailed views of all aspects of the swarm, including peers, pieces, files, and trackers
* support for magnet links, so no need to download .torrent files if a simple magnet-link is available
* super-efficient peer choking/unchoking algorithms ensure the fastest downloads
* peer connection encryption for added security
* full DHT (Distributed Hash Table) implementation for trackerless torrents, including detailed message traffic graphs and customizable event logging
* advanced bandwidth charting of overall traffic and per-transfer traffic, with separate classification of protocol and file bytes, and with separate classification of outbound traffic for trading and seeding
* highly flexible bandwidth throttling, including trading/seeding proportion adjustment and adjustable priority for individual transfers and peers
* bitfield graphs that show the completeness of all downloaded files, what pieces other peers have available, and the health of the overall swarm
* customizable event logging for each download, and individual event logs for all peers within the swarm
* expert local file management functions which allow you to move files to a different partition even while downloading is still in progress
* 100% compatible with the BitTorrent protocol
* Windows and Linux-GTK native versions available

## Notes

- This portable version of Tixati is meant to run on a USB flash drive or other portable media.  It stores all it's configuration files in the same folder as the executable binary files, and all file paths are stored in a format relative to the program executable folder.
- It is important you do not delete the "tixati_portable_mode.txt" file within the executables folder.  This file is what triggers Tixati to run in portable mode.  (The executable binaries are actually the same as the standard edition binaries.)

