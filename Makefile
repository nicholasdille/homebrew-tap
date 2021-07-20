.PHONY:
style:
	@\
	brew style --fix .

.PHONY:
audit:
	@\
	brew tap-info --installed --json | \
		jq --raw-output --arg path "$${PWD}" '.[] | select(.path == $$path) | .formula_names[]' | \
			while read -r FORMULA; do \
				echo "Checking formula $${FORMULA}..."; \
				brew audit --strict "$${FORMULA}"; \
			done

.PHONY:
livecheck:
	@\
	brew livecheck --tap nicholasdille/tap --newer-only --quiet
