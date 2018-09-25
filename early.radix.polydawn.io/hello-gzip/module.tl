{
	"imports": {
		"root-min": "catalog:early.polydawn.io/monolith/busybash:v1:linux-amd64",
		"root-debian": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
		"root-builder": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
		"src-gzip": "catalog:early.hyphae.polydawn.io/sources/gzip:v1.9:src",
		"packme": "ingest:pack:tar:./packme"
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"root-builder": "/",
					"src-gzip": "/task/src",
					"packme": "/task"
				},
				"action": {
					"userinfo": {"uid":0},
					"exec": [
						"/bin/bash", "-c",
						"cd src/* ; pwd ; ls -lah ; ./configure ; make ; ls -lah"
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
						"cd bin/*/*; set -x; ldd gzip; ./gzip -h ; exit 0"
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
						"cd bin/*/*; set -x; ldd gzip; ./gzip -h ; exit 0"
					]
				}
			}
		}
	}
	"exports": {}
}
