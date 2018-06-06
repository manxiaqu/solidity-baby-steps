const BasicIterator = artifacts.require("BasicIterator");

contract("BasicIterator", function(accounts){
    before(async function () {
        this.BasicIteratorIns = await BasicIterator.new();
    })

    it("should right init", async function () {
        for (var i = 0; i < 10; i++) {
            const tmp = await this.BasicIteratorIns.integers(i);
            assert.equal(tmp, i, "number " + i + " should be right init");
        }
    })

    it("should right sum array", async function () {
        const actualRes = await this.BasicIteratorIns.getSum();
        const res = 45;
        assert.equal(res, actualRes, "res should equal");
    })
})
