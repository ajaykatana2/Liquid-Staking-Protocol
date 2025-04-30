// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title LiquidStaking
 * @dev A simplified liquid staking protocol for Core Chain
 * This contract allows users to stake CORE tokens and receive liquid stCORE tokens
 * that represent their staked position and can be used throughout DeFi
 */
contract LiquidStaking is ERC20, Ownable, ReentrancyGuard {
    
    // Events
    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardsDistributed(uint256 amount);
    
    // Constants
    uint256 public constant MINIMUM_STAKE = 0.1 ether; // 0.1 CORE minimum stake
    
    // Protocol fees (0.5%)
    uint256 public protocolFee = 50; // Out of 10000 (basis points)
    uint256 public totalStakedAmount;
    uint256 public accumulatedFees;
    
    // Exchange rate tracking (grows with rewards)
    uint256 private exchangeRateNumerator = 1000000; // 6 decimals of precision
    uint256 private exchangeRateDenominator = 1000000; // Initial exchange rate 1:1
    
    /**
     * @dev Constructor that sets the token name and symbol
     */
    constructor() ERC20("Staked CORE", "stCORE") Ownable(msg.sender) {}
    
    /**
     * @dev Allows users to stake CORE tokens and receive stCORE tokens
     * The exchange rate determines how many stCORE tokens are minted
     */
    function stake() external payable nonReentrant {
        require(msg.value >= MINIMUM_STAKE, "Stake amount too low");
        
        // Calculate protocol fee
        uint256 fee = (msg.value * protocolFee) / 10000;
        uint256 stakeAmount = msg.value - fee;
        
        // Track fees
        accumulatedFees += fee;
        totalStakedAmount += stakeAmount;
        
        // Calculate stCORE tokens to mint based on current exchange rate
        uint256 tokensToMint = (stakeAmount * exchangeRateDenominator) / exchangeRateNumerator;
        
        // Mint stCORE tokens to the user
        _mint(msg.sender, tokensToMint);
        
        emit Staked(msg.sender, msg.value);
    }
    
    /**
     * @dev Allows users to unstake their CORE tokens by burning stCORE tokens
     * @param stCoreAmount The amount of stCORE tokens to burn
     */
    function unstake(uint256 stCoreAmount) external nonReentrant {
        require(stCoreAmount > 0, "Cannot unstake zero tokens");
        require(balanceOf(msg.sender) >= stCoreAmount, "Insufficient stCORE balance");
        
        // Calculate CORE tokens to return based on current exchange rate
        uint256 coreToReturn = (stCoreAmount * exchangeRateNumerator) / exchangeRateDenominator;
        require(coreToReturn <= totalStakedAmount, "Insufficient liquidity in contract");
        
        // Burn stCORE tokens
        _burn(msg.sender, stCoreAmount);
        
        // Update total staked amount
        totalStakedAmount -= coreToReturn;
        
        // Send CORE tokens back to the user
        (bool success, ) = payable(msg.sender).call{value: coreToReturn}("");
        require(success, "Transfer failed");
        
        emit Unstaked(msg.sender, coreToReturn);
    }
    
    /**
     * @dev Distributes staking rewards to the protocol (only callable by contract owner)
     * This function updates the exchange rate based on new rewards, making all stCORE tokens
     * more valuable without having to distribute to individual users
     */
    function distributeRewards() external payable onlyOwner {
        require(msg.value > 0, "Must distribute positive rewards");
        require(totalStakedAmount > 0, "No tokens staked yet");
        
        // Update the exchange rate
        exchangeRateNumerator = (exchangeRateNumerator * (totalStakedAmount + msg.value)) / totalStakedAmount;
        
        // Update total staked amount with rewards
        totalStakedAmount += msg.value;
        
        emit RewardsDistributed(msg.value);
    }
    
    /**
     * @dev Allows the contract to receive CORE tokens directly
     */
    receive() external payable {
        // Accept direct transfers (can be used for adding rewards)
    }
}
