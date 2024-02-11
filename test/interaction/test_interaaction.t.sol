//SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity 0.8.18;

// 2. Imports
import {Test, console} from "lib/forge-std/src/Test.sol";
import {GoFund} from "../../src/GoFund.sol";
import {Deploy} from "../../script/Deploy.s.sol";
import {Network} from "../../script/Network.s.sol";
import {Fund_GoFund, Withdraw_GoFund} from "../../script/Interaction.s.sol";

// 3. Contract, Library, Interface
contract TestInteraction is Test {
    // State variables
    uint256 public constant SEND_AMOUNT = 0.1 ether;
    uint256 public constant STRARTING_BALANCE = 10 ether;

    address public constant USER = address(3);

    GoFund public goFund;
    Network public network;

    // Modifiers

    // Function order
    //// public
    function setUp() public {
        Deploy deploy = new Deploy();
        (goFund, network) = deploy.run();

        vm.deal(USER, STRARTING_BALANCE);
    }

    //// Test ( must star with test )
    function test_verifyWhetherUserCanFundAndOwnerCanWithdraw() public { 
        // Arrange
        Fund_GoFund fund = new Fund_GoFund();
        fund.fund_GoFund(address(goFund));

        Withdraw_GoFund withdraw = new Withdraw_GoFund();
        withdraw.withdraw_GoFund(address(goFund));

        // Assert
        assertEq(address(goFund).balance, 0);
    }

}