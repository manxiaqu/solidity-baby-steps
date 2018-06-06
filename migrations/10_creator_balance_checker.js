const creatorBalanceChecker = artifacts.require(`./creatorBalanceChecker.sol`);

module.exports = (deployer, network, addresses) => {
    deployer.deploy(creatorBalanceChecker);
};
