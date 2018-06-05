pragma solidity ^0.4.18;

contract IndexOf {

    address public creator;
	int whatWasTheVal = -10; // -2 = not yet tested, as separate from -1, tested but error

	constructor() public {
        creator = msg.sender;
    }

    function indexOf(string _a, string _b) public returns(int) {
    	bytes memory a = bytes(_a);  
        bytes memory b = bytes(_b);
       
    	if(a.length < 1 || b.length < 1 || (b.length > a.length)) {
			whatWasTheVal = -1;
    		return -1;
    	} else if(a.length > (2**128 -1)) {
			whatWasTheVal = -1;
    		return -1;									
    	} else {
    		uint subIndex = 0;
    		for (uint i = 0; i < a.length; i++) {
    			if (a[i] == b[0]) {
					subIndex = 1;
    				while(subIndex < b.length && (i + subIndex) < a.length && a[i + subIndex] == b[subIndex]) {
						subIndex++;
    				}

    				if(subIndex == b.length) {
						whatWasTheVal = int(i);
    					return int(i);
    				}
    			}
    		}

			whatWasTheVal = -1;
    		return -1;
    	}	
    }
}