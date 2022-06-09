// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16;

contract Order {
    struct Person {
        uint32 count;
        address addr;
    }

    mapping(uint256 => Person) public members;
    address public chairperson;
    uint256 randNonce;
    uint256 members_cnt;
    uint256 max_cnt;
    uint256[] out;

    constructor(address[] memory persons) public {
        randNonce = 0;
        chairperson = msg.sender;
        members_cnt = persons.length;
        max_cnt = 0;
        for (uint32 i = 0; i < members_cnt; i++) {
            members[i] = Person({count: 0, addr: persons[i]});
        }
    }

    function getMembersCnt() public view returns (uint256) {
        return members_cnt;
    }

    function randomIndex() internal returns (uint256) {
        uint256 random = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))
        ) % members_cnt;
        randNonce++;
        return random;
    }

    function getAPerson() public returns (uint256) {
        require(chairperson == msg.sender);
        return getOut();
    }

    function getNPerson(uint256 cnt) public returns (uint256[] memory) {
        require(chairperson == msg.sender);
        while (cnt > 0) {
            out.push(getOut());
            cnt--;
        }
        return out;
    }

    function getOut() internal returns (uint256) {
        uint256 i = randomIndex();
        uint256 t = i;
        while (members[i].count == max_cnt) {
            i = (i + 1) % members_cnt;
            if (t == i) {
                max_cnt++;
                break;
            }
        }
        chairperson = members[i].addr;
        members[i].count++;
        return i;
    }
}
