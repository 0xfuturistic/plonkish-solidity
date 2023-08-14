// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract RegionLayouter {
    /// @dev Enables a selector at the given offset.
    function enable_selector(uint256 selector) public virtual;

    /// @dev Assign an advice column value (witness)
    function assign_advice(uint256 selector, uint256 advice) public virtual;

    /// @dev Assigns a constant value to the column `advice` at `offset` within this region.
    ///
    /// The constant value will be assigned to a cell within one of the fixed columns
    /// configured via `ConstraintSystem::enable_constant`.
    ///
    /// Returns the advice cell that has been equality-constrained to the constant.
    function assign_advice_from_constant(uint256 selector, uint256 advice, uint256 constant_) public virtual;

    /// @dev Assign the value of the instance column's cell at absolute location
    /// `row` to the column `advice` at `offset` within this region.
    ///
    /// Returns the advice cell that has been equality-constrained to the
    /// instance cell, and its value if known.
    function assign_advice_from_instance(uint256 selector, uint256 advice, address instance) public virtual;

    /// @dev Returns the value of the instance column's cell at absolute location `row`.
    function instance_value(uint256 selector, address instance) public view virtual returns (uint256);

    /// @dev Assigns a fixed value
    function assign_fixed(uint256 selector, uint256 value) public virtual;

    /// @dev Constrains a cell to have a constant value.
    ///
    /// Returns an error if the cell is in a column where equality has not been enabled.
    function constraint_constant(uint256 selector, uint256 constant_) public virtual;

    /// @dev Constraint two cells to have the same value.
    ///
    /// Returns an error if either of the cells is not within the given permutation.
    function constraint_equal(uint256 selector, uint256 other_selector) public virtual;
}
