// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address private _owner;

    event OwnershipTransfered(address indexed previousOwner, address indexed newOwner);

    /*
     * Los modificadores son acumulaciones de código fuente en 
     * tiempo de compilación.
     * Las funciones se pueden "modificar" al incluir el 
     * modificador nombrado en la declaración de la función.
     */ 
    modifier onlyOwner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function _transferOwnership(address newOwner) internal {
        address previousOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransfered(previousOwner, newOwner);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    function renounceOwnership() public onlyOwner {
        _transferOwnership(address(0));
    }

}