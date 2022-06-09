var order = artifacts.require("./Order.sol");
const randomAddr = [
]
module.exports = function (deployer) {
    deployer.deploy(order, randomAddr);
}