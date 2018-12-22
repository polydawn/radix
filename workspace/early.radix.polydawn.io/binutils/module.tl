{
	"imports": {
		"root-min": "catalog:early.polydawn.io/monolith/busybash:v1:linux-amd64",
		"root-debian": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
		"root-builder": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
		"src-binutils": "catalog:early.hyphae.polydawn.io/sources/binutils:v2.31:src",
		"packme": "ingest:pack:tar:./packme"
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"/": "root-builder",
					"/task/src": "src-binutils",
					"/task": "packme"
				},
				"action": {
					"policy": "governor",
					"exec": [
						"/bin/bash", "-c",
						"mkdir build out ; cd build ; LDFLAGS=\"--static\" ../src/*/configure --disable-nls ; make ; DESTDIR=/task/out make install ; ls -lah /task/{build,out}"
					]
				},
				"outputs": {
					"soop": "/task/build"
					"woop": "/task/out"
				}
			}
		},
		"echo-1-rich": {
			"operation": {
				"inputs": {
					"/": "root-debian",
					"/task/bin": "build.woop"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"cd bin/usr/local/bin/; set -x; ldd readelf; ./readelf -d readelf ; exit 0"
					]
				}
			}
		},
		"echo-2-min": {
			"operation": {
				"inputs": {
					"/": "root-min",
					"/task/bin": "build.woop"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"cd bin/usr/local/bin/; set -x; ldd readelf; ./readelf -d readelf ; exit 0"
					]
				}
			}
		}
	}
	"exports": {}
}
