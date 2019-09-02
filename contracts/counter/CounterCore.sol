pragma solidity >=0.5.0 <0.6.0;

import "../Core.sol";
import "./CounterStorage.sol";


/**
 * @title CounterCore
 *
 * @author Cyril Lapinte - <cyril.lapinte@openfiz.com>
 *
 * Error messages
 **/
contract CounterCore is Core, CounterStorage {

  function increaseCount(uint256, address)
    public returns (bool status)
  {
    return delegateCall(msg.sender);
  }

  function increaseCountNoDelegate(uint256 _value, address _user)
    public returns (bool status)
  {
    counter[address(this)].count[_user] += _value;
    counter[msg.sender].count[_user] += _value;
    counter[address(this)].globalCount += _value;
    counter[msg.sender].globalCount += _value;
    return true;
  }
}
