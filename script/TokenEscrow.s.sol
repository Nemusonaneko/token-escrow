//SPDX-License-Identifier: AGPL-3.0-only

pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../src/TokenEscrow.sol";

contract TokenEscrowScript is Script {
    function run() external {
        uint256 deployer = vm.envUint("PK");
        vm.startBroadcast(deployer);
        TokenEscrow escrow = new TokenEscrow{salt: bytes32("nemu")}();
        vm.stopBroadcast();
    }
}
