// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Gate} from "./Gates.sol";

type Value is uint64;

struct Column {
    uint256[] values;
}

struct ColumnFixed {
    Column column;
}

struct ColumnAdvice {
    Column column;
}

struct ColumnInstance {
    Column column;
}

struct Selector {
    Column column;
}

struct MyConfig {
    ColumnAdvice a;
    ColumnAdvice b;
    ColumnAdvice c;
    Selector s;
}

type PermutationArgument is bytes32;

type LookupArgument is bytes32;

/// This is a description of the circuit environment, such as the gate, column and
/// permutation arrangements.
abstract contract ConstraintSystem {
    uint256 num_fixed_columns;
    uint256 num_advice_columns;
    uint256 num_instance_columns;
    uint256 num_selectors;

    /// This is a cached vector that maps virtual selectors to the concrete
    /// fixed column that they were compressed into. This is just used by dev
    /// tooling right now.
    ColumnFixed[] selector_map;

    Gate[] gates;
    ColumnAdvice[] advice_queries;
    // Contains an integer for each advice column
    // identifying how many distinct queries it has
    // so far; should be same length as num_advice_columns.
    uint256[] num_advice_queries;

    ColumnInstance[] instance_queries;
    ColumnFixed[] fixed_queries;

    // Permutation argument for performing equality constraints
    PermutationArgument permutation;

    // Vector of lookup arguments, where each corresponds to a sequence of
    // input expressions and a sequence of table expressions involved in the lookup.
    LookupArgument[] lookups;

    // Vector of fixed columns, which can be used to store constant values
    // that are copied into advice columns.
    ColumnFixed[] constants;

    uint256 minimum_degree;

    function advice_column() public view virtual returns (ColumnAdvice memory);

    function selector() public view virtual returns (Selector memory);

    function create_gate(string memory name, function (ConstraintSystem) external) public virtual;
}

contract Circuit {
    MyConfig config;

    function configure(ConstraintSystem meta) public view returns (MyConfig memory) {
        ColumnAdvice memory a = meta.advice_column();
        ColumnAdvice memory b = meta.advice_column();
        ColumnAdvice memory c = meta.advice_column();
        Selector memory s = meta.selector();

        //meta.create_gate("R1CS constraint", this.create_R1CS_constraint);

        return MyConfig({a: a, b: b, c: c, s: s});
    }

    function synthesize(ConstraintSystem meta) public view {
        //FloorPlanner planner = new FloorPlanner();
        //planner.place(config);
    }
}
