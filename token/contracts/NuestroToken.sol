// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract NuestroToken is Ownable {
    
    // "private" hace que contratos que importan o hereden no puedan alterar la variable
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    
    // Hash Tables / Dictionaries
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // Logs/ Indexed max 3
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);


    /* 
     * "memory" hace que las strings, las cuales no tienen un default declarado, 
     * sean solamente mantenidas en memoria duranta la ejecucion de la function.
     */
    constructor(string memory __name, string memory __symbol, uint8 __decimals) {
        _name = __name;
        _symbol = __symbol;
        _decimals = __decimals;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256 balance) {
        return _balances[account];
    }

    function _transfer(address from, address to, uint256 amount) internal {
        /*
         * "require()" revierte en caso de falla, 
         * enviando la razon como parte del mensaje de falla
         * 
         * Nadie es dueño de la dirección cero, 
         * cuando es usada en funciones donde no es requerida, 
         * generalmente es un error de software,
         * por lo que es una práctica recomendada revertir cuando este sea el caso.
         */
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        
        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        /*
         * "unchecked" se usa para evitar los códigos de operación que 
         * se ejecutan antes de la aritmética para verificar si hay un desbordamiento, 
         * los cuales incrementam el costo computacional.
         *
         * En este caso, al verificar valores con "require()", 
         * aseguramos que no exista desbordamiento, lo cual nos 
         * permite evitar el chequeo de la aritmetica que la EVM corre por default, 
         * ahorrando a los usuarios "Gas"
         */
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);
    }

    function transfer(address to, uint256 amount) public returns (bool success) {
        address from = msg.sender;
        _transfer(from, to, amount);
        return true;
    }

    function allowance(address tokenOwner, address spender) public view returns (uint256 remaining) {
        return _allowances[tokenOwner][spender];
    }
    
    function _approve(address tokenOwner, address spender, uint256 amount) internal {
        require(tokenOwner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[tokenOwner][spender] = amount;
        emit Approval(tokenOwner, spender, amount);
    }

    function approve(address spender, uint256 amount) public returns (bool success) {
        address tokenOwner = msg.sender;
        _approve(tokenOwner, spender, amount);
        return true;
    }
    
    function _spendAllowance(address tokenOwner, address spender, uint256 amount) internal {
        uint256 currentAllowance = allowance(tokenOwner, spender);
        /*
         * Este chequeo es solo necesario si el "allowance" no es infinito, 
         * de ser este el caso, no es necesario disminuir la cantidad del "allowance"
         */
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(tokenOwner, spender, currentAllowance - amount);
            }
        }
    } 

    function transferFrom(address from, address to, uint256 amount) public returns (bool success) {
        address spender = msg.sender;
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }


}