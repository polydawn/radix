{
	"imports": {
		"root-builder": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
		"app-smsh": "catalog:early.radix.polydawn.io/smsh:candidate:bin-linux-amd64",
		"src-gzip": "catalog:early.hyphae.polydawn.io/sources/gzip:v1.9:src",
		"autoconfesque": "ingest:pack:tar:../../../shared/autoconfesque"
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"/": "root-builder",
					"/app/smsh": "app-smsh",
					"/task/raw": "src-gzip",
					"/radix/autoconfesque": "autoconfesque"
				},
				"action": {
					"userinfo": {"uid":0},
					"exec": [
						"/app/smsh/bin/smsh",
						"ln -s raw/* src",
						"ls -lah",
						"/radix/autoconfesque/build.sh",
						"mkdir out2 # we ought improve autoconfesque more, clearly"
						"mv out/usr/local/bin out2"
					]
				},
				"outputs": {
					"bin": "/task/out2"
				}
			}
		},
		"roosting": {
			"module": {
				"imports": {
					"root-busybash": "catalog:early.polydawn.io/monolith/busybash:v1:linux-amd64",
					"root-debian": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
					"app-smsh": "catalog:early.radix.polydawn.io/smsh:candidate:bin-linux-amd64",
					"subject": "parent:build.bin"
				}
				"steps": {
					"busybash": {
						"operation": {
							"inputs": {
								"/": "root-busybash",
								"/app/smsh": "app-smsh",
								"/task": "subject"
							},
							"action": {
								"exec": [
									"/app/smsh/bin/smsh",
									"ldd ./bin/gzip",
									"./bin/gzip -h # this will fail; we didn't statically nor (successfully) locally link"
								]
							}
						}
					},
					"rich": {
						"operation": {
							"inputs": {
								"/": "root-debian",
								"/app/smsh": "app-smsh",
								"/task": "subject"
							},
							"action": {
								"exec": [
									"/app/smsh/bin/smsh",
									"ldd ./bin/gzip",
									"./bin/gzip -h"
								]
							}
						}
					}
				}
			}
		}
	},
	"exports": {
		"bin-amd64-linux": "build.bin"
	}
}
