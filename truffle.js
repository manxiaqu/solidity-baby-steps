// require('babel-register')({
//     // Important to have zeppelin-solidity working on
//     ignore: /node_modules\/(?!zeppelin-solidity)/
// });

// require('babel-polyfill');

module.exports = {
    networks: {
        development: {
            network_id: "*",
            port: 8545,
            host: "localhost",
            gasLimit: 4500000,
        }
    }
}
