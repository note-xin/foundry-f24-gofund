//SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity 0.8.18;

// 2. Imports
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "test/mock/MockV3Aggregator.sol";

// 3. Contract, Library, Interface
contract Network is Script {
    // State variables
    Network_config public active_network_config;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct Network_config {
        address feed;
    }

    // Functions order
    //// constructor
    //constructor to switch network
    constructor() {
        if(block.chainid == 11155111) {
            active_network_config = getSapoliaconfig();
        }
        else {
            active_network_config = getAnvilconfig();
        } 
    }

    //// public
    /// all using networks
    function getSapoliaconfig() public pure returns (Network_config memory Sapoliaconfig) {
        Sapoliaconfig = Network_config({
            feed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });

        return Sapoliaconfig;
    }

    function getAnvilconfig() public returns (Network_config memory Anvilconfig) {
        //check wheter a local chain is setup or not
        if(active_network_config.feed != address(0)) {
            return active_network_config;
        }

        //for local testing we deploy a mock feed contract
        vm.startBroadcast();
        MockV3Aggregator mock_feed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        Anvilconfig = Network_config({
            feed: address(mock_feed)
        });

        return Anvilconfig;
    }
}
