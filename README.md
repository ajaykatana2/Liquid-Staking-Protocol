# Liquid Staking Protocol for Core Chain

## Project Title
CoreLiquid: A Liquid Staking Protocol for Core Chain

## Project Description
CoreLiquid is a liquid staking solution built specifically for Core Chain, allowing users to stake their CORE tokens while maintaining liquidity through a tradable stCORE token. This protocol bridges the gap between earning staking rewards and maintaining access to capital, enabling users to participate in other DeFi activities while still earning staking yields.

The protocol works by accepting CORE token deposits and minting proportional stCORE tokens that represent the user's staked position. As staking rewards accumulate, the exchange rate between CORE and stCORE improves, making each stCORE token more valuable over time. This approach distributes rewards fairly to all stakers without requiring frequent on-chain transactions.

## Project Vision
Our vision is to become the foundational liquidity layer for Core Chain, unlocking billions in capital efficiency while strengthening the network through greater staking participation. We aim to create a sustainable staking ecosystem where:

1. Users can earn passive income without sacrificing liquidity
2. The overall security of the Core Chain network increases through higher staking rates
3. New DeFi use cases emerge that leverage the stCORE token as collateral
4. Protocol revenue creates a sustainable framework for continued development

By creating this critical infrastructure, we enable broader participation in Core Chain's ecosystem and help fulfill its promise as a high-performance, low-fee blockchain solution.

## Key Features

### Core Features (Implemented)
- **Tokenized Stake Representation**: Receive stCORE tokens representing your staked position
- **Automatic Reward Distribution**: Exchange rate mechanism distributes rewards without additional claims
- **Unstaking Functionality**: Convert stCORE back to CORE at the current exchange rate
- **Minimal Fee Structure**: Small protocol fee (0.5%) to sustain development

### Security Features
- **Reentrancy Protection**: Prevents exploit vectors in stake/unstake functions
- **Proper Access Controls**: Owner-restricted sensitive functions
- **Minimum Stake Requirements**: Prevents dust attacks and ensures economic viability

## Future Scope

### Short-term Roadmap
1. **Protocol Integrations**
   - Integrate with DEXs to provide stCORE/CORE liquidity pools
   - Partner with lending protocols to enable stCORE as collateral
   - Create yield farming opportunities using stCORE

2. **Enhanced Security**
   - Complete comprehensive security audits
   - Implement time-locked upgrades
   - Add emergency pause functionality

3. **User Experience**
   - Develop an intuitive frontend interface
   - Create detailed analytics dashboard
   - Add delegation capabilities for stakers

### Long-term Vision
1. **Governance System**
   - Transition to a DAO structure for protocol governance
   - Allow stCORE holders to vote on parameter changes and protocol upgrades
   - Implement fee distribution to active governance participants

2. **Multi-chain Expansion**
   - Extend the protocol to other EVM-compatible chains
   - Create bridged versions of stCORE for cross-chain liquidity
   - Build a unified staking interface across multiple chains

3. **Advanced Financial Products**
   - Develop fixed-term staking with enhanced yields
   - Create stCORE derivatives for hedging and leveraging
   - Implement yield-boosting strategies for stakers

---

## Technical Implementation
The protocol is implemented as a solidity smart contract on Core Chain, utilizing the ERC20 standard for the stCORE token. The contract manages the exchange rate between CORE and stCORE, handling deposits, withdrawals, and reward distribution.

### Key Smart Contract Components
- `stake()`: Accepts CORE deposits and mints stCORE tokens
- `unstake()`: Burns stCORE tokens and returns the corresponding CORE tokens
- `distributeRewards()`: Updates the exchange rate when new rewards are added

### Getting Started
1. Clone this repository
2. Install dependencies: `npm install`
3. Compile contracts: `npx hardhat compile`
4. Run tests: `npx hardhat test`
5. Deploy: `npx hardhat run scripts/deploy.js --network core`

## License
This project is licensed under the MIT License - see the LICENSE file for details.

Contract Address - 0xD2d4fd308B7eb7cEeA5774450ED5cC73501681e6

<img width="1408" alt="image" src="https://github.com/user-attachments/assets/b4d1784a-c051-401b-a4c8-09428dba068a" />


