const path = require("path");
const fs = require("fs");
const solc = require("solc");

const lotteryPath = path.resolve(__dirname, "contracts", "Lottery.sol");
const source = fs.readFileSync(lotteryPath, "utf8");

// Prepare input in JSON format for the compiler
const input = {
  language: "Solidity",
  sources: {
    "Lottery.sol": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["abi", "evm.bytecode.object"],
      },
    },
  },
};

// Compile the contract
const output = JSON.parse(solc.compile(JSON.stringify(input)));

// Access ABI and bytecode
const abi = output.contracts["Lottery.sol"].Lottery.abi;
const bytecode = output.contracts["Lottery.sol"].Lottery.evm.bytecode.object;

// module.exports = solc.compile(source, 1).contracts[":Lottery"];

module.exports = { abi, bytecode };
