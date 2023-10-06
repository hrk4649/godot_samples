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
