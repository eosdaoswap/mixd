// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

interface IERC20 {
   
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}


pragma solidity ^0.8.0;


abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _setOwner(_msgSender());
    }
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


pragma solidity ^0.8.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

pragma solidity ^0.8.0;

contract Mint is Ownable{
    using SafeMath for uint256;

    address public _token;

    uint256 public _currentAmount;

    uint256 public _totalCount;

    uint256 public _rate;

    bool public _poolEnabled;

    struct Person {
        bool initial;
        uint256 mintTime;
        uint256 startTime;
        uint256 inviteCount;
        uint256 twitterCount;
        uint256 telegramCount;
        uint256 claim;
        uint256 unclaim;

    }
    struct Invite {
        address addr;
        uint256 datetime;
    }

    mapping (address => Person) public _users;
    mapping (address => Invite[]) public _invites;
    mapping (address => address) public  _exitsCheck;

    constructor(address token,uint256 rate){
        _token = token; // Mint token address
        _rate = rate;
        _poolEnabled = false;
    }


    function startMint(address refer) public {
        require(_poolEnabled, "Not yet started");
        require(msg.sender == tx.origin, "Only external accounts can call this function");
        require(!isContract(msg.sender), "Only external accounts can call this function");
        require(!_users[msg.sender].initial,"repeat start");
        Person memory newPerson;
        newPerson.initial = true;
        newPerson.mintTime = block.timestamp;
        newPerson.startTime = block.timestamp;
        newPerson.inviteCount = 0;
        newPerson.twitterCount = 0;
        newPerson.telegramCount = 0;
        newPerson.claim = 0;
        newPerson.unclaim = 0;
        _users[msg.sender] = newPerson;
        _totalCount += 1;
        
        if(refer == address(0) || refer == msg.sender){
            return;
        }

        if(_exitsCheck[msg.sender] == address(0)){
            
            if(_users[refer].initial){
            
                uint256 unclaim = _users[refer].unclaim;
                //unclaim+= (block.timestamp - _users[refer].startTime) * (_rate * _users[refer].inviteCount + _rate);
                unclaim += _getClaim();
                _users[refer].unclaim = unclaim;
                _users[refer].startTime = block.timestamp;
            }
             
            _users[refer].inviteCount += 1;
            Invite memory invite = Invite(msg.sender,block.timestamp);
            _invites[refer].push(invite);
            
            _exitsCheck[msg.sender] = refer;
        }


    }


    function withdraw() public  {
        require(_poolEnabled, "Not yet started");        
        require(msg.sender == tx.origin, "Only external accounts can call this function");
        require(!isContract(msg.sender), "Only external accounts can call this function");
        require(_users[msg.sender].initial,"initial error");
        require((block.timestamp - _users[msg.sender].startTime) > 0, "too fast");
        
        //uint256 claim = (block.timestamp - _users[msg.sender].startTime) * (_rate * _users[msg.sender].inviteCount + _rate);
        uint256 claim =  _getClaim();
        uint256 unclaim =  _users[msg.sender].unclaim;
        
        IERC20(_token).transfer(msg.sender,unclaim + claim);
        
        _users[msg.sender].unclaim = 0;
        _users[msg.sender].claim += (unclaim + claim);
        _users[msg.sender].startTime = block.timestamp;

        _currentAmount += (unclaim + claim);

    }

    function getRewards(address addr) public view returns(uint256) {
        if(!_users[addr].initial){
            return 0;
        }
        //uint256 claim = (block.timestamp - _users[addr].startTime) * (_rate * _users[addr].inviteCount + _rate);
        uint256 claim = _getClaim();
        uint256 unclaim =  _users[addr].unclaim;
        return (claim + unclaim);
    }


    function withdrawToken(address token, address recipient,uint amount) onlyOwner external {
        IERC20(token).transfer(recipient, amount);
    }

    function withdrawETH() onlyOwner external {
        payable(msg.sender).transfer(address(this).balance);
    }

    function isContract(address addr) internal view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(addr)
        }
        return (size > 0);
    }

    function _getClaim() internal view returns (uint256 claim_) {
        
        claim_ = _users[msg.sender].inviteCount.mul(6).add(_users[msg.sender].twitterCount).add(_users[msg.sender].telegramCount).add(2);
        if(claim_ > 124){
            claim_ = 124;
        }
        claim_ = claim_.mul(_rate).mul(block.timestamp.sub(_users[msg.sender].startTime));   
    }


    function updatePoolEnabled(bool enabled) external onlyOwner {
        _poolEnabled = enabled;
    }

    function twitter() public  {
        require(_poolEnabled, "Not yet started");        
        require(msg.sender == tx.origin, "Only external accounts can call this function");
        require(!isContract(msg.sender), "Only external accounts can call this function");
        if(_users[msg.sender].initial&&_users[msg.sender].twitterCount == 0)
        {
            _users[msg.sender].twitterCount = 1;
        }      
    }    

    function telegram() public  {
        require(_poolEnabled, "Not yet started");        
        require(msg.sender == tx.origin, "Only external accounts can call this function");
        require(!isContract(msg.sender), "Only external accounts can call this function");
        if(_users[msg.sender].initial&&_users[msg.sender].telegramCount == 0)
        {
            _users[msg.sender].telegramCount = 1;
        }           
    }    
}
