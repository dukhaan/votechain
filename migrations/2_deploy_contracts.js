const HelloWorld = artifacts.require("HelloWorld");
const Election = artifacts.require("Election");

module.exports = function (deployer) {
  deployer.deploy(HelloWorld);
  deployer.deploy(Election);
};