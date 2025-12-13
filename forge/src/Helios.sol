// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Helios {
    address public immutable _owner;
    string private constant _name = "Helios";
    string private constant _symbol = "HEL";
    uint8 private immutable _decimals;
    uint256 private _totalSupply; 
    mapping(address => uint256) public _balances;
    mapping(address => mapping(address => uint256)) public _allowances; // _allowances[origin][spender]=value

    constructor() payable { // Made payable to initialize with balance
        _owner = msg.sender;
        _decimals = 18;
        _totalSupply = 0;
    }

    receive() external payable{
        // fallback() external payable throws a warning if no receive is present,
        // having both is not needed for this homework so we stick with receive
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    function mint(address _recipient, uint256 _amount) public returns (bool) {
        require(msg.sender == _owner, "Only the token owner can mint tokens");
        _balances[_recipient] += _amount;
        _totalSupply += _amount;
        emit Transfer(address(0x0), _recipient, _amount); // On token creation
        return true;
    }

    function burn(address _recipient, uint256 _amount) public returns (bool success) {
        uint256 _initial_balance = _balances[msg.sender];
        uint256 currSupply = _totalSupply;
        require(_amount <= _initial_balance, "Insufficient funds");
        uint256 eth = (_amount*address(this).balance)/currSupply;
        require(success, "Failed to transfer funds");
        _balances[msg.sender] = _initial_balance - _amount;
        _totalSupply = currSupply - _amount;
        (success, ) = _recipient.call{value: eth}("");
    }


    function name() public pure returns (string memory){
        return _name;
    }

    function symbol() public pure returns (string memory){
        return _symbol;
    }

    function decimals() public view returns (uint8){
        return _decimals;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address owner) public view returns (uint256){
        return _balances[owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool){
        require(_value <= _balances[msg.sender], "Insufficient funds"); // Throw is deprecated, using require instead
        _balances[msg.sender] -= _value;
        _balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool){
        require(_value <= _allowances[_from][msg.sender], "Caller's allowance is insuffucient");
        require(_value <= _balances[_from], "Insufficient funds");
        _allowances[_from][msg.sender] -= _value;
        _balances[_from] -= _value;
        _balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool){
        // Allowance-related attack vector is ignored :)
        _allowances[msg.sender][_spender] = _value;
        emit Approval(_owner, _spender, _value);
        return true;
    }

    function allowance(address owner, address _spender) public view returns (uint256){
        return _allowances[owner][_spender];
    }

}
