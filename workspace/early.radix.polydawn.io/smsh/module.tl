{
	"imports": {
		"base": "catalog:early.polydawn.io/monolith/busybash:v1:linux-amd64",
		"go": "catalog:early.hyphae.polydawn.io/go:v1.10:linux-amd64",
		"src": "ingest:git:./src:HEAD"
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"/": "base",
					"/app/go": "go",
					"/task": "src"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"export PATH=$PATH:/app/go/go/bin && export GOPATH=$PWD/.gopath && export GOBIN=$PWD/bin && CGO_ENABLED=0 go install --ldflags '-extldflags \"-static\"' ./cmd/* && mkdir out && mv bin out"
					]
				},
				"outputs": {
					"bin": "/task/out"
				}
			}
		},
		"test": {
			"operation": {
				"inputs": {
					"/": "base",
					"/task": "build.bin"
				},
				"action": {
					"exec": [
						"/task/bin/smsh",
						"echo hello"
					]
				}
			}
		}
	},
	"exports": {
		"bin-linux-amd64": "build.bin",
		"src": "src"
	}
}
