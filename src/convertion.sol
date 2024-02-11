// SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity 0.8.18;

// 2. Imports
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// 3. Contracts, libraries, interfaces
library convertion {
    // Function that get current ETH/USD value from chainlink
    function get_price(AggregatorV3Interface _feed) internal view returns (uint256) {
        (, int256 price, , , )  = _feed.latestRoundData();

        // return price in 18 decimals
        return uint256(price * 1e10);
    }

    // Function to convert ETH to USD
    function conv_price(uint256 Price, AggregatorV3Interface _feed) internal view returns (uint256) { 
        uint256 eth_price = get_price(_feed);
        uint256 eth_usd = (eth_price * Price) / 1e18;
        
        return eth_usd;
    }   
}