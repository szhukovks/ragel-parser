#ifndef _COMMON_H
#define _COMMON_H

#include <cstddef>
#include <string>

#include <iostream>

#define DECLARE_RAGEL_VARS \
int cs;\
int top = 0;\
int stack[1024] = {0};\
const char *p = data.data();\
const char *pe = p + data.length();\
const char *eof = pe;\
const char *ts = NULL;


void demo_easy(const std::string &data);

void demo_advanced(const std::string &data);


#endif