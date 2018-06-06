pragma solidity ^0.4.18;

contract ArrayRR {

    address public creator;
    uint8 public arrayLength = 10;
    uint8[10] public integers; // NOTE 1 see below
    int8 public setArraySuccessful = -1; // 1 success, 0 fail, -1 not yet tried

    constructor() public {
        creator = msg.sender;
        uint8 x = 0;
        while(x < integers.length) {
        	integers[x] = 1; // initialize array to all zeros
        	x++;
        }
    }
    
    function setArray(uint8[10] incoming) public returns(bool) {
    	setArraySuccessful = 0;
    	uint8 x = 0;
        while(x < arrayLength) {
        	integers[x] = incoming[x]; // initialize array to all zeros
        	x++;
        }

        setArraySuccessful = 1;
    	return true;
    }
    
    function getArraySettingResult() public view returns(int8) {
    	return setArraySuccessful;
    }
    
    function getArray() public view returns(uint8[10]) {
    	return integers;
    }
    
    function getValue(uint8 x) public view returns(uint8) {
    	return integers[x];
    }
}