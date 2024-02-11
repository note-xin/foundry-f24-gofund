//SPDX-License-Identifier: MIT

// 1. Pragma
pragma solidity 0.8.18;

// 2. Imports
import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {GoFund} from "src/GoFund.sol";

// 3. Contract, Library & Interface 
contract Fund_GoFund is Script {
    // State Variables
    uint256 SEND_VALUE = 0.1 ether;

    // Functions
    //// Public
    function fund_GoFund(address currentlyDeployed) public {
        vm.startBroadcast();
        GoFund(payable(currentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();

        console.log("Funded GoFund %s", SEND_VALUE);
    }

    //// External
    function run() external {
        address currentlyDeployed = DevOpsTools.get_most_recent_deployment("GoFund", block.chainid);

        fund_GoFund(currentlyDeployed);      
    }
}

contract Withdraw_GoFund is Script {
    // Functions
    //// Public
    function withdraw_GoFund(address currentlyDeployed) public {
        vm.startBroadcast();
        GoFund(payable(currentlyDeployed)).withdraw();
        vm.stopBroadcast();

        console.log("withdrw successful");
    }

    //// External
    function run() external {
        address currentlyDeployed = DevOpsTools.get_most_recent_deployment("GoFund", block.chainid);

        withdraw_GoFund(currentlyDeployed);      
    }}
