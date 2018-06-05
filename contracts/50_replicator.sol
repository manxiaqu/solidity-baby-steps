pragma solidity ^0.4.18;

contract ReplicatorB {

    address public creator;
    uint public blockCreatedOn;

    constructor() public {
        creator = msg.sender;
       // next = new ReplicatorA();    // Replicator B can't instantiate A because it doesn't yet know about A
       								   // At the time of this writing (Sept 2015), It's impossible to create cyclical relationships
       								   // either with self-replicating contracts or A-B-A-B 
        blockCreatedOn = block.number;
    }
	
	function getBlockCreatedOn() view returns(uint) {
		return blockCreatedOn;
	}
}

contract ReplicatorA {

    address public creator;
	address public badDress;
	uint blockCreatedOn;

    constructor() public {
        creator = msg.sender;
        badDress = new ReplicatorB();		 // This works just fine because A already knows about B
        blockCreatedOn = block.number;
    }

	function getBAddress() view returns(address) {
		return badDress;
	}
	
	function getBlockCreatedOn() view returns(uint) {
		return blockCreatedOn;
	}
}
