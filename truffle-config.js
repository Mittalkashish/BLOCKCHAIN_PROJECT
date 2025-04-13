module.exports = {
    networks: {
      development: {
        host: "127.0.0.1",    // Localhost
        port: 7545,           // Ganache default port
        network_id: "*",      // Match any network id
        gas: 6721975,         // Gas limit
        gasPrice: 20000000000 // 20 Gwei (default gas price)
      }
    },
    compilers: {
      solc: {
        version: "0.8.13",      // Replace with the Solidity version you are using
        settings: {
          optimizer: {
            enabled: true,    // Enable optimization
            runs: 200         // Optimize for how many times you intend to run the code
          }
        }
      }
    }
  };