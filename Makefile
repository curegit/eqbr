.PHONY: build install devinstall preview publish clean format check test

build: clean
	python3 -m build

install: build
	pip3 install .

devinstall: build
	pip3 install -e .[dev]

preview: build
	python3 -m twine upload -u __token__ --repository-url "https://test.pypi.org/legacy/" dist/*

publish: build
	python3 -m twine upload -u __token__ --repository-url "https://upload.pypi.org/legacy/" dist/*

clean:
	python3 -c 'import shutil; shutil.rmtree("dist", ignore_errors=True)'
	python3 -c 'import shutil; shutil.rmtree("build", ignore_errors=True)'
	python3 -c 'import shutil; shutil.rmtree("eqlm.egg-info", ignore_errors=True)'
	python3 -c 'import shutil; shutil.rmtree(".mypy_cache", ignore_errors=True)'

format:
	python3 -m black -l 300 eqlm tests

check:
	python3 -m mypy eqlm tests

test:
	python3 -m unittest discover -v tests
