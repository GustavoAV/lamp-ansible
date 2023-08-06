SSH_KEY := ansible_ed25519

INVENTORY := inventory
PLAYBOOK := setup.yaml

VM_LIST := $(shell cat $(INVENTORY))
PLAY_OPTS := --inventory $(INVENTORY) $(PLAYBOOK)

.PHONY: ssh_key
ssh_key:
	cat /dev/zero | ssh-keygen -t ed25519 -f $(HOME)/.ssh/$(SSH_KEY) -C "ansible" -N ""
	cp -v $(HOME)/.ssh/$(SSH_KEY).pub $(SSH_KEY).pub

.PHONY: recreate
recreate:
	vagrant destroy --force
	vagrant up
	scripts/vm_connect.sh $(VM_LIST)

.PHONY: play
play:
	ansible-playbook $(PLAY_OPTS)

.PHONY: idempotency
idempotency:
	scripts/idempotency_check.sh $(INVENTORY) $(PLAY_OPTS)

.PHONY: full_test
full_test: recreate idempotency
