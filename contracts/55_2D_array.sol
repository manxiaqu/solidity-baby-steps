pragma solidity ^0.4.18;

contract TwoD {

    address public creator;
    uint8 public arrayLength = 10;
    uint8[10][10] public integers; // compiler says this line can't yet know about arraylength variable in the line above

    constructor () public {
        creator = msg.sender;
        uint8 x = 0;
        uint8 y = 0;
        while(y < arrayLength) {
        	x = 0;
 		    while(x < arrayLength) {
 		    	integers[x][y] = arrayLength*y + x; // row 0: 0, 1   row 1: 2, 3
        		x++;
        	}
        	y++;
        }
    }
    
    function getValue(uint8 x, uint8 y) view returns(uint8) {
    	return integers[x][y];
    }
}