// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";

interface _IERC20 is IERC20 {
    function pause() external;

    function _toTypedDataHash(
        bytes32 structHash
    ) external view returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
}

contract ERC20 is _IERC20 {
    string public name;
    string public symbol;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {
        revert("Not implemented");
    }

    function approve(
        address spender,
        uint256 amount
    ) external override returns (bool) {
        revert("Not implemented");
    }

    function balanceOf(
        address account
    ) external view override returns (uint256) {
        revert("Not implemented");
    }

    function decimals() external view override returns (uint8) {
        revert("Not implemented");
    }

    function totalSupply() external view override returns (uint256) {
        revert("Not implemented");
    }

    function transfer(
        address to,
        uint256 amount
    ) external override returns (bool) {
        revert("Not implemented");
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external override returns (bool) {
        revert("Not implemented");
    }

    function pause() external override {
        revert("Not implemented");
    }

    function _toTypedDataHash(
        bytes32 structHash
    ) external view override returns (bytes32) {
        revert("Not implemented");
    }

    function nonces(address owner) external view override returns (uint256) {
        revert("Not implemented");
    }

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external override {
        revert("Not implemented");
    }
}
