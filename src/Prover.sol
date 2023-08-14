// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Circuit, ConstraintSystem, Column} from "./Circuit.sol";
import {ProverLib} from "./lib/ProverLib.sol";

struct Region {
    uint32 start;
    uint32 end;
}

type CellValue is uint32;

enum InstanceValue {
    Assigned,
    Padding
}

struct Range {
    uint32 start;
    uint32 end;
}

abstract contract Prover {
    using ProverLib for *;

    uint32 k;
    uint32 n;
    ConstraintSystem cs;

    /// The regions in the circuit.
    Region[] regions;

    /// The current region being assigned to. Will be `None` after the circuit has been
    /// synthesized.
    Region current_region;

    // The fixed cells in the circuit, arranged as [column][row].
    CellValue[][] fixed_cells;
    // The advice cells in the circuit, arranged as [column][row].
    CellValue[][] advice_cells;
    // The instance cells in the circuit, arranged as [column][row].
    InstanceValue[][] instance_cells;

    bool[][] selectors;

    // TODO: permutation: permutation::keygen::Assembly,

    // A range of available rows for assignment and copies.
    Range usable_rows;

    /// @dev Runs a synthetic keygen-and-prove operation on the given circuit, collecting data
    /// about the constraints and their assignments.
    function run(uint32 K, Circuit circuit, Column memory instance) public virtual;

    /// @dev Returns true if this Prover is satisfied, or a revert indicating
    ///      the reasons that the circuit is not satisfied.
    function verify() public virtual returns (bool);

    /// @dev Panics if the circuit being checked by this Prover is not satisfied.
    ///
    /// Any verification failures will be pretty-printed to stderr before the function
    /// panics.
    ///
    /// Apart from the stderr output, this method is equivalent to:
    /// ```ignore
    /// assert_eq!(prover.verify(), Ok(()));
    /// ```
    function assert_satisfied() public {
        require(verify(), "Prover: circuit is not satisfied");
    }
}

contract ProverImpl is Prover {
    function run(uint32 K, Circuit circuit, Column memory instance) public override {
        // circuit.synthesize(meta,...);
    }

    function verify() public override returns (bool) {
        assembly {
            // Check that within each region, all cells used in instantiated gates have been assigned to.

            // Check that all gates are satisfied for all rows.

            // Check that all lookups exist in their respective tables.

            // Check that permutations preserve the original values of the cells.
        }

        return true;
    }
}
