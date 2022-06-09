// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16;

import "truffle/DeployedAddresses.sol";
import "../contracts/Order.sol";

contract TestOrder {
    Order order = Order(DeployedAddresses.Order());

    function testGetAPerson() public {
        uint256 out = order.getAPerson();
        if (out >= 0 && out < order.getMembersCnt())
            revert("Fail to order");
    }

    function testGetNPerson() public {
        uint256 cnt = 100 % order.getMembersCnt();
        uint256[] memory out = order.getNPerson(cnt);
        for (uint32 i = 0; i < out.length; i++) {
            if (out[i] >= 0 && out[i] < order.getMembersCnt())
                revert("Fail to order");
        }
    }
}
