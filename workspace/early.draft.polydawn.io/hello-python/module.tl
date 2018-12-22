{
	"imports": {
		"root-debian": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
		"pypy3": "ingest:literal:tar:9RNHEQJMqihqhygqEf6rkpE5YaNNBAc4UDcXVg3wJKKS7Md2ZDp3ftSVkWPf6D8e2E",
		"src": "ingest:pack:tar:./src"
	},
	"steps": {
		"build": {
			"operation": {
				"inputs": {
					"/": "root-debian",
					"/src": "src",
					"/pypy3": "pypy3"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"set -euo pipefail; echo $HOME; PYBIN=/pypy3/pypy3.5-6.0.0-linux_x86_64-portable/bin; VENV=$HOME/venv; $PYBIN/pypy3 $PYBIN/virtualenv-pypy $VENV; PYTHON=$VENV/bin/python3; $PYTHON -m ensurepip; $PYTHON -m pip wheel -w $HOME/wheels /src"
					]
				},
				"outputs": {
					"wheels": "/home/reuser/wheels"
				}
			}
		},
		"setup-venv": {
			"operation": {
				"inputs": {
					"/": "root-debian",
					"/wheels": "build.wheels",
					"/pypy3": "pypy3"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"set -euo pipefail; echo $HOME; PYBIN=/pypy3/pypy3.5-6.0.0-linux_x86_64-portable/bin; VENV=$HOME/venv; $PYBIN/pypy3 $PYBIN/virtualenv-pypy $VENV; PYTHON=$VENV/bin/python3; $PYTHON -m ensurepip; $PYTHON -m pip install --no-index /wheels/*"
					]
				},
				"outputs": {
					"venv": "/home/reuser/venv"
				}
			}
		},
		"run": {
			"operation": {
				"inputs": {
					"/": "root-debian",
					"/home/reuser/venv": "setup-venv.venv",
					"/pypy3": "pypy3"
				},
				"action": {
					"exec": [
						"/bin/bash", "-c",
						"$HOME/venv/bin/python3 -m hello"
					]
				},
				"outputs": {
					"venv": "/home/reuser/venv"
				}
			}
		}
	},
	"exports": {
		"wheels": "build.wheels",
		"venv": "setup-venv.venv"
	}
}
