#!/bin/bash
#
# This script is for building projects which use `./configure && make` style builds.
#
# We assume that your source is in "./src",
# and we make dirs "./build" and "./out" for tmpfiles and results, respectively.
# So, usually your formula will have "./out" as an output (though you may (very)
# likely want to do more cleanups/reduction of that dir as well before saving).
#
set -euo pipefail

(set -x
	mkdir ./build ./out
	time (cd build
		LDFLAGS="-Wl,-rpath=XORIGIN/../lib"
		../src/configure
	)
	time (cd build
		make
	)
	time (cd build
		DESTDIR=../out make install
	)
)
echo ---
ls -lah /task/{build,out}
echo ---
du -sh /task/{build,out}/*
