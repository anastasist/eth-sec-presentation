# Ethereum Security Presentation
---

This presentation was made for the [Computer Security MSc course, M108.CS](https://www.di.uoa.gr/cs)

Solidity and datalog files are all part of course material or my own homework submissions for [Smart Contract Analysis MSc course, M228](http://yanniss.github.io/M228/)

## Prerequisites

Make sure you have the following programs installed:

* [bat](https://github.com/sharkdp/bat)
* [presenterm](https://github.com/mfontanini/presenterm)
* [souffle](https://souffle-lang.github.io/install)
* [gigahorse](https://github.com/nevillegrech/gigahorse-toolchain)
* [foundry](https://github.com/foundry-rs/foundry)

I recommend the `nix` package manager for convenience in installation.

## Viewing the presentation

Just run the convenience one-liner script:

```
./present.sh
```


## Running the demos

### Reentrancy Attack

Initialize a project with foundry's forge, under the `forge` directory:

```
# forcing as required files already under correct directories
forge init --force
```

And simply run:

```
forge test -vvvvv Attacker
```

### Datalog Example

Under `datalog` directory, simply run:

```
souffle intro.dl
```

Check the generated `Path.csv` file:

```
bat Path.csv
```

### Reentrancy Analysis

Under `datalog` directory, run:

```
# vizualizeout client is part of the gigahorse repository
# make sure you have it cloned
gigahorse -C /path/to/vizualizeout.py helios.hex
```

Navigate to facts directory:

```
cd .temp/helios/out
```

You may view any generated fact file or the Three-Address-Code decompiled code:

```
bat contract.tac
```

Run the analyses on these facts:

```
# Might need to update the path to gigahorse repo
# to properly include a library file, in analyes.dl
souffle -F . -D . ../../../analyses.dl
```

Check the generated `Reentrancy.csv` file:

```
bat Reentrancy.csv
```

Repeat the process for the `fixed.hex` file, which is the same contract but without the Reentrancy bug.


## Assets

`doge.png` was pulled from the [`presenterm` repository](https://github.com/mfontanini/presenterm)

`eth-diamond-(purple).png` was pulled from [ethereum.org/assets](https://ethereum.org/assets/)
