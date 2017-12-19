cmake_minimum_required(VERSION 3.9)
project(ragel-test)

set(CMAKE_CXX_STANDARD 11)


set(RAGEL_DIR .)
find_package(RAGEL REQUIRED)


RAGEL_TARGET(easy demo_easy.rl ${CMAKE_CURRENT_BINARY_DIR}/demo_easy_generated.cpp)
RAGEL_TARGET(advanced demo_advanced.rl ${CMAKE_CURRENT_BINARY_DIR}/demo_advanced_generated.cpp)


add_executable(ragel-test main.cpp demo_easy_generated.cpp demo_advanced_generated.cpp)

target_include_directories(ragel-test PUBLIC .)