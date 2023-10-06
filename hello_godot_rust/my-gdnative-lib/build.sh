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
