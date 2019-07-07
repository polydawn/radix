{
	"imports": {
		"base-builder": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
		"src-m4": "catalog:early.hyphae.polydawn.io/sources/m4:v1.4.18:src",
		"app-smsh": "catalog:early.radix.polydawn.io/smsh:candidate:bin-linux-amd64",
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"/": "base-builder",
					"/task/src": "src-m4",
					"/app/smsh": "app-smsh"
				},
				"action": {
					"env": {
						"LDFLAGS": "--static"
					},
					"exec": [
						"/app/smsh/bin/smsh",
						"ls -lah",
						"mkdir ./{build,out}",
						"ln -s . ./out/PREFIX-IS-EVIL",
						"cd build ; ../src/*/configure --prefix=/PREFIX-IS-EVIL --disable-nls",
						"cd build ; make",
						"cd build ; DESTDIR=/task/out/ make install",
						"rm ./out/PREFIX-IS-EVIL",
						"ls -lah {out,out/*}"
					]
				},
				"outputs": {
					"out": "/task/out"
				}
			},
		}
	},
	"exports": {
		"bin-linux-amd64": "build.out"
	}
}
