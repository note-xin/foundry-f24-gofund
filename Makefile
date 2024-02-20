# Makefile for deploying contracts
-include .env

.PHONY: cat all test clean deploy fund help install snapshot format anvil 

# State values
DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

# Check whether to deploy on sepolia network
ifeq ($(ARGS), --network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

help:
	@echo "Lott v1.0.2"
	@echo "makefile v1.1.0"
	@echo ""
	@echo "usage :"
	@echo " make deploy [ARGS]\n 		example: make deploy ARGS=\"--network sepolia\"
	@echo " make cat"
	@echo " make gibh \n 		if you need list of all shorcuts"

# Cat lord
cat :
	@echo ""
	@echo "   /\_/\   I am Watching"
	@echo " =( °w° )=   You Nya!"
	@echo "   )   (  // "
	@echo "  (__ __)// "
	@echo ""

# All shorcuts
gibh :
	@echo "Lott v1.0.2"
	@echo "makefile v1.1.0"
	@echo ""
	@make -pRrq : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | column

all: clean remove install update build

# CLean the repo
clean  :
	forge clean

# Remove/Install modules
remove :
	rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"
install :
	forge install cyfrin/foundry-devops@0.1.0 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@0.8.0 --no-commit && forge install foundry-rs/forge-std@v1.7.6 --no-commit

# Update Dependencies
update :
	forge update

build :
	forge build

snapshot :
	forge snapshot

test-all :
	forge test

test :
	@if [ -z "$(t)" ]; then echo "\n Error: No test specified. \n 	Usage:\n 	make test t=<test_name> \n 	make test-all\n"; else forge test --match-test "$(t)"; fi

cover:
	@forge coverage & echo $$! > .pidfile & 
	@./loading.sh `cat .pidfile`
	@rm .pidfile

cover-report :
	@forge coverage --report debug > coverage.txt & echo $$! > .pidfile &
	@./loading.sh `cat .pidfile`
	@rm .pidfile
	@echo "\nCoverage report has been generated.\nPlease check the root directory for the report. \n"

format :
	forge fmt

anvil :
	anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy:
	@forge script script/Deploy.s.sol:Deploy $(NETWORK_ARGS)

fund:
	@forge script script/Interactions.s.sol:Fund $(NETWORK_ARGS)

withdraw:
	@forge script script/Interactions.s.sol:Withdraw $(NETWORK_ARGS)