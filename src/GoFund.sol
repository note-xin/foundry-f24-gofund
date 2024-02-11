// SPDX-License-Identifier: MIT
// 1. Pragma 
pragma solidity 0.8.18;

// 2. Imports
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {convertion} from "./convertion.sol";

// 3. Interface, Library, Contract
error GoFund__NotOwner();

contract GoFund {

    // Type declarations 
    using convertion for uint256;

    // State variables
    uint256 public constant MIN_AMOUNT = 5e18;
    address private immutable i_owner;
    address[] private s_funders;
    mapping(address => uint256) private s_AmountFunded;
    AggregatorV3Interface private s_feed;

    // Events  
    /*    /\_/\  
        =( °w° )=
          )   (  //
         (__ __)//
    */


    // Modifiers
    modifier client() {
        if (msg.sender != i_owner) revert GoFund__NotOwner();
        _;
    }

    // Functions in order :

    //// constructor
    constructor (address _feed) {
        i_owner = msg.sender;
        s_feed = AggregatorV3Interface(_feed); 
    }

    //// receive 
    receive() external payable {
        fund();
    }

    //// fallback
    fallback() external payable { 
        fund();
    }

    //// external

    //// public
    /// Funds contract based on price feed
    function fund() public payable {
        require(msg.value.conv_price(s_feed) >= MIN_AMOUNT, "less than min fund");
        
        s_funders.push(msg.sender);
        s_AmountFunded[msg.sender] += msg.value;
    }

    /// Withdraws contract balance and send it to owner
    function withdraw() public client {
        // owner calls contract to withdraw
        (bool transfer_state, ) = i_owner.call{value : address(this).balance}("");
        require(transfer_state, "transaction failed");

        uint256 total_no_of_funders = s_funders.length;

        for (uint256 i; i < total_no_of_funders; i++) {
            address funder = s_funders[i];
            s_AmountFunded[funder] = 0;
        }

        s_funders = new address[](0);
    }
    //// internal

    //// private

    //// getters
    function get_version() public view returns (uint256) {
        return s_feed.version();
    }

    function get_amount_funded(address _funder) public view returns (uint256) {
        return s_AmountFunded[_funder];
    }

    function get_funders(uint256 _index) public view returns (address) {
        return s_funders[_index];
    }

    function get_owner() public view returns (address) {
        return i_owner;
    }

    function get_feed() public view returns (AggregatorV3Interface) {
        return s_feed;
    }
}