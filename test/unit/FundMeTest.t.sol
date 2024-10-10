// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";


contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
        
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
        
    }
        
    function testOwnerIsMsgSender() public view  {
        
       
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
        
    }

    function testExpectRevert() public {
      vm.expectRevert();
      fundMe.fund{value: 100000000000000}(); // send value less than MINIMUM_USD
    }

    function testFundUpdatesDataStructure() public {
        vm.prank(USER);
        vm.deal(USER, STARTING_BALANCE);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public {
        vm.prank(USER);
        vm.deal(USER, STARTING_BALANCE);
        fundMe.fund{value: SEND_VALUE}();
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);

    }

    modifier funded {
        vm.prank(USER);
        vm.deal(USER, STARTING_BALANCE);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

   function testOnlyOwnerCanWithdraw() public funded {
    //    vm.prank(USER);
    // //    vm.deal(USER, STARTING_BALANCE);
    //    fundMe.fund{value: SEND_VALUE}();
        // console.log(fundMe.i_owner());
        // console.log(USER);
       vm.prank(USER);
       vm.expectRevert();
       fundMe.withdraw();
   }


   function testWithDrawWithASingleFunder() public funded {
     // Arrange
    
    uint256 startingOwnerBalance = fundMe.getOwner().balance;
    uint256 startingFundMeBalance = address(fundMe).balance;

     // Act
    vm.prank(fundMe.getOwner());
    // vm.deal(fundMe.getOwner(), STARTING_BALANCE);
    fundMe.withdraw();

     // Assert

    uint256 endingOwnerBalance = fundMe.getOwner().balance;
    uint256 endingFundMeBalance = address(fundMe).balance;
    assertEq(endingFundMeBalance, 0);
    assertEq(startingFundMeBalance + startingOwnerBalance, endingOwnerBalance);

   }

   function testWithDrawFromMultipleFunders() public funded {
    // Arrange
    uint160 numberOfFunders = 10;
    uint160 startingFunderIdex = 1;
    for (uint160 i = startingFunderIdex; i < numberOfFunders; i++){
        // vm.prank new address
        // vm.deal new address
        hoax(address(i), SEND_VALUE);
        // fund the fundMe
        fundMe.fund{value: SEND_VALUE}();
    }

    uint256 startingOwnerbalance = fundMe.getOwner().balance;
    uint256 startingFundMeBalance = address(fundMe).balance;
    
    // Act
    vm.startPrank(fundMe.getOwner());
    fundMe.withdraw();
    vm.stopPrank;
    

    // assert
    assert(address(fundMe).balance == 0);
    assert(startingFundMeBalance + startingOwnerbalance == fundMe.getOwner().balance);  
}
}