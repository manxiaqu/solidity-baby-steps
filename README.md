# 以太坊合约简单例子
在fork的基础上，修改了代码风格，更新代码适应solidity新特性等

# 内容
* [合约地址探测](./contracts/70_contract_detector.sol)可通过预生成合约地址的方式绕过

# 测试
本項目中使用了truffle和ganache-cli，具体安装方法可以参考官方文档。运行测试用例（只写了较少的一部分）：  
打开一个客户端
```bash
ganache-cli
```
打开另一个客户端
```bash
truffle test
```
结果:
```bash
  Contract: creatorBalanceChecker
Address of contract is 0x56e0d275850b0bf467aae90bfe0e30b5f68c4b5f
creator balance_1 is 7.748564837299342875997e+21
creator dot balance is 7.748539032999342875997e+21
    ✓ check the value of contract (42ms)

  Contract: Greeter contract
    greeting test
      ✓ should right init (42ms)
    set greeting
      ✓ should right set new greeting (668ms)
    global variables
      ✓ should right get block/tx info
    self destroy
      ✓ should right send eth and self destroy (562ms)

  Contract: BasicIterator
    ✓ should right init (79ms)
    ✓ should right sum array


  7 passing (2s)
```
