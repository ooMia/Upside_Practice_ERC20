// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import {IERC20, IERC2612} from "./Template.sol";

interface _IERC20 is IERC20 {
    function pause() external;
}

interface _IERC2612 is IERC2612 {
    function _toTypedDataHash(
        bytes32 structHash
    ) external view returns (bytes32);
}

abstract contract _ERC20 is _IERC20 {
    // ===== ERC20 metadata =====
    string public name;
    string public symbol;
    uint8 public constant decimals = 18;

    // ===== ERC20 state =====
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;
    uint public constant totalSupply = 100 ether;

    bool health = true;
    address private deployer;

    constructor(string memory _name, string memory _symbol) {
        deployer = msg.sender;
        name = _name;
        symbol = _symbol;
        balances[deployer] = totalSupply;
    }

    modifier isHealthy() {
        require(health);
        _;
    }

    // ===== ERC20 Implements =====

    function transfer(
        address to,
        uint256 amount
    ) external virtual override isHealthy returns (bool) {
        bool res = balances[msg.sender] >= amount;
        if (res) {
            balances[msg.sender] -= amount;
            balances[to] += amount;
        }
        return res;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external virtual override isHealthy returns (bool) {
        bool res = (balances[from] >= amount) &&
            (allowances[from][msg.sender] >= amount);
        if (res) {
            balances[from] -= amount;
            balances[to] += amount;
            allowances[from][msg.sender] -= amount;
        }
        return res;
    }

    function approve(
        address spender,
        uint256 amount
    ) external virtual override isHealthy returns (bool) {
        bool res = (balances[msg.sender] >= amount);
        if (res) {
            allowances[msg.sender][spender] += amount;
        }
        return res;
    }

    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {
        return allowances[owner][spender];
    }

    function balanceOf(
        address account
    ) external view override returns (uint256) {
        return balances[account];
    }

    // ===== ERC20 extension =====
    function pause() external override {
        require(msg.sender == deployer);
        health = !health;
    }
}
