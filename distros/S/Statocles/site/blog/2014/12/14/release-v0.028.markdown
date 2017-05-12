---
author: preaction
last_modified: 2014-12-14 06:16:20
tags: release
title: Release v0.028
---
This release adds automatic rebuilding of the site when changes are made (OSX
only, so far). We're now using Mojo::Log for logging (instead of a hacked up
`diag()` sub).

A breaking change to applications: The `index()` method is no longer used by
the site to determine what is the front page of the app, appropriate to
transform into the front page of the site. Now, the first item returned by
`pages()` must be the index page. This reduces the number of methods
applications need, and made it easier to implement the automatic rebuilding.

Finally, some much-needed cleanup as part of the automatic rebuilding feature.
Still plenty of cleanup to go.

Full changelog:

---

* [set the default log level to "info"](https://github.com/preaction/Statocles/commit/65cf7b77c37f140447eb8fbff0a6beed6d2eb554)
* [fix test only emits "Watching" if we have the right module](https://github.com/preaction/Statocles/commit/3794f261c21512c791c731640fda04c36fd6ddf3)
* [use bundles to remove extra Base modules](https://github.com/preaction/Statocles/commit/2aaffc3a6a6a009cc648c327fef162e0b319d01f) ([#128](https://github.com/preaction/Statocles/issues/128))
* [fix new "redundant argument in sprintf warning"](https://github.com/preaction/Statocles/commit/a88422ea3fba7058ee31041e48b3246d4dff59d0) ([#121](https://github.com/preaction/Statocles/issues/121))
* [change all instances of print to say](https://github.com/preaction/Statocles/commit/1124203ca2ead63507d57e656dca2bfb0583f5de)
* [use Mojo::Log for logging](https://github.com/preaction/Statocles/commit/baa115c99653bc4ca0731f320b2b59e419998402) ([#122](https://github.com/preaction/Statocles/issues/122))
* [create type library for types and coercions](https://github.com/preaction/Statocles/commit/2f69b22a347f16713fd9c3a2a65af46cca91110e) ([#122](https://github.com/preaction/Statocles/issues/122))
* [watch for filesystem events and rebuild the site](https://github.com/preaction/Statocles/commit/c2a201378af91dd6f43ab5f1b57e1f11557598ad) ([#154](https://github.com/preaction/Statocles/issues/154))
* [remove index method from apps](https://github.com/preaction/Statocles/commit/4f9fa65278b2e62188b59fe8dbf82648fc5905cc) ([#141](https://github.com/preaction/Statocles/issues/141), [#142](https://github.com/preaction/Statocles/issues/142))
* [remove caching from Blog app](https://github.com/preaction/Statocles/commit/518eefc500b6b7c7b19bf53c48f8e06ed5496224) ([#154](https://github.com/preaction/Statocles/issues/154), [#153](https://github.com/preaction/Statocles/issues/153), [#141](https://github.com/preaction/Statocles/issues/141))
* [add clear method to theme to clear template cache](https://github.com/preaction/Statocles/commit/2289eb0b3f2891ba7bad722f71bc59536e4f9ea4)
* [add method to clear document cache](https://github.com/preaction/Statocles/commit/d50c95aaf11f896c885496b16648f65e870e9072)
* [clean up reading documents and parsing frontmatter](https://github.com/preaction/Statocles/commit/6e9147cd35b6e8150e98e5f241365bb37284ca62) ([#149](https://github.com/preaction/Statocles/issues/149))
* [remove the Statocles site.yml from CPAN tarballs](https://github.com/preaction/Statocles/commit/c4eeb50db506c9337db23c5879137fca235b3163)
