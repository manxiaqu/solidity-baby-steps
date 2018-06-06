pragma solidity ^0.4.18;

/***
 *     _    _  ___  ______ _   _ _____ _   _ _____ 
 *    | |  | |/ _ \ | ___ \ \ | |_   _| \ | |  __ \
 *    | |  | / /_\ \| |_/ /  \| | | | |  \| | |  \/
 *    | |/\| |  _  ||    /| . ` | | | | . ` | | __ 
 *    \  /\  / | | || |\ \| |\  |_| |_| |\  | |_\ \
 *     \/  \/\_| |_/\_| \_\_| \_/\___/\_| \_/\____/
 *                                                 
 *   This contract DOES NOT WORK at the moment. 9/22/2015                                     
 */

// 1. Deploy Pong .
// 2. Deploy Ping, giving it the address of Pong.
// 3. Call Ping.touchPong() using a <pongaddress>.send()
// 4. ... which does... something ...

contract Ping {

	address public pvr;
    address public creator;
    int8 public sendVal = -2; // -2 == initialized, -1 == error, 0 == pong returned false. 1 == pong returned true

	/*********
 	 Step 2: Deploy Ping, giving it the address of Pong.
 	 *********/
    constructor(address pongAddress) public {
        creator = msg.sender; 	
        pvr = pongAddress;
    }

	/*********
     Step 3: Touch pong with a 3,000,000 wei "send" call and see what happens. 
     *********/
	function send3MilWeiToPong() public {
		sendVal = -1;  // at least we reached this function
		bool retVal = false;
		retVal = pvr.send(3000000); // send 3,000,000 wei to pong // trying to determine what exactly happens here.
		if(retVal) {
			sendVal = 1; // success!
		} else {
			sendVal = 0; // failure!
		}
	}	

	function getBalance() public view returns(uint256) {
		return address(this).balance;
	}
	

	function getSendVal() public view returns(int8) {
		return sendVal;
	}

    function setPongAddress(address pongAddress) public {
		pvr = pongAddress;
	}
	
	function getPongAddress() public view returns(address) {
		return pvr;
	}
    
    /****
	 For double-checking this contract's address
	 ****/
	function getAddress() public view returns(address) {
		return address(this);
	}
}
