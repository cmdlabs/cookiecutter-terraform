.PHONY: shunit2
.DEFAULT_GOAL := shunit2

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; cyan = "\033[36m"; white = "\033[0m"; printf "\nUsage:\n  make %s<target>%s\n\nTargets:\n", cyan, white} /^[a-zA-Z0-9_-]+:.*?##/ {printf "  %s%-10s%s %s\n", cyan, $$1, white, $$2}' $(MAKEFILE_LIST)

tests = shunit2/test_simple.sh

shunit2:  ## Run the shunit2 tests
	for i in $(tests) ; do \
		printf "\n%s:\n" $$i ; \
		bash $$i || exit ; \
		done
