require("dotenv").config();
const { ethers } = require("hardhat");

async function main() {
    const provider = new ethers.JsonRpcProvider("https://rpc.ankr.com/eth_sepolia");
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
    
    const balance = await provider.getBalance(wallet.address);
    console.log(`Balance: ${ethers.formatEther(balance)} ETH`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
