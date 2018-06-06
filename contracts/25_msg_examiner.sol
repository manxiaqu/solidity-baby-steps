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

    constructor() public payable {
        creator = msg.sender;
       
        contractCreationData = msg.data;
        contractCreationGas = gasleft();
        contractCreationValue = msg.value;  				// the endowment of this contract in wei

        contractCreationTxGasprice = tx.gasprice;
        contractCreationTxOrigin = tx.origin;
    }

    function setMiner(address newMiner) public returns(bool) {
        require(newMiner != address(0));
        miner = newMiner;
        return true;
    }
	
	function getContractCreationData() public view returns(bytes) {
    	return contractCreationData;
    }
	
	function getContractCreationGas() public view returns(uint256) {										              		// the creation of this contract. gasleft() should be gasleft()Expended
    	return contractCreationGas;
    }
	
    function getContractCreationValue() public view returns(uint256) {										              		// set at creation time with "value: <someweivalue>"
    	return contractCreationValue;                         // this is now the "balance" of the contract
    }
    
    function getContractCreationTxGasprice() public view returns(uint256) {											     				 // the sender is willing to pay. gasleft()Price should be gasleft()Limit
    	return contractCreationTxGasprice;
    }
    
    function getContractCreationTxOrigin() public view returns(address) {											     				  //  Not sure if a chain of transactions would return the same.
    	return contractCreationTxOrigin;
    }
    
    bytes msg_data_before_creator_send;
    bytes msg_data_after_creator_send;
    uint msg_gas_before_creator_send;
    uint msg_gas_after_creator_send;
  	uint msg_value_before_creator_send;
    uint msg_value_after_creator_send;
    
    function sendOneEtherToMiner() public payable returns (bool success) {
    	msg_gas_before_creator_send = gasleft();			// save msg values
    	msg_data_before_creator_send = msg.data;	
    	msg_value_before_creator_send = msg.value;			  
    	bool returnval = miner.send(1000000000000000000);				// do something gassy
    	msg_gas_after_creator_send = gasleft();			// save them again
    	msg_data_after_creator_send = msg.data;
    	msg_value_after_creator_send = msg.value;		// did anything change? Use getters below.
    	return returnval;
    }
    
    function sendOneEtherToHome() public returns (bool success) {
    	msg_gas_before_creator_send = gasleft();			// save msg values
    	msg_data_before_creator_send = msg.data;	
    	msg_value_before_creator_send = msg.value;			  
    	bool returnval = creator.send(1000000000000000000);				// do something gassy
    	msg_gas_after_creator_send = gasleft();			// save them again
    	msg_data_after_creator_send = msg.data;
    	msg_value_after_creator_send = msg.value;		// did anything change? Use getters below.
    	return returnval;
    }
    
    
    function getMsgDataBefore() public view returns(bytes) {
    	return msg_data_before_creator_send;							  
    }
    
    function getMsgDataAfter() public view returns(bytes) {
    	return msg_data_after_creator_send;							  
    }
    
    
    function getMsgGasBefore() public view returns(uint256) {
    	return msg_gas_before_creator_send;							  
    }
    
    function getMsgGasAfter() public view returns(uint256) {
    	return msg_gas_after_creator_send;							  
    }
    
   
    function getMsgValueBefore() public view returns(uint256) {
    	return msg_value_before_creator_send;							  
    }
    
    function getMsgValueAfter() public view returns(uint256) {
    	return msg_value_after_creator_send;							  
    }
}
