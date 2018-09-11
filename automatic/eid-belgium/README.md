# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/5f317458cb64cb6465bb90336989d405be46066a/icons/eid-belgium.png" width="48" height="48"/> [eid-belgium](https://chocolatey.org/packages/eid-belgium)

This package contains the BeID middleware to be used with the Belgian electronic identity card.

This piece of software is needed by smartcard applications to make the card recognized properly by them.

With this middleware, you can:

* Communicate with secure websites that require eID authentication
* Sign documents and emails using your eID
* Using the viewer, read the identity data on eID cards, verify their validity, and store them for future usage
* Using the provided API, do all of the above in custom applications of your own.

## Notes

- This package only contains the middleware, if you want to be able to use your browser to verify your identity online or sign a document with an app, this obviously requires dedicated software. If you just want to be able to read and check data from your card or simply change your PIN code, you can also install the [official viewer](https://chocolatey.org/packages/eid-belgium-viewer).
