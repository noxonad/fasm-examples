# Linux x86_64 FASM Examples

Some more advanced and practical examples to demonstrate certain concepts I came across by experimenting and tinkering with [fasm](https://flatassembler.net/) for [ttyper](https://github.com/noxonad/ttyper). It uses standard c library for function calling like `malloc`, `free`, `time` etc.

Feel free to study, modify and play with them to see how fasm works, as I found little to no documentation to more advanced concepts like allocating memory and getting time difference.

A simpler examples can be found [here](https://github.com/hnwfs/lin-Fasm).


## Building

In order to build all the examples you can run
```console
$ make
```

or build just a certain one
```console
$ make malloc
$ make time 
```

and then run each of the example:
```console
$ ./malloc
Value: 10
Value: 5

$ ./time
The elapsed time is 2 seconds

$ ./numbers
Number A: 1691
Number B: 42
Sum: 1733
Diff: 1649
Mul: 71022.00
Div: 40.26190
Mod: 11
```

## Clearing up

To clear the build files, simply run

```console
$ make clean
```

## Linux x86_64 Calling Conventions

According to [this](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/constants/syscalls.md), the register order for the syscalls is as follows: `rdi, rsi, rdx, r10, r8, r9`, and the result is put into `rax`.

Calling conventions for function calling, according to [this post](https://stackoverflow.com/questions/2535989/what-are-the-calling-conventions-for-unix-linux-system-calls-and-user-space-f#2538212) is as follows: `rdi, rsi, rdx, rcx, r8 and r9`

# Contribution

I'm far from being a fasm expert and if you want to point out some mistakes or provide more examples, you're free to do so. I hope that will help not only me, but also other fasm newcomers that want to go beyond writing a hello world program.

The code is distributed under the MIT licence so feel free to use it as an example database for your tutoring.