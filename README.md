# Core Demo - Counter

Counting on multiple counters at once.

This is a demo for the Token Core architecture used in the Compliance Layer (C-Layer).

## Deploying it

You may either run the following commands in your favorite shell with node and truffle installed and configured or alternatively, if you have docker and don't want to bother with node and truffle version depenencies, you may run the `start.sh` to have immediatly the right environment.

Support is given for the reference versions used in the docker image [sirhill/truffle](https://cloud.docker.com/u/sirhill/repository/docker/sirhill/truffle).

1. Compile the contracts using `truffle compile`
2. Test the contracts using `npm run test`

3. Using truffle (ie `truffle develop`), you may then deploy the Core, a proxy and a delegate

```javascript
   core = await CounterCore.new()

   proxy = await CounterProxy.new(core.address)

   delegate = await CounterDelegate.new()
```

4. finally, assign the proxy and the delegate to the core
```javascript
   await core.defineProxyDelegate(proxy.address, delegate.address)
```

## Play with the counter

As a user, you will most likely interact only with the proxy.

Each proxy will dispose of one global counter and individual counters.

When you call `await proxy.increaseCount(42)`, you increase both your personnal counter and the proxy global one.

Assuming you are signing transaction as `accounts[0]`, you can check the different counter by calling `await proxy.count(accounts[0])` for personal counter or `await proxy.globalCount()` for the global counter of the proxy.

You can also increase the counter from a different address `await proxy.increaseCount(13, { from: accounts[1] })`. The global counter will be increased to 55 while the two individual counters will be 42 for accounts[0] and 13 for accounts[1].


### Play with the counter for advanced users

Advanced users may also play with `await proxy.increaseCountNoDelegate(42)` to see that you could also count without using delegates. It would be have the same way. You may also check the gas consumption of the different calls.


## Counter contracts description

- `connter/CounterProxy.sol`: provides a demo implementation of the proxy abstraction
- `counter/CounterCore.sol`: provides a demo implementation of the core abstraction
- `counter/CounterDelegate.sol`: provides a demo implementation of the delegate abstraction
- `counter/CounterStorage.sol`: provides a counter storage to be used with both the CounterCore and CounterDelegate
