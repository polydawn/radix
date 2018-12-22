{
	"imports": {
		"root-min": "catalog:early.polydawn.io/monolith/minld:v1:linux-amd64",
		"root-busybash": "catalog:early.polydawn.io/monolith/busybash:v1:linux-amd64",
		"root-debian": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
		"root-builder": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
		"packme": "ingest:pack:tar:./packme"
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"/": "root-builder",
					"/task": "packme"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"gcc hello.c -o hello.dyn; gcc -static hello.c -o hello.static; gcc hello.c -Wl,-rpath=\\$ORIGIN/. -o hello.rpath; ls -lah; ldd hello.*; ln -s /dev/zero libc.so.6 ; ldd hello.* ; exit 0"
					]
				},
				"outputs": {
					"woop": "/task"
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
						"ls -lah bin; set -x; ldd bin/hello.*; ./bin/hello.static ; ./bin/hello.dyn ; ./bin/hello.rpath ; exit 0"
					]
				}
			}
		},
		"echo-2-musl": {
			"operation": {
				"inputs": {
					"/": "root-busybash",
					"/task/bin": "build.woop"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"ls -lah bin; set -x; ldd bin/hello.dyn; ldd bin/hello.static; ldd ./bin/hello.rpath; ./bin/hello.static ; ./bin/hello.dyn ; ./bin/hello.rpath ; exit 0"
					]
				}
			}
		},
		"echo-3-minld-static": {
			"operation": {
				"inputs": {
					"/": "root-min",
					"/task/bin": "build.woop"
				},
				"action": {
					"exec": [
						"/task/bin/hello.static"
					]
				}
			}
		}
		"echo-4-minld-dyn": {
			"operation": {
				"inputs": {
					"/": "root-min",
					"/task/bin": "build.woop"
				},
				"action": {
					"exec": [
						"/task/bin/hello.dyn"
					]
				}
			}
		}
	}
	"exports": {}
}
