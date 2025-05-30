# Tokenized Disaster Management Quantum Prediction System

A comprehensive blockchain-based disaster management system that leverages quantum prediction algorithms to forecast, coordinate, and optimize disaster response efforts.

## Overview

This system consists of five interconnected smart contracts built on the Stacks blockchain using Clarity:

1. **Agency Verification Contract** - Validates quantum prediction systems and authorized agencies
2. **Prediction Protocol Contract** - Manages quantum disaster forecasting
3. **Response Coordination Contract** - Organizes quantum-informed disaster responses
4. **Resource Optimization Contract** - Allocates disaster response resources efficiently
5. **Outcome Measurement Contract** - Evaluates quantum prediction effectiveness

## Features

### 🔐 Agency Verification
- Verify and manage authorized disaster prediction agencies
- Track quantum capability scores and verification status
- Maintain agency credentials and performance metrics

### 🔮 Quantum Predictions
- Submit disaster predictions with quantum confidence scores
- Track probability, severity, and location data
- Calculate risk scores based on quantum algorithms

### 🚨 Response Coordination
- Create and manage disaster response plans
- Register and coordinate response teams
- Activate emergency protocols based on predictions

### 📊 Resource Optimization
- Manage resource pools (personnel, equipment, supplies)
- Allocate resources efficiently based on prediction data
- Track costs and availability in real-time

### 📈 Outcome Measurement
- Record actual disaster outcomes vs predictions
- Calculate prediction accuracy and response effectiveness
- Track agency performance metrics over time

## Smart Contract Architecture

```
┌─────────────────────┐    ┌─────────────────────┐
│ Agency Verification │    │ Prediction Protocol │
│     Contract        │    │      Contract       │
└─────────┬───────────┘    └─────────┬───────────┘
          │                          │
          │         ┌────────────────┴───────────────┐
          │         │                                │
          │         ▼                                ▼
┌─────────▼───────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│ Response Coordination│    │ Resource Optimization│    │ Outcome Measurement │
│      Contract        │    │      Contract        │    │      Contract       │
└──────────────────────┘    └──────────────────────┘    └─────────────────────┘
```

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarinet CLI tool
- Node.js and npm for testing

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd quantum-disaster-management
```

2. Install dependencies:
```bash
npm install
```

3. Run tests:
```bash
npm test
```

### Deployment

Deploy contracts to Stacks testnet:
```bash
clarinet deploy --testnet
```

## Usage Examples

### 1. Verify an Agency
```clarity
(contract-call? .agency-verification verify-agency 
  'SP1HTBVD3JG9C05J7HBJTHGR0GGW7KX975CN0QKK6
  "NOAA Weather Service"
  u95)
```

### 2. Submit a Prediction
```clarity
(contract-call? .prediction-protocol submit-prediction
  "hurricane"
  "Florida Coast"
  u75
  u8
  u92)
```

### 3. Create Response Plan
```clarity
(contract-call? .response-coordination create-response-plan
  u1
  "evacuation"
  u5
  u1000)
```

### 4. Allocate Resources
```clarity
(contract-call? .resource-optimization allocate-resources
  u1
  "emergency-personnel"
  u50)
```

### 5. Record Outcome
```clarity
(contract-call? .outcome-measurement record-outcome
  u1
  true
  (some u7)
  u88
  "Hurricane made landfall as predicted")
```

## Contract Functions

### Agency Verification
- `verify-agency` - Verify a new agency
- `revoke-agency` - Revoke agency verification
- `is-agency-verified` - Check verification status
- `update-quantum-score` - Update agency capabilities

### Prediction Protocol
- `submit-prediction` - Submit new disaster prediction
- `update-prediction-status` - Update prediction status
- `calculate-risk-score` - Calculate risk assessment
- `get-prediction` - Retrieve prediction data

### Response Coordination
- `register-team` - Register response team
- `create-response-plan` - Create response strategy
- `activate-response` - Activate emergency response
- `update-team-availability` - Update team status

### Resource Optimization
- `initialize-resource-pool` - Set up resource pools
- `allocate-resources` - Allocate resources to responses
- `release-resources` - Release allocated resources
- `get-available-resources` - Check resource availability

### Outcome Measurement
- `record-outcome` - Record disaster outcomes
- `update-agency-performance` - Update performance metrics
- `calculate-prediction-accuracy` - Calculate accuracy scores
- `get-system-accuracy` - Get overall system performance

## Testing

The system includes comprehensive Vitest unit tests for all contract functions:

```bash
npm test
```

Tests cover:
- Contract deployment and initialization
- Function parameter validation
- Access control and permissions
- Data integrity and state management
- Error handling and edge cases

## Security Considerations

- **Access Control**: Only verified agencies can submit predictions
- **Data Validation**: All inputs are validated for correctness
- **Resource Protection**: Prevents over-allocation of resources
- **Audit Trail**: Complete transaction history for accountability

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
