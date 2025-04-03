require("@matterlabs/hardhat-zksync-solc");
require('dotenv').config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  zksolc: {
    version: "1.3.9",
    compilerSource: "binary",
    settings: {
      optimizer: {
        enabled: true,
      },
    },
  },
  defaultNetwork:'sepolia',
  networks: {
    hardhat:{},
    sepolia: {
      url:'https://rpc.ankr.com/eth_sepolia',
      accounts:[`0x${process.env.PRIVATE_KEY}`]
    }
  },
  paths: {
    artifacts: "./artifacts-zk",
    cache: "./cache-zk",
    sources: "./contracts",
    tests: "./test",
  },
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
