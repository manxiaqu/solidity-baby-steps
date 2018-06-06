pragma solidity ^0.4.18;

// Supposedly, contracts can get non-constant return values from other contracts. (Whereas you can't from web3/geth.)
// These two contracts are meant to test this. Like so:

// 1. Deploy Pong with a pongval.
// 2. Deploy Ping, giving it the address of Pong.
// 3. Call Ping.getPongvalRemote() using a sendTransaction...
// 4. ... which retreives the value of pongval from Pong.
// 5. If successful Ping.getPongval() should return the value from step 1.

// UPDATE: Pong doesn't need a copy of PongvalRetriever.
//contract PongvalRetriever {
// 	int8 pongval_tx_retrieval_attempted = 0;
//	function getPongvalTransactional() public returns (int8){	// tells Ping how to interact with Pong.
//		pongval_tx_retrieval_attempted = -1;
//		return pongval_tx_retrieval_attempted;
//	}
//}

contract Pong {

    address public creator;
    int8 public pongVal;
    int8 public pongValTxRetrievalAttempted = 0;
    
	/*********
 	 Step 1: Deploy Pong
 	 *********/
    constructor(int8 _pongVal) public {
        creator = msg.sender;
		pongVal = _pongVal;
    }
	
	/*********
	 Step 4. Transactionally return pongval, overriding PongvalRetriever
	 *********/	
	function getPongValTransactional() public returns(int8) {
		pongValTxRetrievalAttempted = 1;
    	return pongVal;
    }
    
// ----------------------------------------------------------------------------------------------------------------------------------------
    
    /*********
	 pongval getter/setter, just in case.
	 *********/
	function getPongValConstant() public view returns(int8) {
    	return pongVal;
    } 
	 	
	function setPongVal(int8 _pongVal) public {
		pongVal = _pongVal;
	}
	
	function getPongValTxRetrievalAttempted() public view returns(int8) {
		return pongValTxRetrievalAttempted;
	}
	
	/****
	 For double-checking this contract's address
	 ****/
	function getAddress() public view returns (address) {
		return this;
	}
}