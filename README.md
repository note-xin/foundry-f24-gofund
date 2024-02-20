# GoFund | F24 Project

This Project is a section of **Cyfrin Solidity Course**.  

It was build to learn and understand foundry under the guidance of  **Patrick Collins**, <small>(*Smart Contract Engineer*, *Auditor* and *Educator*) </small>  
For more information, visit [Cyfrin Solidity Course](https://github.com/Cyfrin/foundry-full-course-f23) or 
*[Lesson 7: Foundry Fund Me](https://www.youtube.com/watch?v=sas02qSFZ74&t=0s)* for enlightment  

<big>**Table of Contents**</big>
- [GoFund | F24 Project](#gofund--f24-project)
- [Introduction](#introduction)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
- [Usage](#usage)
  - [Deploy](#deploy)
  - [Testing](#testing)
    - [Test Coverage](#test-coverage)
- [Deploying to a testnet or mainnet](#deploying-to-a-testnet-or-mainnet)
  - [Scripts](#scripts)
    - [Fund](#fund)
    - [Withdraw](#withdraw)
    - [Interacting intest net](#interacting-intest-net)
  - [Estimate gas](#estimate-gas)
- [Thank you!](#thank-you)




# Introduction
Welcome to **Go Fund | Foundry 24** This project explores Foundry, a powerful tool for developing smart contracts. We cover blockchain fundraising through exercises that deals with smart contract deployment and interaction.  
The README provides detailed instructions for getting started, deploying, testing, and interacting with smart contracts on various networks. This hands-on project is a great opportunity to master Foundry and its applications in real-world scenarios as part of the **Cyfrin Solidity Course**.

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - run `git --version` in the terminal and you see a response like `git version x.x.x` you have git installed. else, click on git to get full on instructions.
- [foundry](https://getfoundry.sh/)
  - similarly run `forge --version` and if you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)` yo got foundry down. else, click on foundry.
  

# Usage

## Deploy
In order to deploy the `Go Fund` contract, we deploy the script that we created by runing the following command:

```
forge script script/DeployFundMe.s.sol
```

## Testing

In this project we cover the following testing strategies:
1. Unit
2. Forked

foundry has a built in test runner that we can use to run our tests. which can be done using the following command:
- to run all tests
 ```
 forge test
 ```
- to run a specific test

 ```
 forge test --match-test testFunctionName
 ```
dont forget to add `test` at the beginning of the test function name.like for example
```
function testFunctionName() public {}

function test_functionName() public {}
```
both ways works.

to run the test in a diffrent network, we can use the following command:

```
forge test --fork-url $SEPOLIA_RPC_URL
```
>**note :** we are conducting tests in a sepollia test network. and `$SEPOLIA_RPC_URL` is an environment variable that we set in the `.env` file which contains the url of the sepollia test network.

### Test Coverage
this is more like a grading for our contract and we can run the command to check coverage.

```
forge coverage
```
we run it see how much the tests we done is 'enough' but (0 % is bad).


# Deploying to a testnet or mainnet

1. Seting up environment variables

    set up your `SEPOLIA_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file in the root of the project. for example:

    ```
    SEPOLIA_RPC_URL=https://eth-mainnet.alchemyapi.io/v2/your-api-key
    PRIVATE_KEY=your-private-key
    ```

 - `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)).  
    >**note :** dont be a dum_dum, please create a test account with test ETH and use it.

 - `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

    Optionally : add your `ETHERSCAN_API_KEY` if you want to verify and interact with your contract on [Etherscan](https://etherscan.io/).


2. Get testnet ETH

    go to [faucets.chain.link](https://faucets.chain.link/) and get some testnet ETH. You should see the ETH show up in your metamask account. if you are having difficulty in metamask watch this vedio from [Patrick Collins](https://youtu.be/umepbfKp5rI?si=41JtvTgEIsXD9u2N).  
    >dont be like mr crabs and hoard test ETH, use them sparingly.

3. Deploy
   
    here we deploy the contract to a sepolia testnet by running the following command:

    ```
    forge script script/Deploy.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
    ```

## Scripts

Now that the contract has been deployed to a testnet or local net, you can run the scripts to interact with them. examples: 

Using cast for a localy deployed contract: 
### Fund

```
cast send <GOFUND_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
```
### Withdraw

```
cast send <GOFUND_CONTRACT_ADDRESS> "withdraw()"  --private-key <PRIVATE_KEY>
```

### Interacting intest net
```
forge script script/Interactions.s.sol --rpc-url sepolia  --private-key $PRIVATE_KEY  --broadcast
```

## Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```

And you'll see an output file called `.gas-snapshot` in your project directory.


# Thank you!
peace and bleassing be upon you friend.
I would take this opertunity to sing praises to my mentor but i want you to see it for you self.
If you appreciated this project,dont give me any credits. all i want you to do is to check out sir Patrick Collins foundry course f23.

link to his bio  

[![Patrick Collins Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/PatrickAlphaC)
[![Patrick Collins YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCn-3f8tw_E1jZvhuHatROwA)

