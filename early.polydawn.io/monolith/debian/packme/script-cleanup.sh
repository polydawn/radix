#!/bin/bash
set -euo pipefail
set -x

export PATH="/app/debuerreotype/scripts/:$PATH"

# scrape out sources of unreproducibility
# (documented in debuerreotype/.tar-exclude, but we replicate here because we don't use tar like that.)
(set +e # if these paths are already empty, that's surely fine.
rm -r ./chroot/debuerreotype-epoch
rm -r ./chroot/proc/*
rm -r ./chroot/sys/*
rm -r ./chroot/var/cache/apt/*
rm -r ./chroot/var/lib/apt/lists/*
rm -r ./chroot/etc/apt/apt.conf.d/01autoremove-kernels
rm -r ./chroot/var/log/apt/history.log
rm -r ./chroot/var/log/apt/term.log
rm -r ./chroot/run/motd.dynamic
rm -r ./chroot/etc/apt/trustdb.gpg
rm -r ./chroot/var/lib/systemd/catalog/database
# more (these are in debuerreotype-fixup instead of the tar-excludes for some reason)
rm ./chroot/var/log/dpkg.log
rm ./chroot/var/log/bootstrap.log
rm ./chroot/var/log/alternatives.log
rm ./chroot/var/cache/ldconfig/aux-cache
)

# replace the date-locked snapshot.d.o apt urls with present-tense ones.
# if someone runs more apt commands in the future, we suppose they want latest.
debuerreotype-gen-sources-list ./chroot \$DISTRIBUTION http://deb.debian.org/debian http://security.debian.org
# FIXME lol the... th.... this expects the debur epoch file?  fuck off matey
# ... also maybe this doesn't do what my comment above suspected it does.
