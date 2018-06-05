pragma solidity ^0.4.18;

// This is supposed to allow for examination of msgs, but it proved less than informative.
// I'd just skip this for now.
contract msgExaminer {

    address public creator;
    address public miner;
  
    bytes public contractCreationData;
    uint public contractCreationGas;
    uint public contractCreationValue;
    uint public contractCreationTxGasprice;
    address public contractCreationTxOrigin;

    constructor() public {
        creator = msg.sender;
       
        miner = 0x910561dc5921131ee5de1e9748976a4b9c8c1e80;
        contractCreationData = msg.data;
        contractCreationGas = msg.gas;
        contractCreationValue = msg.value;  				// the endowment of this contract in wei

        contractCreationTxGasprice = tx.gasprice;
        contractCreationTxOrigin = tx.origin;
    }
	
	function getContractCreationData() constant returns (bytes) 		
    {										              			
    	return contractCreationData;
    }
	
	function getContractCreationGas() constant returns (uint) 	// returned 732117 for me. Must be the gas expended 
    {										              		// the creation of this contract. msg.gas should be msg.gasExpended	
    	return contractCreationGas;
    }
	
    function getContractCreationValue() constant returns (uint) // returns the original endowment of the contract
    {										              		// set at creation time with "value: <someweivalue>"	
    	return contractCreationValue;                         // this is now the "balance" of the contract
    }
    
    function getContractCreationTxGasprice() constant returns (uint) // returned 50000000000 for me. Must be the gasprice 	
    {											     				 // the sender is willing to pay. msg.gasPrice should be msg.gasLimit
    	return contractCreationTxGasprice;
    }
    
    function getContractCreationTxOrigin() constant returns (address) // returned my coinbase address.
    {											     				  //  Not sure if a chain of transactions would return the same.
    	return contractCreationTxOrigin;
    }
    
    bytes msg_data_before_creator_send;
    bytes msg_data_after_creator_send;
    uint msg_gas_before_creator_send;
    uint msg_gas_after_creator_send;
  	uint msg_value_before_creator_send;
    uint msg_value_after_creator_send;
    
    function sendOneEtherToMiner() returns (bool success)      	
    {						
    	msg_gas_before_creator_send = msg.gas;			// save msg values
    	msg_data_before_creator_send = msg.data;	
    	msg_value_before_creator_send = msg.value;			  
    	bool returnval = miner.send(1000000000000000000);				// do something gassy
    	msg_gas_after_creator_send = msg.gas;			// save them again
    	msg_data_after_creator_send = msg.data;
    	msg_value_after_creator_send = msg.value;		// did anything change? Use getters below.
    	return returnval;
    }
    
    function sendOneEtherToHome() returns (bool success)         	
    {						
    	msg_gas_before_creator_send = msg.gas;			// save msg values
    	msg_data_before_creator_send = msg.data;	
    	msg_value_before_creator_send = msg.value;			  
    	bool returnval = creator.send(1000000000000000000);				// do something gassy
    	msg_gas_after_creator_send = msg.gas;			// save them again
    	msg_data_after_creator_send = msg.data;
    	msg_value_after_creator_send = msg.value;		// did anything change? Use getters below.
    	return returnval;
    }
    
    
    function getMsgDataBefore() constant returns (bytes)          
    {						
    	return msg_data_before_creator_send;							  
    }
    
    function getMsgDataAfter() constant returns (bytes)         
    {						
    	return msg_data_after_creator_send;							  
    }
    
    
    function getMsgGasBefore() constant returns (uint)          
    {						
    	return msg_gas_before_creator_send;							  
    }
    
    function getMsgGasAfter() constant returns (uint)         
    {						
    	return msg_gas_after_creator_send;							  
    }
    
   
    function getMsgValueBefore() constant returns (uint)          
    {						
    	return msg_value_before_creator_send;							  
    }
    
    function getMsgValueAfter() constant returns (uint){
    	return msg_value_after_creator_send;							  
    }
}
