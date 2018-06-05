pragma solidity ^0.4.18;

// In addition to testing contract-to-contract variable passing,
// this contract tests assignment of a string to a bytes32 type. 
// the result of "savedvar" is "0x1a09254100000000000000000000000000000000000000000000000000000000"
// but I don't currently understand why, and would like to know how to 
// convert that hex back into "tencharsme"

contract Descriptor {
    
	function getDescription() pure returns(bytes32){
		return "tencharsme";
	}
}

contract Bytes32Passer {

    address public creator;
    bytes public savedBytes;
    bytes32 public savedVar;
    string public savedString;
    Descriptor public descriptor;

    constructor() public {
        creator = msg.sender;
    }
    
    function getDescription() {
        savedVar = descriptor.getDescription();  // get the description from the descriptor
    	uint8 x = 0;
    	while(x < 32) {
            savedBytes.length++;
            savedBytes[x] = savedVar[x];
    		x++;
    	}

        savedString = string(savedBytes); // convert bytes to string
    	return; 
    }
    
    function getSavedVar() view returns(bytes32) {
    	return savedVar;
    }
    
    function getSavedBytes() view returns(bytes) {
    	return savedBytes;
    }
    
    function getSavedString() view returns(string) {
    	return savedString;
    }
}
