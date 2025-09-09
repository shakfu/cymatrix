
.PHONY: all build wheel clean test reset

all: build


build:
	@uv run python setup.py build_ext --inplace

wheel:
	@uv build

clean:
	@rm -rf build dist *.so src/**/*.so __pycache__ .*_cache src/*.egg-info


reset: clean
	@rm -rf .venv


test:
	@uv run python -m pytest
