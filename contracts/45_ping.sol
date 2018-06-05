pragma solidity ^0.4.18;

// Contracts can get non-constant return values from functions in other contracts. (Whereas you can't from web3/geth.)
// These two contracts are meant to test this. Like so:

// 1. Deploy Pong with a pongval.
// 2. Deploy Ping, giving it the address of Pong.
// 3. Call Ping.getPongvalRemote() using a sendTransaction...
// 4. ... which retreives the value of pongval from Pong.
// 5. If successful Ping.getPongval() should return the value from step 1.

contract PongValRetriever {
 	int8 pongValTxRetrievalAttempted = 0;
	function getPongValTransactional() public returns(int8){	// tells Ping how to interact with Pong.
		pongValTxRetrievalAttempted = -1;
		return pongValTxRetrievalAttempted;
	}
}
//
//contract Ping {
//
// 	int8 pongVal;
//	PongvalRetriever public pvr;
//    address creator;
//
//    function Ping(PongvalRetriever _pongAddress) {
//        creator = msg.sender;
//		pongVal = -1;
//        pvr = _pongAddress;
//    }
//
//	function getPongValRemote() {
//		pongVal = pvr.getPongValTransactional();
//	}
//
//    function getPongValConstant() view returns(int8) {
//    	return pongVal;
//    }
//
//    function setPongAddress(PongvalRetriever _pongAddress) public {
//		pvr = _pongAddress;
//	}
//
//	function getPongAddress() public view returns(address){
//		return pvr;
//	}
//}
