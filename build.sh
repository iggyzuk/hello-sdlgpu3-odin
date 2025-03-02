#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Compiling GLSL to SPIR-V"
glslc shader.glsl.vert -o shader.spv.vert
glslc shader.glsl.frag -o shader.spv.frag

echo "Converting SPIR-V to MSL"
spirv-cross shader.spv.vert --msl --output shader.metal.vert
spirv-cross shader.spv.frag --msl --output shader.metal.frag

odin build . -debug -out:hello-sdl3

if [ "$1" == "run" ]; then
    echo "Running the program"
    ./hello-sdl3
fi
