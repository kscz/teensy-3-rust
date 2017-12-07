# Rust on the teensy 3.1/3.2

A bare metal example of blink written in rust for the teensy 3.1 and 3.2

## Requirements

* rustc nightly - we need some features which are disabled in stable
* cargo - to manage dependencies and in order to install xargo
* xargo - to manage compiling `libcore` from source
* arm-none-eabi toolchain including...
  * arm-none-eabi-ld - for linking the binary!
  * arm-none-eabi-objcopy - for generating `.hex` files
* teensy-loader-cli - to put the code into a teensy 3.1 or 3.2

## Building

Simply run `make all` to build the project!

## Flashing

Run `make flash` to invoke the teensy_loader_cli and put your hex file onto
your teensy!

## Installing Dependencies

For this example, I use [rustup](https://www.rustup.rs/).  I highly recommend
installing it, it will make your life a lot easier!

### Getting the Toolchain Setup

By default, rustc disables many "unstable" features which we depend on in order
to build bare-metal rust, so unfortunately we'll need to use nightly to compile
our code.  I use a specific, recent version of the nightly because it works and
there's another popular bare-metal rust project using it at the moment:
```bash
rustup install nightly-2017-11-19
```
You'll need to either make the nightly toolchain your default toolchain, or set
the rules for rustup to make the nightly toolchain the default for this folder.

Setting nightly as default for the whole computer:
```bash
rustup default nightly-2017-11-19
```

Setting nightly as default for this specific folder:
```bash
rustup override set nightly-2017-11-19
```

### Installing Xargo
Assuming you already have Cargo, this is easy!
```bash
cargo install xargo
```
Xargo also needs to have the source code for the version of nightly you're
using, so you'll also need to run:
```bash
rustup add component rust-src
```

### Getting the arm-none-eabi toolchain
There are lots of ways to do this, but I'll give you the method I use.

Go to the [GNU ARM Embedded Toolchain](https://launchpad.net/gcc-arm-embedded)
page, which is maintained by ARM itself.  Pick a reasonably recent release, and
download the build artifacts for it.  As of this writing, I've been using the
[5.x 2016-q3 release](https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update).
Download the pre-built linux release, extract it somewhere and then add the
`bin` folder to your path.  On my machine, I extracted the zip file to my home
directory, and added the following line to my `~/.bashrc`:
```bash
PATH=~/gcc-arm-none-eabi-5_4-2016q3/bin:$PATH
```
I then closed and re-opened my terminal, and verified that running
`arm-none-eabi-gcc --version` produced output like the following:
```bash
arm-none-eabi-gcc (GNU Tools for ARM Embedded Processors) 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

#### Getting errors running arm-none-eabi-gcc
If you followed the above directions, you may need to install 32-bit versions
of `libc6` and `ncurses` in order to run the pre-built binaries on a 64-bit
host.  On Ubuntu 17.04, to fix this, I ran:
```bash
sudo apt install libc6:i386 lib32ncurses5
```

### Getting the teensy_loader_cli
Easiest one yet! Head [here](https://www.pjrc.com/teensy/loader_cli.html)
and follow the directions!

