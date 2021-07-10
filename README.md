This is a boilerplate for deploying Safemoon token (note: I have changed the name to 'Francis_Ldn') to the Binance Smart Chain testnet.
Download the file and install the dependencies below.
# Dependencies 
run this in the main folder directory:
`npm install -g truffle`
`npm install touch-for-windows`
`npm install @truffle/hdwallet-provider`  
`npm install dotenv`

# Initialize:
In the main folder --> enter the following command:
`npm init -y `
`truffle init`

# Create .env file to store private key:
In the main folder --> enter the following command:
`touch .env`
This will create .env file in the main folder;
In the .env file, enter your privateKeys ='YOUR_PRIVATE_KEY';
Your private key will be used in the truffle-config.js to deploy the contract

# Deploy to bscTestnet:
Make sure you have sufficient BNB in your bscTestnet account. If not, you can get some fake BNB from here:
https://testnet.binance.org/faucet-smart
And then, in the main folder, run the following command:
`truffle migrate --reset --network bscTestnet`

# Verify code on bscTestnet scan:
create an account to receive BSC API key:
https://bscscan.com/myapikey
In the .env file, enter your API_KEY = 'YOUR_API_KEY';
Your API Key will be used to verify the code for the smart contract which you have deployed;
Dependences:
`npm install -D truffle-plugin-verify`
This will install truffle-plugin-verify package
Then you can verify your code on bscTestnet by running the code below:
`truffle run verify FNHH@{YOUR_CONTRACT_ADDRESS} --network bscTestnet`



