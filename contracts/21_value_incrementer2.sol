pragma solidity ^0.4.18;

// This contract demonstrates a simple non-constant (transactional) function you can call from geth.
// increment() takes ONE parameter and merely increments the "iteration" value by that much. 
// see below for the geth command to send the parameter to the increment(int howmuch) function.
contract Incrementer2 {

    address public creator;
    int public iteration;
    string public whatHappened;

    constructor() public {
        creator = msg.sender; 								
        iteration = 0;
        whatHappened = "constructor executed";
    }

    function increment(int howMuch) public returns(bool) {
    	if(howMuch == 0) {
    		iteration = iteration + 1;
            whatHappened = "howMuch was zero. Incremented by 1.";
    	} else {
        	iteration = iteration + howMuch;
            whatHappened = "howMuch was nonzero. Incremented by its value.";
        }

        return true;
    }
    
    function getWhatHappened() view returns(string) {
    	return whatHappened;
    }
    
    function getIteration() view returns(int) {
        return iteration;
    }
}
