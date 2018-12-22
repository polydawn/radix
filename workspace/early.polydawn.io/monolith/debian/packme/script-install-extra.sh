#!/bin/bash
set -euo pipefail
set -x

export PATH="/app/debuerreotype/scripts/:$PATH"

# note that all the apt sources list are still the snapshots.d.o paths,
# so these installs should be "reproducible" (relatively).
debuerreotype-apt-get ./chroot update -qq
debuerreotype-apt-get ./chroot dist-upgrade -yqq
debuerreotype-apt-get ./chroot install -y --no-install-recommends inetutils-ping iproute2 wget curl ca-certificates
debuerreotype-slimify ./chroot
