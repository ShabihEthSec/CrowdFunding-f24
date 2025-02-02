# FundMe Smart Contract

![Solidity](https://img.shields.io/badge/Solidity-0.8.19-blue)
![License](https://img.shields.io/badge/License-MIT-green)

The **FundMe** smart contract is a decentralized funding application built on Ethereum. It allows users to fund the contract with Ether (ETH) and ensures that the amount sent meets a minimum threshold in USD. The contract uses Chainlink's decentralized price feeds to convert ETH to USD in real-time. Only the contract owner can withdraw the funds.

---

## Table of Contents
1. [Features](#features)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Contract Details](#contract-details)
5. [Testing](#testing)
6. [License](#license)

---

## Features

- **Minimum Funding Requirement**: Users must send at least $5 worth of ETH to fund the contract.
- **Real-Time Price Conversion**: Uses Chainlink's decentralized price feed to convert ETH to USD.
- **Owner-Only Withdrawals**: Only the contract owner can withdraw the funds.
- **Efficient Fund Management**: Tracks funders and their contributions.
- **Gas Optimization**: Includes a cheaper withdrawal function to reduce gas costs.

---

## Installation

### Prerequisites
- [Node.js](https://nodejs.org/) (v16 or higher)
- [Foundry](https://getfoundry.sh/) (for testing and deployment)
- [Git](https://git-scm.com/)

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/ShabihEthSec/CrowdFunding-f24.git
   cd CrowdFunding-f24
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up Foundry:
   ```bash
   forge install
   ```

4. Compile the contract:
   ```bash
   forge build
   ```

---

## Usage

### Deploying the Contract
1. Update the `DeployFundMe.s.sol` script with the correct Chainlink price feed address for your network.
2. Run the deployment script:
   ```bash
   forge script script/DeployFundMe.s.sol --broadcast --verify
   ```

### Funding the Contract
- Call the `fund()` function and send at least $5 worth of ETH.

### Withdrawing Funds
- Only the contract owner can call the `withdraw()` or `cheaperWithdraw()` function to withdraw the funds.

---

## Contract Details

### Key Functions

#### `fund()`
- Allows users to fund the contract with ETH.
- Requires the sent ETH to be worth at least $5 USD.

#### `withdraw()`
- Allows the owner to withdraw all funds from the contract.
- Resets the funders' balances.

#### `cheaperWithdraw()`
- A gas-optimized version of the `withdraw()` function.

#### Getter Functions
- `getAddressToAmountFunded(address fundingAddress)`: Returns the amount funded by a specific address.
- `getVersion()`: Returns the version of the Chainlink price feed.
- `getFunder(uint256 index)`: Returns the address of a funder at a specific index.
- `getOwner()`: Returns the address of the contract owner.
- `getPriceFeed()`: Returns the address of the Chainlink price feed.

---

## Testing

### Running Tests
The project includes comprehensive tests written in Solidity using Foundry. To run the tests:
```bash
forge test
```

### Test Coverage
To check test coverage:
```bash
forge coverage
```

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments
- Inspired by Patrick Collins' Solidity tutorials.
- Uses Chainlink's decentralized price feeds for real-time ETH/USD conversion.

---

## Contributing
Contributions are welcome! Please open an issue or submit a pull request.

---

## Contact
For questions or feedback, reach out to:
- **Mohd Shabihul Hasan Khan**  
- **Email**: mohdshabihul@gmail.com  
- **GitHub**: [your-username](https://github.com/your-username)  

---
