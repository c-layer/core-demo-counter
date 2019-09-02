pragma solidity >=0.5.0 <0.6.0;

import "./Storage.sol";


/**
 * @title Core
 *
 * @author Cyril Lapinte - <cyril.lapinte@openfiz.com>
 *
 * Error messages
 *   CO01: No delegates has been defined
 *   CO02: A delegates has already been defined
 *   CO03: Delegatecall should be successfulll
 **/
contract Core is Storage {

  modifier onlyProxy {
    require(proxyDelegates[msg.sender] != address(0));
    _;
  }

  function delegateCall(address _proxy) internal returns (bool status)
  {
    address delegate = proxyDelegates[_proxy];
    require(delegate != address(0), "CO01");
    (status, ) = delegate.delegatecall(msg.data);
    require(status, "CO03");
  }

  function execute(bytes memory _data)
    public returns (bool status, bytes memory result)
  {
    address delegate = proxyDelegates[msg.sender];
    require(delegate != address(0), "CO01");
    (status, result) = delegate.delegatecall(_data);
    require(status, "CO03");
  }

  function defineProxyDelegate(address _proxy, address _delegate) public returns (bool) {
    require(proxyDelegates[_proxy] == address(0));
    require(_delegate != address(0), "CO02");
    proxyDelegates[_proxy] = _delegate;
    return true;
  }

}
