# Trying godot-rust with godot 3.5

This is a memo when trying following documents.

- Setup
  https://godot-rust.github.io/book/gdnative/intro/setup.html

- Hello, world!
  https://godot-rust.github.io/book/gdnative/intro/hello-world.html

- (Exporting to) Android
  https://godot-rust.github.io/book/gdnative/export/android.html

My environment

- Windows 11
- git for windows 2.35.3
- Godot 3.5.3
- rustup 1.75.0-nightly
- Visual Studio Build Tools 2022
- LLVM(clang) 16.0.0
- gdnative 0.11

## Setup

https://godot-rust.github.io/book/gdnative/intro/setup.html

- copy ```Godot_v3.5.3-stable_win64.exe``` to ```godot```.
- add a directory where ```godot``` exists to PATH environment variable.
- install rust.
- install Visual Studio Build Tools 2022
- install LLVM

## Hello, world!

https://godot-rust.github.io/book/gdnative/intro/hello-world.html

There are 2 tasks.

- build library file
- create godot project and make a reference to library file

Directory and file locations are following:

- hello_godot_rust
    - my-gdnative-lib
        - Cargo.toml
        - src
            - lib.rs
            - hello_world.rs
    - my-godot-project
        - project.godot

### build library file

- ```mkdir hello_godot_rust```
- ```cargo into --lib my-gdnative-lib```
- add following statement into Cargo.toml

```toml
[lib]
crate-type = ["cdylib"]

[dependencies]
gdnative = "0.11"
```
- edit rust files. Only lib.rs is created in the referencing document. But I create lib.rs and hello_world in this document.
  - src/lib.rs
    - importing hello_world.rs
  - src/hello_world.rs

src/lib.rs
```rust
use gdnative::prelude::*;

mod hello_world;

use crate::hello_world::HelloWorld;


// Function that registers all exposed classes to Godot
fn init(handle: InitHandle) {
    // Register the new `HelloWorld` type we just declared.
    handle.add_class::<HelloWorld>();
}


// Macro that creates the entry-points of the dynamic library.
godot_init!(init);
```

src/hello_world.rs
```rust
use gdnative::prelude::*;

/// The HelloWorld "class"
#[derive(NativeClass)]
#[inherit(Node)]
pub struct HelloWorld;

// You may add any number of ordinary `impl` blocks as you want. However, ...
impl HelloWorld {
    /// The "constructor" of the class.
    fn new(_base: &Node) -> Self {
        HelloWorld
    }
}

// Only __one__ `impl` block can have the `#[methods]` attribute, which
// will generate code to automatically bind any exported methods to Godot.
#[methods]
impl HelloWorld {
    #[method]
    fn _ready(&self, #[base] base: &Node) {
        // The `godot_print!` macro works like `println!` but prints to the Godot-editor
        // output tab as well.
        godot_print!("*** Hello world from node {}! ***", base.to_string());
    }
}
```

- ```cargo build``` to build library file named ```target/debug/my_gdnative_lib.dll```

### create godot project and make a reference to library file

- ```cd hello_godot_rust```
- ```mkdir my-godot-project```
- create godot project using ```my-godot-project```
- create GDNativeLibrary resource
  - select ```New Resource...``` in FileSystem dock
  - select ```GDNativeLibrary```
  - set file name as ```mylib.gdnlib```
  - copy ```my-gdnative-lib/target/debug/my_gdnative_lib.dll``` to ```my-godot-project```
- create main scene
  - select ```New Scene...``` in FileSystem dock
  - set name as ```main.tscn```
    - add ```Node2D``` node as root. The name of the node is ```Node2D```.
    - add Node node as a child of the root. The name of the node is ```Node```.
- attach node script
  - right-click ```Node``` and select ```Attach Script```
  - select Language to ```NativeScript```
  - set Class Name to ```HelloWorld```
  - set Path to ```res://Node.gdns```
  - push create
  - In the Inspector of ```Node.gdns```
    - set Library to ```mylib.gdnlib```
- play main.tscn


## (Exporting to) Android

https://godot-rust.github.io/book/gdnative/export/android.html


Note: I have not confirmed building a library for armv7a-linux-androideabi.

- Installing prerequisites
  - install the Android SDK with NDK enabled
  - Godot GUI(Editor > Editor Settings > Export > Android)
    - Android SDK Path: ```d:/prog/android_sdk_godot```
    - Debug Keystore: ```C:/Users/me/.android/debug.keystore```
    - Debug Keystore User: ```androiddebugkey```
    - Debug Keystore Pass: ```android```

- install nightly toolchain
```
rustup toolchain install nightly
rustup +nightly target add aarch64-linux-android
rustup +nightly target add x86_64-linux-android
rustup +nightly target add armv7-linux-androideabi
rustup +nightly target add i686-linux-android
```

- gcc libraries for cross-compilation
  - install mingw on Windows https://sourceforge.net/projects/mingw-w64/
    - click ```Files```
    - click ```x86_64-posix-sjij``` to download ```x86_64-8.1.0-release-posix-sjlj-rt_v6-rev0.7z```
    - extract the archive file into, for example, ```c:\prog\mingw64```. 7zip is needed to extract.
    - add ```c:\prog\mingw64\bin``` into PATH environment variable.

- (Skip) Custom Godot build

- Setting up Cargo

c:\Users\me\.cargo\config.toml
```toml
[target.armv7a-linux-androideabi]
linker = "d:/prog/android_sdk_godot/ndk/23.2.8568313/toolchains/llvm/prebuilt/windows-x86_64/bin/armv7a-linux-androideabi29-clang.cmd"

[target.aarch64-linux-android]
linker = "d:/prog/android_sdk_godot/ndk/23.2.8568313/toolchains/llvm/prebuilt/windows-x86_64/bin/aarch64-linux-android29-clang.cmd"

[target.i686-linux-android]
linker = "d:/prog/android_sdk_godot/ndk/23.2.8568313/toolchains/llvm/prebuilt/windows-x86_64/bin/i686-linux-android29-clang.cmd"

[target.x86_64-linux-android]
linker = "d:/prog/android_sdk_godot/ndk/23.2.8568313/toolchains/llvm/prebuilt/windows-x86_64/bin/x86_64-linux-android29-clang.cmd"
```

- Setting up environment variables for gdnative-sys
- Building the GDNative library
  - I created build.sh script, in which environment variables are set

build.sh
```bash
export ANDROID_SDK_ROOT=d:/prog/android_sdk_godot
export ANDROID_NDK_VERSION=23.2.8568313

# Windows
cargo +nightly build --release

cp target/release/my_gdnative_lib.dll \
    ../my-godot-project/my_gdnative_lib_release.dll

cargo +nightly build

cp target/debug/my_gdnative_lib.dll \
    ../my-godot-project/my_gdnative_lib_debug.dll

# armv7-linux-androideabi
# cargo +nightly build --release --target armv7-linux-androideabi

# i686-linux-android
cargo +nightly build --release --target i686-linux-android

cp target/i686-linux-android/release/libmy_gdnative_lib.so \
    ../my-godot-project/libmy_gdnative_lib_i686_release.so

cargo +nightly build --target i686-linux-android

cp target/i686-linux-android/debug/libmy_gdnative_lib.so \
    ../my-godot-project/libmy_gdnative_lib_i686_debug.so

# aarch64-linux-android
cargo +nightly build --release --target aarch64-linux-android

cp target/aarch64-linux-android/release/libmy_gdnative_lib.so \
    ../my-godot-project/libmy_gdnative_lib_aarch64_release.so

cargo +nightly build --target aarch64-linux-android

cp target/aarch64-linux-android/debug/libmy_gdnative_lib.so \
    ../my-godot-project/libmy_gdnative_lib_aarch64_debug.so

# x86_64-linux-android
cargo +nightly build --release --target x86_64-linux-android

cp target/x86_64-linux-android/release/libmy_gdnative_lib.so \
    ../my-godot-project/libmy_gdnative_lib_x86_64_release.so

cargo +nightly build --target x86_64-linux-android

cp target/x86_64-linux-android/debug/libmy_gdnative_lib.so \
    ../my-godot-project/libmy_gdnative_lib_x86_64_debug.so

```

- Exporting in Godot
  - In my-godot-project, open ```mylib.gdnlib```, set libraries as each Platform's Dynamic Library.
    - I guess that *_debug.so is for debug build and *_release.so is for release build.


