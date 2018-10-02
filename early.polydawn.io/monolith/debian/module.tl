{
	"imports": {
		"base": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
		"debootstrap": "catalog:early.hyphae.polydawn.io/debootstrap:v1.0.87:all",
		"debuerreotype": "catalog:early.hyphae.polydawn.io/debuerreotype:v0.8:all",
		"packme": "ingest:pack:tar:./packme"
	},
	"steps": {
		"init": {
			"operation": {
				"inputs": {
					"base": "/",
					"debootstrap": "/app/debootstrap",
					"debuerreotype": "/app/debuerreotype",
					"packme": "/task"
				},
				"action": {
					"policy": "sysad",
					"userinfo": {
						"uid": 0,
						"gid": 0
					},
					"env": {
						"DISTRIBUTION": "stretch",
						"TIMESTAMP": "2017-01-04T03:32:24Z"
					},
					"exec": [
						"/task/script-init.sh"
					]
				},
				"outputs": {
					"chroot": "/task/chroot"
				}
			}
		},
		"install-extra": {
			"operation": {
				"inputs": {
					"base": "/",
					"init.chroot": "/task/chroot",
					"debuerreotype": "/app/debuerreotype",
					"packme": "/task"
				},
				"action": {
					"policy": "sysad",
					"userinfo": {
						"uid": 0,
						"gid": 0
					},
					"exec": [
						"/task/script-install-extra.sh"
					]
				},
				"outputs": {
					"chroot": "/task/chroot"
				}
			}
		},
		"strip-nondet": {
			"operation": {
				"inputs": {
					"base": "/",
					"install-extra.chroot": "/task/chroot",
					"debuerreotype": "/app/debuerreotype",
					"packme": "/task"
				},
				"action": {
					"policy": "governor",
					"userinfo": {
						"uid": 0,
						"gid": 0
					},
					"exec": [
						"/task/script-cleanup.sh"
					]
				},
				"outputs": {
					"chroot": "/task/chroot"
				}
			}
		}
	},
	"exports": {
		"linux-amd64": "strip-nondet.chroot"
	}
}
