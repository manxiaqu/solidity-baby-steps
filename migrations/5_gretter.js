const Greeter = artifacts.require(`./Greeter.sol`);

module.exports = (deployer, network, addresses) => {
    const greeting = "hello, world!";
    deployer.deploy(Greeter, greeting);
};
