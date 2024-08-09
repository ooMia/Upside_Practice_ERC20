// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./IERC2612.sol";

interface _IERC20 is IERC20 {
    function pause() external;
}

contract ERC20 is _IERC20, _IERC2612 {
    // ===== ERC20 metadata =====
    string public name;
    string public symbol;
    uint8 public constant decimals = 18;

    // ===== ERC20 state =====
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;
    uint public constant totalSupply = 100 ether;

    address private deployer;
    bool private health = true;

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

    function transfer(
        address to,
        uint256 amount
    ) external override isHealthy returns (bool) {
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
    ) external override isHealthy returns (bool) {
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
    ) external override returns (bool) {
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

    function pause() external override {
        require(msg.sender == deployer);
        health = !health;
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
    ) external override isHealthy {}

    function DOMAIN_SEPARATOR() external view override returns (bytes32) {
        revert("Not implemented");
    }
}
