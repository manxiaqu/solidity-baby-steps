const ContractDetector = artifacts.require("ContractDetector");
const ContractDetectorTest = artifacts.require("ContractDetectorTest");

const CONTRACT = "contract";
const NORMAL = "normal";
contract("ContractDetector", function(accounts) {
    beforeEach(async function(){
        this.ContractDetectorIns = await ContractDetector.new();
    });

    it("simple test for rlp", async function () {
        TestRlp();
    })

    it("should right detect a contract published on network", async function () {
        this.TestInsOne = await ContractDetectorTest.new();
        // Detect address is a contract or not
        await this.ContractDetectorIns.Detect(this.TestInsOne.address);

        const res = await this.ContractDetectorIns.getContractOrNormal();
        assert.equal(res, CONTRACT, "detect contract success");
    })

    it("a address can be normal address detected on first time, then be a contract", async function () {
        const sender = accounts[0];
        const other = accounts[1];
        const nonce = await web3.eth.getTransactionCount(sender);
        var address = '0x' + gererateAddress(sender, nonce);
        // Avoiding increase nonce of sender, so this method is called by other
        // 如果该处更改交易发送方，发送方的nonce会递增，造成预生成的地址失效
        await this.ContractDetectorIns.Detect(address, {from: other});
        const resBefore = await this.ContractDetectorIns.getContractOrNormal({from:other});
        assert.equal(resBefore, NORMAL, "address before is a normal address");

        await ContractDetectorTest.new();
        await this.ContractDetectorIns.Detect(address, {from: other});
        const resAfter = await this.ContractDetectorIns.getContractOrNormal({from:other});
        assert.equal(resAfter, CONTRACT, "address after is a contract address");
    })
});


// Based on https://github.com/ethereum/go-ethereum/blob/master/crypto/crypto_test.go#L98
function TestRlp() {
    const address = "0x970e8128ab834e8eac17ab8e3812f010678cf791";
    const rlpEncode0 = RlpEncode(address, 0);
    const rlpEncode1 = RlpEncode(address, 1);
    const rlpEncode2 = RlpEncode(address, 2);
    const acutalAddr0 = web3.sha3(rlpEncode0, {encoding:'hex'}).substring(24+2);
    const acutalAddr1 = web3.sha3(rlpEncode1, {encoding:'hex'}).substring(24+2);
    const acutalAddr2 = web3.sha3(rlpEncode2, {encoding:'hex'}).substring(24+2);

    const addr0 = "333c3310824b7c685133f2bedb2ca4b8b4df633d";
    const addr1 = "8bda78331c916a08481428e4b07c96d3e916d165";
    const addr2 = "c9ddedf451bc62ce88bf9292afb13df35b670699";
    assert.equal(acutalAddr0, addr0, "addr 0 should equal");
    assert.equal(acutalAddr1, addr1, "addr 1 should equal");
    assert.equal(acutalAddr2, addr2, "addr 2 should equal");
}

function gererateAddress(address, nonce) {
    const data = RlpEncode(address, nonce);
    return web3.sha3(data, {encoding:'hex'}).substring(24+2);
}

// Based on https://github.com/ethereum/wiki/wiki/RLP
// Not tested thoroughly
// 没有经过全面的测试，不一定完全可用！
function RlpEncode(address, nonce) {
    var a = EncodeAddress(address);
    var b = EncodeNonce(nonce);
    return intToHexString(0xc0 + (a.length + b.length)/2) + a + b;
}

function EncodeNonce(nonce) {
    var s = nonce.toString(16).toUpperCase();
    var nonceByte = hexStringToByte(s);
    if (nonceByte.length == 1 && nonceByte[0] < 0x80) {
        if (nonceByte[0] == 0) {
            return '80';
        }
        return intToHexString(nonceByte[0]);
    } else {
        var output = '';
        for (var i = 0; i < nonceByte.length; i++) {
            output += intToHexString(nonceByte[i]);
        }
        return intToHexString(0x80 + nonceByte.length) + output;
    }
}

function EncodeAddress(address) {

    address = address.toUpperCase().substring(2);
    var addressBytes = hexStringToByte(address);
    var len = addressBytes.length;

    var output = '';
    for (var i = 0; i < len; i++) {
        var tmp = addressBytes[i];
        output += intToHexString(tmp);
    }
    return intToHexString(len + 0x80) + output
}

function hexStringToByte(str) {
    if (!str) {
        return new [];
    }

    var a = [];
    for (var i = 0, len = str.length; i < len; i+=2) {
        a.push(parseInt(str.substr(i,2), 16));
    }

    return a;
}

function intToHexString(value) {
    var res = value.toString(16);
    if (res.length%2 != 0) {
        res = '0' + res;
    }

    return res;
}