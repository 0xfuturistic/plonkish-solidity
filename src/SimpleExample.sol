// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Circuit.sol";
import "./MockProver.sol";

contract MyCircuit is Circuit {
    Value a;
    Value b;

    constructor(Value a_, Value b_) {
        a = a_;
        b = b_;
    }
}

contract SimpleExample {
    uint32 constant K = 5;

    function main() public {
        Circuit circuit = new MyCircuit(Value.wrap(2), Value.wrap(4));

        Column memory instance = Column({values: new uint[](0)});

        MockProver.run(K, circuit, instance);

        assert(MockProver.verify());
    }
}
