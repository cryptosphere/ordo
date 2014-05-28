![ORDO: Ordered Representation for Distinguished Objects](https://raw.githubusercontent.com/cryptosphere/ordo/master/logo.png)
=========================================================

[![Build Status](https://travis-ci.org/cryptosphere/ordo.png?branch=master)](https://travis-ci.org/cryptosphere/ordo)
[![Code Climate](https://codeclimate.com/github/cryptosphere/ordo.png)](https://codeclimate.com/github/cryptosphere/ordo)
[![Coverage
Status](https://coveralls.io/repos/cryptosphere/ordo/badge.png?branch=master)](https://coveralls.io/r/cryptosphere/ordo?branch=master)

ORDO is a data interchange format intended for representing certificates and
cryptographic keys. We seek to achieve the following:

* Security
* Human Readability
* Ease of Use
* Simplicity

ORDO is being used in the following projects:

* [Cryptor](https://github.com/cryptosphere/cryptor/)
* [Confusion](https://github.com/cryptosphere/confusion/)
* [Cryptosphere](https://github.com/cryptosphere/cryptosphere/)

## The Case for a New Certificate Format

Creating a new certificate format is not a task we undertake lightly. It's
something we do as day-to-day users of X.509 certificates who strive to
understand X.509's motivations and why the system exists as it is today.

X.509 has a number of shortcomings, both in terms of usability and formal
language theory. ORDO seeks to address these.

We realize that reinventing the wheel can be unhelpful (cue [obligatory XKCD
comic][standards-comic]) but we also feel like the wheels we're rolling on now
may be somewhat misshapen.

ORDO has been designed with the following goals in mind:

* **Human-readable**: Documents can be read and written by humans without
  the need for special tools, so long as the grammar is adhered to. They should
  also be pleasant to read!
* **Unambiguous**: ORDO seeks to actively identify any possible ambiguities in
  the format and aggressively specify answers for what must and should be done
  depending on the context. The goal is a format which is strict and rigorous
  where all conforming implementations agree on all details of the format.
* **Distinguished**: The structure of an ORDO document is exactingly described
  in such a way that there is one and only one possible representation of
  a given set of data, such that tools given the same inputs to generate a
  certificate will always produce the same document every time in a fully
  deterministic manner.
* **User friendly**: As much as possible, special tools should not be needed
  (but might be appreciated) to accomplish most work involving certificates.
  This includes assembling certificate chains, signing certificates, and
  combining certificates with private keys.
* **LANGSEC friendly**: the most popular existing certificate format, X.509,
  was designed without a proper understanding of the [security applications
  of formal language theory][langsec]. ORDO solves these concerns by describing
  the format in terms of a [context free grammar][cfg] which is unambiguous and
  should be possible to implement consistently everywhere from the description.

For more information on LANGSEC, please check out [Occupy Babel][occupy]:

![Context Free Or Regular](http://www.cs.dartmouth.edu/~sergey/langsec/occupy/WeirdMachines.jpg)

[standards-comic]: http://xkcd.com/927/
[langsec]: http://www.cs.dartmouth.edu/~sergey/langsec/
[cfg]: https://en.wikipedia.org/wiki/Context-free_grammar
[peg]: https://en.wikipedia.org/wiki/Parsing_expression_grammar
[kpeg]: https://github.com/evanphx/kpeg
[occupy]: http://www.cs.dartmouth.edu/~sergey/langsec/occupy/

## Inspirations

ORDO is inspired by a number of sources:

* X.509
* HTTP
* JSON
* YAML
* TOML/"INI"
* Cryptonomicon

## Example

The following certificate represents a user with a Curve25519 public key:

```
-----BEGIN ORDO CERTIFICATE BLOCK-----
email:
  root@eruditorum.org
expires:
  2025-01-01T00:00:00Z
public-key:
  ordo.public-key+curve25519:4uj6lwvvsx3bfl6novr36wdzlr6uuovkkf
  rovmckd5uakwdlwiva
subject:
  ordo.dn:///C=US/ST=California/L=San+Francisco/O=Cryptosphere+
  Foundation/OU=Certificate+Department/CN=ORDO
-----END ORDO CERTIFICATE BLOCK-----
```

Some quick things to note:
* We continue to use the familiar block delimiters for the beginning
  and end of the certificate
* We linewrap at 64 characters, and indent to the column matching
  the length of the key name plus 2 characters (the ': ' delimiter)
* Key names are lower case, may contain the "-" character, and are
  sorted in alphabetical order
* Public keys and subjects are provided as URIs
* Binary data is encoded using Base32
* Spaces, not tabs. Trailing whitespace is not allowed.

We identify individual certificates using a content hashing scheme inspired
by RFC6920 "Naming Things with Hashes". The following URI uniquely identifies
this particular certificate:

```
ordo.id:///blake2b;lwxgjvaph2mode3zhrogwdhobuuaej4buc5nl6kbqiubshozocda
```

This URI acts as a sort of universally unique identifier, and also
specifies a content hash that can be used to digitally sign this
particular certificate.
