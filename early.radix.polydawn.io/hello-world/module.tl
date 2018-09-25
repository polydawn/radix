{
	"imports": {
		"root-min": "catalog:early.polydawn.io/monolith/busybash:v1:linux-amd64",
		"root-debian": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
		"root-builder": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
		"packme": "ingest:pack:tar:./packme"
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"root-builder": "/",
					"packme": "/task"
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
					"root-debian": "/",
					"build.woop": "/task/bin"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"ls -lah bin; set -x; ldd bin/hello.*; ./bin/hello.static ; ./bin/hello.dyn ; ./bin/hello.rpath ; exit 0"
					]
				}
			}
		},
		"echo-2-min": {
			"operation": {
				"inputs": {
					"root-min": "/",
					"build.woop": "/task/bin"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"ls -lah bin; set -x; ldd bin/hello.dyn; ldd bin/hello.static; ldd ./bin/hello.rpath; ./bin/hello.static ; ./bin/hello.dyn ; ./bin/hello.rpath ; exit 0"
					]
				}
			}
		}
	}
	"exports": {}
}
