pragma solidity ^0.4.18;

contract ByteExtractor {

    address public creator;

    constructor() public {
        creator = msg.sender;
    }
    
    function getByteFromByte8(bytes8 _b8, uint8 byteIndex) public pure returns(byte) {
    	uint numDigits = 16;
    	uint bUint = uint(_b8);
    	uint upperPowerVar = 16 ** (numDigits - (byteIndex*2)); 		// @i=0 upperPowerVar=16**64, @i=1 upperPowerVar=16**62, @i upperPowerVar=16**60
    	uint lowerPowerVar = 16 ** (numDigits - 2 - (byteIndex*2));		// @i=0 upperPowerVar=16**62, @i=1 upperPowerVar=16**60, @i upperPowerVar=16**58
    	uint postHeadChop = bUint % upperPowerVar; 				// @i=0 _b32=a1b2c3d4... postHeadChop=a1b2c3d4, @i=1 postHeadChop=b2c3d4, @i=2 postHeadChop=c3d4
    	uint remainder = postHeadChop % lowerPowerVar; 			// @i=0 remainder=b2c3d4, @i=1 remainder=c3d4, @i=2 remainder=d4
    	uint evenedOut = postHeadChop - remainder; 				// @i=0 evenedOut=a1000000, @i=1 remainder=b20000, @i=2 remainder=c300
    	uint b = evenedOut / lowerPowerVar; 					// @i=0 b=a1, @i=1 b=b2, @i=2 b=c3
    	return byte(b);
    }
    
    //returns a byte (of the range 0-255) from a bytes32
    function getByteFromByte32(bytes32 _b32, uint8 byteIndex) public pure returns(byte) {
    	uint numDigits = 64;
    	uint bUint = uint(_b32);
    	uint upperPowerVar = 16 ** (numDigits - (byteIndex*2)); 		// @i=0 upperPowerVar=16**64 (SEE EXCEPTION BELOW), @i=1 upperPowerVar=16**62, @i upperPowerVar=16**60
    	uint lowerPowerVar = 16 ** (numDigits - 2 - (byteIndex*2));		// @i=0 upperPowerVar=16**62, @i=1 upperPowerVar=16**60, @i upperPowerVar=16**58
    	uint postHeadChop;
    	if(byteIndex == 0)
    		postHeadChop = bUint; 								//for byteIndex 0, bUint is just the input number. 16^64 is out of uint range, so this exception has to be made.
    	else
    		postHeadChop = bUint % upperPowerVar; 				// @i=0 _b32=a1b2c3d4... postHeadChop=a1b2c3d4, @i=1 postHeadChop=b2c3d4, @i=2 postHeadChop=c3d4
    	uint remainder = postHeadChop % lowerPowerVar; 			// @i=0 remainder=b2c3d4, @i=1 remainder=c3d4, @i=2 remainder=d4
    	uint evenedOut = postHeadChop - remainder; 				// @i=0 evenedOut=a1000000, @i=1 remainder=b20000, @i=2 remainder=c300
    	uint b = evenedOut / lowerPowerVar; 					// @i=0 b=a1, @i=1 b=b2, @i=2 b=c3
    	return byte(b);
    }
    
    // returns a uint8 of the range 0-255 from a bytes32
    function getUint8FromByte32(bytes32 _b32, uint8 byteIndex) public pure returns(uint8) {
    	uint numDigits = 64;
    	uint bUint = uint(_b32);
    	uint upperPowerVar = 16 ** (numDigits - (byteIndex*2)); 		// @i=0 upperPowerVar=16**64 (SEE EXCEPTION BELOW), @i=1 upperPowerVar=16**62, @i upperPowerVar=16**60
    	uint lowerPowerVar = 16 ** (numDigits - 2 - (byteIndex*2));		// @i=0 upperPowerVar=16**62, @i=1 upperPowerVar=16**60, @i upperPowerVar=16**58
    	uint postHeadChop;
    	if(byteIndex == 0)
    		postHeadChop = bUint; 								//for byteIndex 0, bUint is just the input number. 16^64 is out of uint range, so this exception has to be made.
    	else
    		postHeadChop = bUint % upperPowerVar; 				// @i=0 _b32=a1b2c3d4... postHeadChop=a1b2c3d4, @i=1 postHeadChop=b2c3d4, @i=2 postHeadChop=c3d4
    	uint remainder = postHeadChop % lowerPowerVar; 			// @i=0 remainder=b2c3d4, @i=1 remainder=c3d4, @i=2 remainder=d4
    	uint evenedOut = postHeadChop - remainder; 				// @i=0 evenedOut=a1000000, @i=1 remainder=b20000, @i=2 remainder=c300
    	uint b = evenedOut / lowerPowerVar; 					// @i=0 b=a1 (to uint), @i=1 b=b2, @i=2 b=c3
    	return uint8(b);
    }
    
    // returns a uint of the range 0-15
    function getDigitFromByte32(bytes32 _b32, uint8 index) public pure returns(uint256) {
    	uint numDigits = 64;
    	uint bUint = uint(_b32);
    	uint upperPowerVar = 16 ** (numDigits - index); 		// @i=0 upperPowerVar=16**64, @i=1 upperPowerVar=16**63, @i upperPowerVar=16**62
    	uint lowerPowerVar = 16 ** (numDigits - 1 - index);		// @i=0 upperPowerVar=16**63, @i=1 upperPowerVar=16**62, @i upperPowerVar=16**61
    	uint postHeadChop = bUint % upperPowerVar; 				// @i=0 _b32=a1b2c3d4... postHeadChop=a1b2c3d4, @i=1 postHeadChop=b2c3d4, @i=2 postHeadChop=c3d4
    	uint remainder = postHeadChop % lowerPowerVar; 			// @i=0 remainder=b2c3d4, @i=1 remainder=c3d4, @i=2 remainder=d4
    	uint evenedOut = postHeadChop - remainder; 				// @i=0 evenedOut=a1000000, @i=1 remainder=b20000, @i=2 remainder=c300
    	uint b = evenedOut / lowerPowerVar; 					// @i=0 b=a, @i=1 b=1, @i=2 b=b
    	return b;
    }
    
    // does this work? Doesn't seem quite right. uint256 is much larger than bytes32, why are we guaranteeing 64 digits? Me = confused
    function getDigitFromUint(uint bUint, uint8 index) public pure returns(uint256) {
    	uint numDigits = 64;
    	uint upperPowerVar = 10 ** (numDigits - index); 		// @i=0 upperPowerVar=10**64, @i=1 upperPowerVar=10**63, @i upperPowerVar=10**62
    	uint lowerPowerVar = 10 ** (numDigits - 1  -index);		// @i=0 upperPowerVar=10**63, @i=1 upperPowerVar=10**62, @i upperPowerVar=10**61
    	uint postHeadChop = bUint % upperPowerVar; 				// @i=0 _b32=a1b2c3d4... postHeadChop=a1b2c3d4, @i=1 postHeadChop=b2c3d4, @i=2 postHeadChop=c3d4
    	uint remainder = postHeadChop % lowerPowerVar; 			// @i=0 remainder=b2c3d4, @i=1 remainder=c3d4, @i=2 remainder=d4
    	uint evenedOut = postHeadChop - remainder; 				// @i=0 evenedOut=a1000000, @i=1 remainder=b20000, @i=2 remainder=c300
    	uint b = evenedOut / lowerPowerVar; 					// @i=0 b=a1, @i=1 b=b2, @i=2 b=c3
    	return b;
    }
}