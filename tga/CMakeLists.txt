# tga_build cmake list
cmake_minimum_required(VERSION 3.28, FATAL_ERROR)

if(${TGA_STATIC})
    message(FATAL_ERROR "TGA_STATIC must be set to off for this interface cmake list")
endif()

# TODO: AppleClang

project(tga_build LANGUAGES C)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

if(NOT ${CMAKE_C_COMPILER_ID} MATCHES "GNU|Clang")
    message(FATAL_ERROR "Unsupported compiler. If using MVSC, use MSYS2 MINGW or MSYS2 CLANG64 instead.")
elseif(${CMAKE_C_COMPILER_ID} MATCHES "GNU")
    include(tga_build_gcc)
elseif(${CMAKE_C_COMPILER_ID} MATCHES "Clang")
    include(tga_build_clang)
endif()

add_global_flags()

option(TGA_BUILD_SSE2 "Build with SSE2 support." OFF)
option(TGA_BUILD_AVX "Build with AVX support." OFF)
option(TGA_BUILD_AVX2 "Build with AVX2 support." OFF)

if(TGA_BUILD_SSE2)
    add_global_sse2_flags()
endif()
if(TGA_BUILD_AVX)
    add_global_avx_flags()
endif()
if(TGA_BUILD_AVX2)
    add_global_avx2_flags()
endif()
add_global_vec_flags()

# tga
if(NOT TARGET tga)
    add_subdirectory(${PROJECT_SOURCE_DIR}/../extern/gxtexture_base/tga CMAKE/tga)
endif()
link_libraries(tga)

install(IMPORTED_RUNTIME_ARTIFACTS tga)
