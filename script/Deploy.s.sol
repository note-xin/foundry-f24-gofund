//SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity 0.8.18;

// 2. Imports
import {Script} from "forge-std/Script.sol";
import {GoFund} from "src/GoFund.sol";
import {Network} from "./Network.s.sol";

// 3. Contract, Library, Interface
contract Deploy is Script {
    function run() external returns (GoFund, Network) {

        //before broadcasting -> virtual transaction
        Network network = new Network();
        (address _feed) = network.active_network_config();

        //after broadcasting -> real transaction
        vm.startBroadcast();
        GoFund gofund = new GoFund(_feed);
        vm.stopBroadcast();

        return (gofund, network);
    }
}