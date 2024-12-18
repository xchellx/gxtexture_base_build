# gxtexture_build cmake list
cmake_minimum_required(VERSION 3.28, FATAL_ERROR)

if(${GXTEXTURE_STATIC})
    message(FATAL_ERROR "GXTEXTURE_STATIC must be set to off for this interface cmake list")
endif()

# TODO: AppleClang

project(gxtexture_build LANGUAGES C)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

if(NOT ${CMAKE_C_COMPILER_ID} MATCHES "GNU|Clang")
    message(FATAL_ERROR "Unsupported compiler. If using MVSC, use MSYS2 MINGW or MSYS2 CLANG64 instead.")
elseif(${CMAKE_C_COMPILER_ID} MATCHES "GNU")
    include(gxtexture_build_gcc)
elseif(${CMAKE_C_COMPILER_ID} MATCHES "Clang")
    include(gxtexture_build_clang)
endif()

add_global_flags()

option(GXTEXTURE_BUILD_SSE2 "Build with SSE2 support." OFF)
option(GXTEXTURE_BUILD_AVX "Build with AVX support." OFF)
option(GXTEXTURE_BUILD_AVX2 "Build with AVX2 support." OFF)

if(GXTEXTURE_BUILD_SSE2)
    add_global_sse2_flags()
endif()
if(GXTEXTURE_BUILD_AVX)
    add_global_avx_flags()
endif()
if(GXTEXTURE_BUILD_AVX2)
    add_global_avx2_flags()
endif()
add_global_vec_flags()

# gxtexture
if(NOT TARGET gxtexture)
    add_subdirectory(${PROJECT_SOURCE_DIR}/../extern/gxtexture_base/gxtexture CMAKE/gxtexture)
endif()
link_libraries(gxtexture)

install(IMPORTED_RUNTIME_ARTIFACTS gxtexture)
