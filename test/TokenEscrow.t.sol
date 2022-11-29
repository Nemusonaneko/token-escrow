//SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/TokenEscrow.sol";
import "./LlamaToken.sol";

contract TokenEscrowTest is Test {
    TokenEscrow public escrow;
    LlamaToken public llamaToken;

    address public immutable alice = address(1);
    address public immutable bob = address(2);

    function setUp() external {
        escrow = new TokenEscrow();
        llamaToken = new LlamaToken();
        llamaToken.mint(alice, 1000000 * 1e18);
    }

    function testCreate() external {
        vm.startPrank(alice);
        llamaToken.approve(address(escrow), 1000 * 1e18);
        escrow.create(address(llamaToken), bob, 1000 * 1e18, 50000);
        vm.stopPrank();
    }

    function testRedeem() external {
        vm.startPrank(alice);
        llamaToken.approve(address(escrow), 1000 * 1e18);
        escrow.create(address(llamaToken), bob, 1000 * 1e18, 50000);
        vm.stopPrank();
        vm.warp(100000);
        escrow.redeem(address(llamaToken), alice, bob, 1000 * 1e18, 50000);
    }

    function testRevoke() external {
        vm.startPrank(alice);
        llamaToken.approve(address(escrow), 1000 * 1e18);
        escrow.create(address(llamaToken), bob, 1000 * 1e18, 50000);
        escrow.revoke(address(llamaToken), bob, 1000 * 1e18, 50000);
        vm.stopPrank();
    }
}
