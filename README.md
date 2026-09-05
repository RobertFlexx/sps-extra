# SPS extra package collection

This repository is the official extra recipe tree for **SPS Linux**
(informally Splux): graphics, Wayland and X11, desktop software, audio,
editors, extra development tools, language runtimes, shells, networking,
fonts, and general utilities. Recipes only; no source tarballs or binary
packages.

SPS the package system is not tied to Splux. An LFS or custom root can index
this tree with `src` and install packages with `sget`. `setup` profiles such
as `plasma-desktop`, `init-systemd`, and `init-openrc` are SPS Linux
installer conveniences. Your LFS book may choose a different init, display
stack, or disk layout; nothing here forces you to run `setup`.

Package categories are organizational and are created only when they contain a
package:

```text
admin/  audio/  cli/  desktop/  devel/  disk/  editors/  firmware/  fonts/
graphics/  kdeapps/  kf6/  lang/  libs/  net/  nvidia/  plasma/  print/
qt6/  shells/  sys/  term/  www/  x11/
```

Configure the tree after core:

```text
git core https://github.com/RobertFlexx/sps-core.git 100
git extra https://github.com/RobertFlexx/sps-extra.git 80
# git community https://github.com/RobertFlexx/sps-community.git 50
```

Then run:

```sh
src update
src search nano
src show nano
src which nano
```

Git checkouts default to `/usr/src/sps/core` and `/usr/src/sps/extra`. They are
ordinary repositories and may be inspected or pinned with Git. A local tree at
priority 200 can override either official collection.

Installer profiles `plasma-desktop` and `plasma-full` select a Plasma 6
session, optional KDE applications, NVIDIA open kernel modules, Flatpak, and
language/devel sets. Init is a choice: `init-systemd` (the setup default) or
`init-openrc`. Those packages `conflict`, so `sget` will not install systemd
next to OpenRC or eudev. Qt 6, KDE Frameworks, and Plasma leaves use verified
SHA-256 hashes so `src update` can index the graph. Compile those stacks in
dependency layers: pkgconf, Python, ninja/meson/cmake, libraries, Qt,
Frameworks, then Plasma.

Build a package from its directory with `mkpkg`, inspect the result, and test
installation/check/removal in a disposable SPS root. See the SPS package
maintainer guide for the exact recipe syntax and verification procedure.

Changes to `main` must keep the selected dependency graph valid. Use canonical
stable sources and verified SHA-256 hashes. Do not commit source downloads,
binary package archives, or build logs. Large stacks are added in dependency
layers; an unbuilt leaf recipe does not belong on `main` merely because its
metadata looks plausible.

Packages that are not ready for extra belong in
[sps-community](https://github.com/RobertFlexx/sps-community). That collection
is opt-in: Splux does not enable it from `setup` or `mkiso`. Promote a package
here only after it has been built and used.
