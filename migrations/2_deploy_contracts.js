const Fnhh = artifacts.require('Fnhh.sol');

module.exports = function (deployer, network) {
  if(network === 'bscTestnet') {
    deployer.deploy(Fnhh);
  } else {
    deployer.deploy(Fnhh);
  }
};