const { ethers, utils } = require("ethers");
const fs = require('fs');

async function main() {
     //JavaScript environment variable that points to the location of the configuration file,  our configs mapp
    const configs = JSON.parse(fs.readFileSync(process.env.CONFIG).toString())
    //the path to the smart contract ABI (Application Binary Interface) file
    //ABI is a JSON file that defines the functions and events of the smart contract.
    const ABI = JSON.parse(fs.readFileSync('./artifacts/contracts/' + configs.contract_name + '.sol/' + configs.contract_name + '.json').toString())
    //An Ethereum provider is a connection to a node on the Ethereum blockchain, configs.provider specifies the address of the Ethereum nod
    const provider = new ethers.providers.JsonRpcProvider(configs.provider);
    //Ethereum wallet is an account on the Ethereum blockchain that is used to send and receive Ether (ETH) and interact with smart contract
    let wallet = new ethers.Wallet(configs.owner_key).connect(provider)
    //contract instance represents a smart contract on the Ethereum blockchain.
    const contract = new ethers.Contract(configs.contract_address, ABI.abi, wallet)

    // IPFS URI
    // bafkreie4dfdksfyam3kdywwzyj34cquu2rjdn6qtmcwenajfg2mui6mpvy
    // ipfs.nftstorage.link

   
    const result = await contract.mint(configs.contract_address, "test", "test", 66)
    //address player,
    //string memory name,
    //string memory avatar,
    //uint256 ranking

    
  
    

    console.log("Token ID minted:", result.events[0].args[2].toString())
    fs.writeFileSync(process.env.CONFIG, JSON.stringify(configs, null, 4))
    console.log("💸 Gas used:", receipt.gasUsed.toString())


    const transactionReceipt = await web3.eth.waitForReceipt(result.hash);
    const tokenId = transactionReceipt.logs[0].args.tokenId;
    console.log("Token ID:", tokenId);

    // Live example here: https://testnets.opensea.io/assets/sepolia/0xfbb4c4a1d5382fbf709d23b42c62c79a7fef3154/0
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
