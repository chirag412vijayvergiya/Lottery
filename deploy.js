require("dotenv").config();

const HDWalletProvider = require("@truffle/hdwallet-provider");
const { Web3 } = require("web3");
const { abi, bytecode } = require("./compile");
// const { describe } = require("mocha");

const provider = new HDWalletProvider(
  process.env.MNEMONIC, // Use mnemonic from .env file
  process.env.INFURA_API // Use Infura API from .env file
);

const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log("Attempting to deploy from account", accounts[0]);

  // const result = await new web3.eth.Contract(JSON.parse(interface))
  //   .deploy({ data: bytecode })
  //   .send({ gas: "1000000", from: accounts[0] });

  const result = await new web3.eth.Contract(abi)
    .deploy({ data: bytecode })
    .send({ gas: "1000000", from: accounts[0] });

  console.log("Contract ABI:", abi);
  console.log("Contract deployed to", result.options.address);
  provider.engine.stop();
};

deploy();
