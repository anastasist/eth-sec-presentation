---
title: "Smart Contract Static Analysis Demo:\n\n Catching a simple **_Reentrancy_** bug"
author: Anastasis Triantafyllou

theme:
    override:
        footer:
            style: template
            left: 
                image: './eth-diamond-(purple).png'
            center: '<span class="noice">Ethereum</span> Security'
            right: "{current_slide} / {total_slides}"
            height: 5
        palette:
            classes:
                noice:
                    foreground: blue
---

<!-- font_size: 2 -->

The Idea
---

Every program, smart contracts included, has bugs waiting to be uncovered.

<!-- pause -->

Wouldn't it be nice if there was an automated way of detecting patterns that usually lead to known bugs?

<!-- end_slide -->

<!-- font_size: 2 -->

The Tools
---

Turns out that there are ways to accomplish automated bug detection.

<!-- pause -->

Thanks to the field of program analysis, we can apply techniques such as:

<!-- incremental_lists: true -->
* Fuzzing
* Model Checking
* Formal Verification
* Static Analysis

<!-- end_slide -->

<!-- font_size: 2 -->

The Problem
---

Unfortunately, program analysis techniques do not scale well when handling the size of real-world programs.

<!-- pause -->

But...

<!-- pause -->

Smart Contracts are **inherently** small!

Some program analysis techniques are applicable and perform to an acceptable extent!

<!-- end_slide -->

The Example
---

<!-- font_size: 2 -->

Let's take the following `burn` function of a toy ERC20 token implementation:

<!-- font_size: 1 -->

```bash +exec_replace
bat --color always --style=plain -r 36:45 forge/src/Helios.sol
```

<!-- pause -->

<!-- font_size: 2 -->

Can you see the problem?

<!-- end_slide -->

The Example
---

<!-- font_size: 2 -->

This implementation enables a textbook **reentrancy** attack!

<!-- font_size: 1 -->

```bash +exec_replace
bat --color always --style=plain -r 36:45 --highlight-line 43:44 --highlight-line 41 forge/src/Helios.sol
```

<!-- pause -->

<!-- font_size: 2 -->

(Let's attack it live!)

<!-- pause -->

How can we automatically catch patterns such as this `Call->Store` one?

<!-- end_slide -->

<!-- font_size: 2 -->

Static Analysis
---

As the name implies, this technique takes the code of a program (any abstraction level, source/IR/binary) and applies some kind of analysis on it.

<!-- pause -->

The core idea is to build a set of facts that are true for the given code and use them to derive the more complex patterns.

<!-- end_slide -->

<!-- font_size: 2 -->

Knowledge Representation
---

What we are trying to form is some kind of knowledge base and some way to query it.

<!-- pause -->

Historically, knowledge representation systems are best paired with logic-based declerative querying languages.

The state-of-the-art has converged to continue supporting that belief today.

<!-- end_slide -->

<!-- font_size: 2 -->

Prolog
---

The language most associated with the field of logic programming itself is Prolog.

<!-- pause -->

Unfortunately, Prolog has an undesirable property for our use case:

<!-- pause -->

* Top-down evaluation: has to calculate the query when it is provided, for the given values.

<!-- end_slide -->

<!-- font_size: 2 -->

Datalog
---

A subset of Prolog, employing bottom-up evaluation of its predicates, starting from the facts.

<!-- pause -->

In simple terms, it will calculate all predicates for all facts, when run.

<!-- pause -->

So, when we run an analysis in Datalog on a given contract, we can immediately answer which parts of the contract, if any, satisfy our patterns.

<!-- end_slide -->

<!-- font_size: 2 -->

Datalog Example
---

Let's take a simple knowledge base expressed in Datalog:

<!-- font_size: 1 -->

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->

```file
path: "./datalog/intro.dl"
language: datalog
start_line: 1
end_line: 10
```

<!-- column: 1 -->

```file
path: "./datalog/intro.dl"
language: datalog
start_line: 12
end_line: 23
```

<!-- reset_layout  -->

<!-- font_size: 2 -->

<!-- pause -->

<!-- alignment: center -->

Let's run it!

<!-- end_slide -->

<!-- font_size: 2 -->

Gigahorse
---

In order to apply analyses on smart contracts, we first need to generate facts from them.

<!-- pause -->

For that, we let `Gigahorse` do the heavy lifting.

<!-- pause -->

`Gigahorse` is a decompiler of EVM bytecode, generating more human-friendly, higher-level code, along with a set of facts!

<!-- end_slide -->

<!-- font_size: 2 -->

Demo!
---

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->

<!-- new_lines: 3 -->

Let's see everything in action!

<!-- column: 1 -->

![](doge.png)

<!-- font_size: 1 -->

_Picture by <span style="color: red">Alexis Bailey</span> / CC BY-NC 4.0_

<!-- reset_layout -->

<!-- end_slide -->

<!-- jump_to_middle -->

The end
---
