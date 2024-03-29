.PHONY: all bats dotfiles test shellcheck

all: dotfiles

dotfiles:
	install.sh

prep:
	prep.sh

test: shellcheck bats

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

bats:
	bats tests/modules/**/*.bats

shellcheck:
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		koalaman/shellcheck:stable ./tests/shellcheck.sh
