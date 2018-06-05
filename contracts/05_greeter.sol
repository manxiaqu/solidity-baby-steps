pragma solidity ^0.4.18;

// Simple Greeter
// It take a string upon creation and repeats it when greet is called
// 创建合约时，传入greet字符串，后可以通过greet获取字符串
contract Greeter {
    // public means compiler will generate "get" function automatically for variables
    // 将变量设置为public后，编译器自动会为变量生成一个获取变量的函数，函数名即为变量名
    // 如果变量为数组或mapping，则还需传入index参数
    // creator/greeting将自动会生成creator(),greeting()两个函数返回变量值
    address public creator;
    string public greeting;

    constructor (string _greeting) public {
        creator = msg.sender;
        greeting = _greeting;
    }

    /**
     * @dev Get greet string
     */
    // view means it promises not to modify state
    // 获取greet字符串
    // view代表该函数不会修改state
    function greet() view returns(string) {
        return greeting;
    }

    /**
     * @dev Set a new greeting string
     * @param newGreeting New greeting string
     */
    function setGreeting(string newGreeting) public returns(bool) {
        greeting = newGreeting;
        return true;
    }

    /**
     * @dev Get block properties
     */
    // 获取链全局的基本信息
    function getBlockProperties() view returns(address, uint256, uint256, uint256, uint256) {
        return (
            block.coinbase,
            block.difficulty,
            block.gaslimit,
            block.number,
            block.timestamp
        );
    }

    /**
     * @dev Get transaction properties
     */
    // 返回交易的相关信息，分别为：剩余gas，交易的data字段，交易发送方，交易的签名，交易金额，当前块时间，交易原始发起方，gas价格
    function getTxProperties() view returns(uint256, bytes, address, bytes4, uint256, uint256, address, uint256) {
        return (
            gasleft(),
            msg.data,
            msg.sender,
            msg.sig,
            msg.value,
            now,
            tx.origin,
            tx.gasprice
        );
    }


    // Can receive eth
    function () public payable {}


    /**
     * @dev Destroy contract and send remaining funds back to msg.sender/creator
     */
    // 销毁当前合约，并且将合约中剩余的eth发送给创建合约的地址
    function kill() {
        // only allow this action if the account sending the signal is the creator
        if (msg.sender == creator) {
            // kills this contract and sends remaining funds back to creator
            suicide(creator);
        }
    }
}
