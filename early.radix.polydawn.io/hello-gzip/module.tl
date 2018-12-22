{
	"imports": {
		"root-busybash": "catalog:early.polydawn.io/monolith/busybash:v1:linux-amd64",
		"root-debian": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
		"root-builder": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
		"src-gzip": "catalog:early.hyphae.polydawn.io/sources/gzip:v1.9:src",
		"autoconfesque": "ingest:pack:tar:../../shared/autoconfesque"
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"/": "root-builder",
					"/task/raw": "src-gzip",
					"/radix/autoconfesque": "autoconfesque"
				},
				"action": {
					"userinfo": {"uid":0},
					"exec": [
						"/bin/bash", "-c",
						"ln -s raw/* src && ls -lah && /radix/autoconfesque/build.sh"
					]
				},
				"outputs": {
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
						"cd bin/*/*; set -x; ldd gzip; ./gzip -h ; exit 0"
					]
				}
			}
		},
		"echo-2-busybash": {
			"operation": {
				"inputs": {
					"/": "root-busybash",
					"/task/bin": "build.woop"
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
	"exports": {
		"bin-amd64-linux": "build.woop"
	}
}
