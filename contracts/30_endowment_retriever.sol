pragma solidity ^0.4.18;

contract EndowmentRetriever {

    address public creator;
    uint256 public contractCreationValue; // original endowment

    constructor() public payable {
        creator = msg.sender;
        contractCreationValue = msg.value;  				// the endowment of this contract in wei
    }
	
    function getContractCreationValue() public view returns(uint256) {										              		// set at creation time with "value: <someweivalue>"
    	return contractCreationValue;                         // this was the "balance" of the contract at creation time
    }
    
    function sendOneEtherHome() public {
    	creator.transfer(1 ether);				// send 1 ETH home
    }
}