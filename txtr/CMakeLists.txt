# txtr_build cmake list
cmake_minimum_required(VERSION 3.28, FATAL_ERROR)

if(${TXTR_STATIC})
    message(FATAL_ERROR "TXTR_STATIC must be set to off for this interface cmake list")
endif()

# TODO: AppleClang

project(txtr_build LANGUAGES C)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

if(NOT ${CMAKE_C_COMPILER_ID} MATCHES "GNU|Clang")
    message(FATAL_ERROR "Unsupported compiler. If using MVSC, use MSYS2 MINGW or MSYS2 CLANG64 instead.")
elseif(${CMAKE_C_COMPILER_ID} MATCHES "GNU")
    include(txtr_build_gcc)
elseif(${CMAKE_C_COMPILER_ID} MATCHES "Clang")
    include(txtr_build_clang)
endif()

add_global_flags()

option(TXTR_BUILD_SSE2 "Build with SSE2 support." OFF)
option(TXTR_BUILD_AVX "Build with AVX support." OFF)
option(TXTR_BUILD_AVX2 "Build with AVX2 support." OFF)

if(TXTR_BUILD_SSE2)
    add_global_sse2_flags()
endif()
if(TXTR_BUILD_AVX)
    add_global_avx_flags()
endif()
if(TXTR_BUILD_AVX2)
    add_global_avx2_flags()
endif()
add_global_vec_flags()

# txtr
if(NOT TARGET txtr)
    add_subdirectory(${PROJECT_SOURCE_DIR}/../extern/gxtexture_base/txtr CMAKE/txtr)
endif()
target_link_libraries(txtr)

install(IMPORTED_RUNTIME_ARTIFACTS txtr)
