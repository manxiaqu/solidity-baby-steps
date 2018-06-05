// This contract is designed to demonstrate the generation of a random number.
// If you submit a betAndFlip() request after block 180,000 has just been mined,
// (i.e. when block 180,000 is the "best block" on stats.ethdev.gov and the most recent listed on any block explorer site), 
// then the transaction will get mined/processed in block 180,001. (most of the time, anyway... it may be a block or two later)
// Once the transaction is mined, then block.number will become 180,002 while the flipping is underway.
// Any attempt to get block.blockhash(180,002) will return 0x000000000...
// That's why betAndFlip uses blocknumber - 1 for its hash.
// At first I thought "Wait, if we have to use the block in past, couldn't the gambler know that?" And the answer is "no". 
// All the gambler knows at the time of bet submission is 180,000. We use 180,001 which is brand new and known and 180,002 is underway.

// NOTE: This contract is only meant to be used by you for testing purposes. I'm not responsible for lost funds if it's not bulletproof.
// 		 You can change msg.sender.send(...) to creator.send(...) in betAndFlip() to make sure funds only go back to YOUR account. 

// NOTE: I don't know how this will behave with multiple potential bettors (or even just multiple bets) per block. It is meant for your single, one-per-block use only.

// NOTE: Use more gas on the betAndFlip(). I set mine to 1,000,000 and the rest is automatically refunded (I think). At current prices 9/3/2015, it's negligible anyway.

contract CoinFlipper {

    address creator;
    int lastgainloss;
    string lastresult;
    uint lastblocknumberused;
    bytes32 lastblockhashused;

    function CoinFlipper() public
    {
        creator = msg.sender; 								
        lastresult = "no wagers yet";
        lastgainloss = 0;
    }
	
    function getEndowmentBalance() constant returns (uint)
    {
    	return this.balance;
    }
    
    // this is probably unnecessary and gas-wasteful. The lastblockhashused should be random enough. Adding the rest of these deterministic factors doesn't change anything. 
    // This does, however, let the bettor introduce a random seed by wagering different amounts. wagering 1 ETH will produce a completely different hash than 1.000000001 ETH
    
    function sha(uint128 wager) constant private returns(uint256)  	// DISCLAIMER: This is pretty random... but not truly random.
    { 
        return uint256(sha3(block.difficulty, block.coinbase, now, lastblockhashused, wager));  
    }
    
    function betAndFlip() public               
    {
    	if(msg.value > 340282366920938463463374607431768211455)  	// value can't be larger than (2^128 - 1) which is the uint128 limit
    	{
    		lastresult = "wager too large";
    		lastgainloss = 0;
    		msg.sender.send(msg.value); // return wager
    		return;
    	}		  
    	else if((msg.value * 2) > this.balance) 					// contract has to have 2*wager funds to be able to pay out. (current balance INCLUDES the wager sent)
    	{
    		lastresult = "wager larger than contract's ability to pay";
    		lastgainloss = 0;
    		msg.sender.send(msg.value); // return wager
    		return;
    	}
    	else if (msg.value == 0)
    	{
    		lastresult = "wager was zero";
    		lastgainloss = 0;
    		// nothing wagered, nothing returned
    		return;
    	}
    		
    	uint128 wager = uint128(msg.value);          				// limiting to uint128 guarantees that conversion to int256 will stay positive
    	
    	lastblocknumberused = block.number - 1 ;
    	lastblockhashused = block.blockhash(lastblocknumberused);
    	uint128 lastblockhashused_uint = uint128(lastblockhashused) + wager;
    	uint hashymchasherton = sha(lastblockhashused_uint);
    	
	    if( hashymchasherton % 2 == 0 )
	   	{
	    	lastgainloss = int(wager) * -1;
	    	lastresult = "loss";
	    	// they lost. Return nothing.
	    	return;
	    }
	    else
	    {
	    	lastgainloss = wager;
	    	lastresult = "win";
	    	msg.sender.send(wager * 2);  // They won. Return bet and winnings.
	    } 		
    }
    
  	function getLastBlockNumberUsed() constant returns (uint)
    {
        return lastblocknumberused;
    }
    
    function getLastBlockHashUsed() constant returns (bytes32)
    {
    	return lastblockhashused;
    }

    function getResultOfLastFlip() constant returns (string)
    {
    	return lastresult;
    }
    
    function getPlayerGainLossOnLastFlip() constant returns (int)
    {
    	return lastgainloss;
    }
}
