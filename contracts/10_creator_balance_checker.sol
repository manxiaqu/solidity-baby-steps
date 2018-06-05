pragma solidity ^0.4.18;

/*
	Another very basic contract. It demonstrates that a contract can retrieve and store the 
	balance of its creator address. Note that the creatorbalance value captured in the constructor is a snapshot in time.
	Later on, creator.balance will reflect whatever it is now.
*/
contract creatorBalanceChecker {

    address public creator;
    uint256 public creatorBalance; 		// TIP: uint is an alias for uint256. Ditto int and int256.

    constructor() public {
        creator = msg.sender;
        creatorBalance = creator.balance;
    }

	function getContractAddress() view returns(address) {
		return this;
	}

    // Will return the creator's balance AT THE TIME THIS CONTRACT WAS CREATED
	function getCreatorBalance() view returns(uint256) {
        return creatorBalance;
    }

    // Will return creator's balance NOW
    function getCreatorDotBalance() view returns(uint256) {
        return creator.balance;
    }
}