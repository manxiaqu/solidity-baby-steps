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

contract Pong {

    address public creator;
    int8 public constructorTouches = 0;
    int8 public namelessTouches = 0;
    
	/*********
 	 Step 1: Deploy Pong
 	 *********/
    constructor() public {
        creator = msg.sender;
		constructorTouches = constructorTouches + 1;
    }
	
	/*********
	 Step 4. Accept generic transaction (send(), hopefully)
	 *********/	
	function () public {
		namelessTouches = namelessTouches + 1;
    	return;
    }

	function getBalance() public view returns(uint) {
		return address(this).balance;
	}
	
    /*********
	 touches getters
	 *********/
	function getConstructorTouches() public view returns(int8) {
    	return constructorTouches;
    } 
	
	function getNamelessTouches() public view returns(int8) {
		return namelessTouches;
	}

	function getAddress() public view returns (address) {
		return address(this);
	}
}
