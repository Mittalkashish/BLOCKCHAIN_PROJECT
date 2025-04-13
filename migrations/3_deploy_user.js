const fs = require("fs");
const path = require("path");

const User = artifacts.require("User");
const Base = artifacts.require("Base");
const Govtorg = artifacts.require("Govtorg");

// ===Rajes=== automating the adderesses to address.json

module.exports = async function (deployer, network, accounts) {
  // Deploy the User contract
  await deployer.deploy(User);
  const userInstance = await User.deployed();

  // Get already deployed Base and Govtorg contracts
  const baseInstance = await Base.deployed();
  const govtInstance = await Govtorg.deployed();

  // Prepare address object
  const addresses = {
    Base: baseInstance.address,
    Govtorg: govtInstance.address,
    User: userInstance.address,
  };

  // Write to JSON file (adjust path as needed)
  const outputPath = path.join(__dirname, "..", "src", "Addresses.json");

  fs.writeFileSync(outputPath, JSON.stringify(addresses, null, 2));

  console.log("✅ Contract addresses saved to src/Addresses.json");
};
