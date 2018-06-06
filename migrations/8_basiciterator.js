const BasicIterator = artifacts.require(`./BasicIterator.sol`);

module.exports = (deployer, network, addresses) => {
    deployer.deploy(BasicIterator);
};
