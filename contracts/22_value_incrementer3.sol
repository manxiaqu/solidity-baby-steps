pragma solidity ^0.4.18;

// This contract demonstrates a simple non-constant (transactional) function you can call from geth.
// increment() takes TWO parameters and increments the interation value by howmuch and also sets an arbitrary customvalue.
// See below for how to make the call in geth. (incrementer3.increment.sendTransaction(3,9, {from:eth.coinbase,gas:1000000});)
// note that we needed more than the (geth) default gas of 90k this time. I chose 1 mil. (unused gas is refunded anyway)
contract Incrementer3 {

    address public creator;
    int public iteration;
    string public whatHappened;
    int customValue;

    constructor() public {
        creator = msg.sender; 								
        iteration = 0;
        whatHappened = "constructor executed";
    }

    function increment(int howMuch, int _customValue) public returns(bool) {
        customValue = _customValue;
    	if(howMuch == 0) {
    		iteration = iteration + 1;
            whatHappened = "howMuch was zero. Incremented by 1. customValue also set.";
    	} else {
        	iteration = iteration + howMuch;
            whatHappened = "howMuch was nonzero. Incremented by its value. customValue also set.";
        }

        return true;
    }
    
    function getCustomValue() view returns(int){
    	return customValue;
    }
    
    function getWhatHappened() view returns(string) {
    	return whatHappened;
    }
    
    function getIteration() view returns(int) {
        return iteration;
    }
}