cmake_minimum_required(VERSION 3.9)
project(ragel)

set(CMAKE_CXX_STANDARD 11)


set(RAGEL_DIR .)
find_package(RAGEL REQUIRED)


RAGEL_TARGET(main main.rl  ${CMAKE_CURRENT_BINARY_DIR}/main.cpp)


add_executable(ragel main.cpp)