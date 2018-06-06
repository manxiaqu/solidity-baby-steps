pragma solidity ^0.4.18;

/*
	Another very basic contract. It demonstrates that a contract can retrieve and store the 
	balance of its creator address. Note that the creatorBalance value captured in the constructor is a snapshot in time.
	Later on, creator.balance will reflect whatever it is now.
*/
// 检查地址的balance
contract creatorBalanceChecker {

    address public creator;
    uint256 public creatorBalance;

    constructor() public {
        creator = msg.sender;
        // address.balance return balance of address in wei
        // address.balance返回改地址的balance，单位为wei
        creatorBalance = creator.balance;
    }

	function getContractAddress() public view returns(address) {
		return address(this);
	}

    // Will return the creator's balance AT THE TIME THIS CONTRACT WAS CREATED
	function getCreatorBalance() public view returns(uint256) {
        return creatorBalance;
    }

    // Will return creator's balance NOW
    function getCreatorDotBalance() public view returns(uint256) {
        return creator.balance;
    }
}