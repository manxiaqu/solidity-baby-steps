pragma solidity ^0.4.18;

/***
 *     _    _  ___  ______ _   _ _____ _   _ _____ 
 *    | |  | |/ _ \ | ___ \ \ | |_   _| \ | |  __ \
 *    | |  | / /_\ \| |_/ /  \| | | | |  \| | |  \/
 *    | |/\| |  _  ||    /| . ` | | | | . ` | | __ 
 *    \  /\  / | | || |\ \| |\  |_| |_| |\  | |_\ \
 *     \/  \/\_| |_/\_| \_\_| \_/\___/\_| \_/\____/
 *                                                 
 *   This contract DOES NOT WORK. It is not currently possible to 
 *   determine whether an address hash is a contract or normal address
 *   from Solidity.
 */
contract ContractDetector {

    address creator;
    string contractOrNormal = "not checked";
    
    constructor() public {
        creator = msg.sender;
    }

    // Will not work on some special situation
    // extcodesize is a opcode, and will return the code size of a address
    // 该方法在某些特殊的场景情况下会失败
    // extcodesize是evm的opcode，作用是返回地址的代码长度
    function Detect(address incAddr) public returns(bool) {
        uint x;
        assembly { x := extcodesize(incAddr) }
        if (x == 0) {
            contractOrNormal = "normal";
        } else {
            contractOrNormal = "contract";
        }

        return true;
    }
    
    function getContractOrNormal() view returns(string) {
    	return contractOrNormal;
    }
}