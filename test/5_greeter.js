const Greeter = artifacts.require("Greeter");

contract("Greeter contract", function (accounts) {
    before(async function () {
        this.greeting = "hello, world";
        this.GreeterIns = await Greeter.new(this.greeting);
    })

    describe("greeting test", function () {
        it("should right init", async function() {
            const creator = accounts[0];

            const acutalCreator = await this.GreeterIns.creator();
            assert.equal(acutalCreator, creator, "creator should be right init");

            // This is the default get method created by compiler for public variables
            // greeting()方法是编译器为public变量自动创建的，方法名即为变量名
            const actualDefaultGreeting = await this.GreeterIns.greeting();
            assert.equal(actualDefaultGreeting, this.greeting, "greeting should be right init");

            const actualGreeting = await this.GreeterIns.greet();
            assert.equal(actualGreeting, this.greeting, "greeting should be right init");
        })
    })

    describe("set greeting", function () {
        it("should right set new greeting", async function(){
            const newGreeting = "New, hello world";

            await this.GreeterIns.setGreeting(newGreeting);
            const newActualGreeting = await this.GreeterIns.greeting();
            assert.equal(newActualGreeting, newGreeting, "should right set new greeting");
        })
    })

    describe("global variables", function () {
        it("should right get block/tx info", async function () {
            const blockInfo = await this.GreeterIns.getBlockProperties();
            assert.equal(blockInfo.length, 5, "should right get block info");

            const txInfo = await this.GreeterIns.getTxProperties();
            assert.equal(txInfo.length, 8, "should right get tx info");
        })
    })
    
    describe("self destroy", function () {
        it("should right send eth and self destroy", async function () {
            const amount = await web3.toWei(10, "ether");

            await this.GreeterIns.sendTransaction({value: amount});
            await this.GreeterIns.kill();

            const code = web3.eth.getCode(this.GreeterIns.address);
            assert.isBelow(code.length, 10, "code will be removed after destroy");
        })
    })
})