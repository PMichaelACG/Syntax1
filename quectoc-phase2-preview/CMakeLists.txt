cmake_minimum_required(VERSION 3.16)
project(QuectoCPhase2 C)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
find_package(BISON 3.6 REQUIRED)
find_package(FLEX REQUIRED)
BISON_TARGET(QuectoCParser parser.y
  ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.c
  DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.h
  COMPILE_FLAGS "-Wall -Werror=conflicts-sr -Werror=conflicts-rr")
FLEX_TARGET(QuectoCScanner scanner.l
  ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.c)
ADD_FLEX_BISON_DEPENDENCY(QuectoCScanner QuectoCParser)
add_executable(quectoc-parser main.c
  ${BISON_QuectoCParser_OUTPUTS}
  ${FLEX_QuectoCScanner_OUTPUTS})
target_include_directories(quectoc-parser PRIVATE
  ${CMAKE_CURRENT_BINARY_DIR})
target_compile_options(quectoc-parser PRIVATE -Wall -Wextra)
