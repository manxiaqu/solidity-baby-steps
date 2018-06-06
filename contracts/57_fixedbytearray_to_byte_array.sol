pragma solidity ^0.4.18;

/***
 *     _    _  ___  ______ _   _ _____ _   _ _____ 
 *    | |  | |/ _ \ | ___ \ \ | |_   _| \ | |  __ \
 *    | |  | / /_\ \| |_/ /  \| | | | |  \| | |  \/
 *    | |/\| |  _  ||    /| . ` | | | | . ` | | __ 
 *    \  /\  / | | || |\ \| |\  |_| |_| |\  | |_\ \
 *     \/  \/\_| |_/\_| \_\_| \_/\___/\_| \_/\____/
 *                                                 
 *   This contract DOES NOT WORK. It was/is an experiment
 *   to try and manually convert a fixed byte array (e.g. byte4)
 *   into byte[4] using hard maths. A strange thing happened: 
 *   Filling the byte[4] array doesn't work. See below. 9/20/2015
 *                                
 */
contract Bytes4ToByteArrayWithLength4 {

    address public creator;

    uint public digit = 0;
    byte public b0 = 0;
    byte public b1 = 0;
    byte public b2 = 0;
    byte public b3 = 0;
    byte[4] public finalBytes;

    constructor() public {
        creator = msg.sender;
    }

    function convertBytes4ToArray(bytes4 _a) public {
        uint bUint = uint(_a);
        uint x = 0;
        uint prevHead = 0;
        uint tail = 0;
        uint powerVar = 0;
        uint bUintMinusPhat = 0; // phat = prevHead and tail
        uint numBytes = 4;
        while(x < numBytes) {
            powerVar= (16 ** ((numBytes*2) - 2 - (x*2)));
            tail = bUint % powerVar;
            bUintMinusPhat = ((bUint - prevHead) - tail);
            digit = bUintMinusPhat / powerVar;
            prevHead = bUint - tail;
            finalBytes[x] = byte(digit); // this fills first value, but not the last 3
            
            // To prove what digit is for all 4 iterations...
            if(x == 0) {
                b0 = byte(digit);
            } else if(x == 1) {
                b1 = byte(digit);
            } else if(x == 2) {
                b2 = byte(digit);
            } else {
                b3 = byte(digit);
            }
            x++;
        }
    }
    
    function getDigit() public view returns(uint) {
        return digit;
    }
    
    function getFinalBytes() public view returns(byte[4]) {
        return finalBytes;
    }
    
    // retrieve digit manually for all 4 iterations
    function getB0() public view returns(byte) {
        return b0;
    }
     
    function getB1() public view returns(byte) {
        return b1;
    }
     
    function getB2() public view returns(byte) {
        return b2;
    }
     
    function getB3() public view returns(byte) {
        return b3;
    }
}