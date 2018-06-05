pragma solidity ^0.4.18;

//import "mortal";

contract MsgValueToBytes20 {

	uint initialVal;
	uint80 uint80val; 
	bytes20 finalVal;
    
    function convertMsgValueToBytes20() 
    {
        initialVal = msg.value;
    	if(msg.value > 0 || msg.value < 1208925819614629174706176) // 1 wei up to (2^80 - 1) wei is the valid uint80 range
    	{
    		uint80val = uint80(msg.value);
            finalVal = bytes20(uint80val);
    	}
    }
    
    function getInitialVal() view returns(uint) {
    	return initialVal;
    }
    
    function getUint80val() view returns(uint80) {
    	return uint80val;
    }
    
    function getFinalVal() view returns (bytes20) {
    	return finalVal;
    }
}