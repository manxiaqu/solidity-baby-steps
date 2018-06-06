const creatorBalanceChecker = artifacts.require("creatorBalanceChecker");

contract("creatorBalanceChecker", function(accounts){
    before(async function () {
        this.creatorBalanceCheckerIns = await creatorBalanceChecker.new();
    })

    it("check the value of contract", async function () {
        const address = await this.creatorBalanceCheckerIns.getContractAddress();
        console.log("Address of contract is " + address);

        const creatorBalance_1 = await this.creatorBalanceCheckerIns.getCreatorBalance();
        console.log("creator balance_1 is " + creatorBalance_1);

        const creatorBalance_2 = await this.creatorBalanceCheckerIns.getCreatorDotBalance();
        console.log("creator dot balance is " + creatorBalance_2);
    })
})