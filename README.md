# SPS extra package collection

This repository contains the official SPS source definitions outside the
minimal base system. It is the place for graphics, Wayland and X11, desktop
software, audio and multimedia, editors, additional development tools,
language runtimes, shells, networking applications, fonts, and general
utilities.

Package categories are organizational and are created only when they contain a
package:

```text
audio/  desktop/  devel/  editors/  fonts/  graphics/  libs/
multimedia/  net/  shells/  utils/  wayland/  xorg/
```

Configure the tree after core:

```text
git core https://github.com/RobertFlexx/sps-core.git 100
git extra https://github.com/RobertFlexx/sps-extra.git 80
```

Then run:

```sh
src update
src search mesa
src show mesa
src which mesa
```

Git checkouts default to `/usr/src/sps/core` and `/usr/src/sps/extra`. They are
ordinary repositories and may be inspected or pinned with Git. A local tree at
priority 200 can override either official collection.

Build a package from its directory with `mkpkg`, inspect the result, and test
installation/check/removal in a disposable SPS root. See the SPS package
maintainer guide for the exact recipe syntax and verification procedure.

Changes to `main` must keep the selected dependency graph valid. Use canonical
stable sources and verified SHA-256 hashes. Do not commit source downloads,
binary package archives, or build logs. Large stacks are added in dependency
layers; an unbuilt leaf recipe does not belong on `main` merely because its
metadata looks plausible.
