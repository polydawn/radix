#!/bin/bash
set -euo pipefail
set -x

export DEBOOTSTRAP_DIR="$(echo /app/debootstrap/*)"
export PATH="/app/debuerreotype/scripts/:$DEBOOTSTRAP_DIR:$PATH"

debuerreotype-init --no-merged-usr ./chroot $DISTRIBUTION $TIMESTAMP
debuerreotype-minimizing-config ./chroot
echo 'nameserver 8.8.8.8' > ./chroot/etc/resolv.conf
