const Base = artifacts.require("Base");
const Govtorg = artifacts.require("Govtorg");

module.exports = function (deployer) {
  // Deploy Base first
  deployer.deploy(Base).then(() => {
    // Deploy Govtorg after Base
    return deployer.deploy(Govtorg);
  });
};
