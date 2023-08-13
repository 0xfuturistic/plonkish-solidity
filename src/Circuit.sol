// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

struct Constraint {
    function (bytes memory) external view returns (uint256) characteristic;
}

struct Circuit {
    Constraint[] constraints;
    uint256 epsilon;
}

library CircuitLib {
    function evaluate(Constraint memory self, bytes memory input) internal view returns (uint256) {
        return self.characteristic(input);
    }

    function prove(Circuit memory self, bytes memory input) internal view {
        for (uint256 i = 0; i < self.constraints.length; i++) {
            assert(evaluate(self.constraints[i], input) < self.epsilon);
        }
    }

    function add(Circuit storage self, Constraint memory constraint) internal {
        self.constraints.push(constraint);
    }

    function add(Circuit storage self, function (bytes memory) external view returns (uint) characteristic) internal {
        self.constraints.push(Constraint(characteristic));
    }
}

using CircuitLib for Circuit global;
