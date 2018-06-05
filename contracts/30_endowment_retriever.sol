contract EndowmentRetriever {

    address creator;
    uint contract_creation_value; // original endowment

    function EndowmentRetriever() public 
    {
        creator = msg.sender; 								
        contract_creation_value = msg.value;  				// the endowment of this contract in wei 
    }
	
    function getContractCreationValue() constant returns (uint) // returns the original endowment of the contract
    {										              		// set at creation time with "value: <someweivalue>"	
    	return contract_creation_value;                         // this was the "balance" of the contract at creation time
    }
    
    function sendOneEtherHome() public         	
    {						
    	creator.send(1000000000000000000);				// send 1 ETH home
    }
        
    /**********
     Standard kill() function to recover funds 
     **********/
    
    function kill()
    { 
        if (msg.sender == creator)
        {
            suicide(creator);  // kills this contract and sends remaining funds back to creator
        }
    }
        
}