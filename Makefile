SHELL := /bin/bash

# setup python framework local environment from scratch

# validate all files in python framework project

# run full python framework test suite (unit, integration, end-to-end)

# deploy python framework


#---------------
# SETUP
#---------------
githooks:
	@git config core.hooksPath .githooks

environment:
	@printf "[INFO] configuring virtual environment...\n"
	@test -d .venv || python3.8 -m venv .venv
	@source .venv/bin/activate; \
	pipv=( $$(pip -V) ) && v=("20.3.0", "$${pipv[1]}"); \
	if [[ $$(printf '%s\n' $${v[@]} | sort -V | tail -n1) != "$${pipv[1]}" ]]; then \
		printf "[INFO] upgrading pip...\n"; \
		python -m pip -q install --upgrade pip; \
	fi

requirements:
	@printf "[INFO] installing pip packages...\n"
	@source .venv/bin/activate; \
	pip -q install -Ur requirements.txt; \
	pip check


#---------------
# SETUP
#---------------
format:
	@printf "[INFO] reformatted files: "
	@source .venv/bin/activate; \
	readarray -t out < <(black . 2>&1); \
	readarray -t err < <(printf '%s\n' "$${out[@]}" | grep -F 'error'); \
	readarray -t out < <(printf '%s\n' "$${out[@]:0:$${#out[@]}-1}" | grep -F 'formatted'); \
	printf '%s\n' "$${#out[@]}"; \
	[[ $${#out[@]} != 0 ]] && printf ' - %s\n' "$${out[@]}"; \
	[[ $${#err[@]} != 0 ]] && printf ' - %s\n' "$${err[@]}"; \
	exit $${#out[@]}

lint:
	@printf "[INFO] linting errors: "
	@source .venv/bin/activate; \
	readarray -t out < <(flake518 ./); \
	printf '%s\n' "$${#out[@]}"; \
	[[ $${#out[@]} != 0 ]] && printf ' - %s\n' "$${out[@]}"; \
	exit $${#out[@]}


#---------------
# SETUP
#---------------
unit:

integration:

end-to-end:


#---------------
# SETUP
#---------------
deploy:

teardown:
