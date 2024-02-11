//SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity 0.8.18;

// 2. Imports
import {Test, console} from "lib/forge-std/src/Test.sol";
import {GoFund} from "../../src/GoFund.sol";
import {Network} from "../../script/Network.s.sol";
import {Deploy} from "../../script/Deploy.s.sol";

// 3. Contract, Library, Interface
contract TestGoFund is Test {
    // State variables
    uint256 constant SEND_AMOUNT = 0.1 ether;
    uint256 constant STRARTING_BALANCE = 10 ether;

    address constant USER = address(3);

    GoFund public goFund;
    Network public network;

    // Modifiers
    modifier funded() {
        vm.prank(USER);
        goFund.fund{value: SEND_AMOUNT}();

        _;
    }

    // Function order
    //// public
    function setUp() public {
        Deploy deploy = new Deploy();
        (goFund, network) = deploy.run();

        vm.deal(USER, STRARTING_BALANCE);
    }

    //// Test ( must star with test )
    function test_verifyMinFundingValue() public {
        // Assert
        assertEq(goFund.MIN_AMOUNT(), 5e18);
    }

    function test_verifyOwnership() public {
        // Assert
        assertEq(goFund.get_owner(), msg.sender);
    }

    function test_verifyPriceFeedVersion() public {
        // Assert
        assertEq(goFund.get_version(), 4);
    }

    function test_verifyIfCheckingMinFund() public {   
        // Act
        vm.expectRevert();
        goFund.fund();
    }

    function test_verifyFunding() public funded {
        // Arrange
        uint256 _fund = goFund.get_amount_funded(USER);
        
        // Assert
        assertEq(_fund, SEND_AMOUNT);
    }

    function test_verifyIfFundersisAddingToFunders() public funded {
        // Arrange
        address _funder = goFund.get_funders(0);

        // Assert
        assertEq(_funder, USER);
    }

    function test_verifyOnlyOwnerCanWithdraw() public funded {
        // Act
        vm.expectRevert();
        vm.prank(USER);

        goFund.withdraw();
    }

    function test_verfyIfWithdrawIsWorking() public funded {
        // Arrange
        uint256 owner_starting_balance = goFund.get_owner().balance;
        uint256 contract_starting_balance = address(goFund).balance;

        // Act
        vm.prank(goFund.get_owner());
        goFund.withdraw();

        // Assert
        uint256 owner_ending_balance = goFund.get_owner().balance;
        uint256 contract_ending_balance = address(goFund).balance;

        assertEq(owner_ending_balance, owner_starting_balance + contract_starting_balance);
        assertEq(contract_ending_balance, 0);
    }

    function test_verfyIfWithdrawIsWorkingForMultipleFunding() public funded {
        // Arrange
        uint256 no_of_funders = 11;
        uint160 index = 1;

        for (uint160 i = index; i < no_of_funders; i++) {
            hoax(address(i), SEND_AMOUNT);
            goFund.fund{value: SEND_AMOUNT}();
        }

        uint256 owner_starting_balance = goFund.get_owner().balance;
        uint256 contract_starting_balance = address(goFund).balance;

        // Act
        vm.prank(goFund.get_owner());
        goFund.withdraw();

        // Assert
        uint256 owner_ending_balance = goFund.get_owner().balance;
        uint256 contract_ending_balance = address(goFund).balance;

        assertEq(owner_ending_balance, owner_starting_balance + contract_starting_balance);
        assertEq(contract_ending_balance, 0);
    }
}