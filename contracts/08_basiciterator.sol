pragma solidity ^0.4.18;

/*
	This is a very simple demonstration of a while loops. Same as JS/c.
*/
contract BasicIterator {
    // reserve one "address"-type spot
    address public creator;
    // reserve a chunk of storage for 10 8-bit unsigned integers in an array
    // 创建一个一维数组，数组长度为10（不可修改），数组初始元素均为0
    uint8[10] public integers;

    constructor() public {
        creator = msg.sender;
        uint8 x = 0;
        while(x < integers.length) {
            // set integers to [0,1,2,3,4,5,6,7,8,9] over ten iterations
        	integers[x] = x;
        	x++;
        }
    }


    /**
     * @dev Get sum of integers array
     */
    function getSum() view returns (uint) {
    	uint8 sum = 0;
    	uint8 x = 0;
    	while(x < integers.length) {
        	sum = sum + integers[x];
        	x++;
        }
    	return sum;
    }
}
