// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console2} from "forge-std/console2.sol";

struct Constraint {
    string name;
    string expression;
    string queries;
}

struct Gate {
    string name;
    Constraint[] constraints;
}

/// @dev A struct for collecting and displaying the gates within a circuit.
///
/// # Examples
///
/// ```
/// use ff::Field;
/// use halo2_proofs::{
///     circuit::{Layouter, SimpleFloorPlanner},
///     dev::CircuitGates,
///     plonk::{Circuit, ConstraintSystem, Error},
///     poly::Rotation,
/// };
/// use pasta_curves::pallas;
///
/// #[derive(Copy, Clone)]
/// struct MyConfig {}
///
/// #[derive(Clone, Default)]
/// struct MyCircuit {}
///
/// impl<F: Field> Circuit<F> for MyCircuit {
///     type Config = MyConfig;
///     type FloorPlanner = SimpleFloorPlanner;
///
///     fn without_witnesses(&self) -> Self {
///         Self::default()
///     }
///
///     fn configure(meta: &mut ConstraintSystem<F>) -> MyConfig {
///         let a = meta.advice_column();
///         let b = meta.advice_column();
///         let c = meta.advice_column();
///         let s = meta.selector();
///
///         meta.create_gate("R1CS constraint", |meta| {
///             let a = meta.query_advice(a, Rotation::cur());
///             let b = meta.query_advice(b, Rotation::cur());
///             let c = meta.query_advice(c, Rotation::cur());
///             let s = meta.query_selector(s);
///
///             Some(("R1CS", s * (a * b - c)))
///         });
///
///         // We aren't using this circuit for anything in this example.
///         MyConfig {}
///     }
///
///     fn synthesize(&self, _: MyConfig, _: impl Layouter<F>) -> Result<(), Error> {
///         // Gates are known at configure time; it doesn't matter how we use them.
///         Ok(())
///     }
/// }
///
/// let gates = CircuitGates::collect::<pallas::Base, MyCircuit>();
/// assert_eq!(
///     format!("{}", gates),
///     r#####"R1CS constraint:
/// - R1CS:
///   S0 * (A0@0 * A1@0 - A2@0)
/// Total gates: 1
/// Total custom constraint polynomials: 1
/// Total negations: 1
/// Total additions: 1
/// Total multiplications: 2
/// "#####,
/// );
/// ```
abstract contract CircuitGates {
    Gate[] gates;
    uint256 total_negations;
    uint256 total_additions;
    uint256 total_multiplications;

    /// @dev Collects the gates from within the circuit.
    function collect() internal virtual;

    /// @dev Prints the queries in this circuit to a CSV grid.
    function queries_to_csv() internal virtual returns (string memory);

    /*
    impl fmt::Display for CircuitGates {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
        for gate in &self.gates {
            writeln!(f, "{}:", gate.name)?;
            for constraint in &gate.constraints {
                if constraint.name.is_empty() {
                    writeln!(f, "- {}", constraint.expression)?;
                } else {
                    writeln!(f, "- {}:", constraint.name)?;
                    writeln!(f, "  {}", constraint.expression)?;
                }
            }
        }
        writeln!(f, "Total gates: {}", self.gates.len())?;
        writeln!(
            f,
            "Total custom constraint polynomials: {}",
            self.gates
                .iter()
                .map(|gate| gate.constraints.len())
                .sum::<usize>()
        )?;
        writeln!(f, "Total negations: {}", self.total_negations)?;
        writeln!(f, "Total additions: {}", self.total_additions)?;
        writeln!(f, "Total multiplications: {}", self.total_multiplications)
    }
    }
    */
    function display() public view virtual returns (string memory) {
        for (uint256 i = 0; i < gates.length; i++) {
            console2.log(gates[i].name);
            for (uint256 j = 0; j < gates[i].constraints.length; j++) {
                console2.log(gates[i].constraints[j].name);
                console2.log(gates[i].constraints[j].expression);
            }
        }

        console2.log("Total gates: %s", gates.length);
        //console2.log("Total custom constraint polynomials: %s", gates.length);
        console2.log("Total negations: %s", total_negations);
        console2.log("Total additions: %s", total_additions);
        console2.log("Total multiplications: %s", total_multiplications);
    }
}
