pragma solidity ^0.4.18;

// This contract demonstrates a simple non-constant (transactional) function you can call from geth.
// increment() takes no parameters and merely increments the "iteration" value.
contract Incrementer {

    address public creator;
    uint256 public iteration;

    constructor() public {
        creator = msg.sender; 
        iteration = 0;
    }

    function increment() public {
        iteration = iteration + 1;
    }
    
    function getIteration() public view returns(uint256){
        return iteration;
    }
}