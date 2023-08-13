// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

abstract contract ConstraintSystem {
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
