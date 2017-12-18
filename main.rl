
#include <iostream>
#include <cstring>
#include <functional>


#define DECLARE_RAGEL_VARS \
int cs;\
int top = 0;\
int stack[1024] = {0};\
const char *p = data.data();\
const char *pe = p + data.length();\
const char *eof = pe;\
const char *ts = NULL;




void on_value(const char *p, size_t len, size_t indent)
{
    std::cout <<  std::string(indent-1, '\t') <<  std::string(p, len)  << std::endl;
}


void demo_easy(const std::string &data)
{
    std::cout << "Demo : demo_easy ==================================" << std::endl;

    DECLARE_RAGEL_VARS;

    %%{
        machine test_easy;     #[3.1]

        action greet
        {
             std::cout << "Greetings, " << std::string(ts, fpc-ts) << std::endl;
        }

        GREETING_TARGET = "World" | "Me" ;

        SP = space* ',' space*;

        main := "Hello"  SP GREETING_TARGET>{ts=fpc;} %greet  ;
    }%%


    %% write data;
    %% write init;
    %% write exec;

    if (cs == test_easy_error)
    {
        std::cout << "Invalid pattern. Error at position" << (p-data.data()) << std::endl;
    }
    else
    {
        std::cout << "Parsed ok!" << std::endl;
    }

    std::cout << std::endl << std::endl;
}

void demo_advanced(const std::string &data)
{
    std::cout << "Demo : demo_advanced ==================================" << std::endl ;

    DECLARE_RAGEL_VARS;

    int indent = 0;

    bool eot = false;

    %%{
        machine test;

        action token_start
        {
                ++indent;
        }

        action token_stop
        {
            --indent;

            if (top)
            {
                fret;
            }
            else
            {
                eot = true;
            }
        }

        action repeat_token
        {
            fhold;
            fcall TOKEN;
        }

        SVALUE = "\"" any+ "\"";
        IVALUE = digit+;
        FVALUE = digit+[.]digit+ ;

        VALUE = (SVALUE | IVALUE | FVALUE) > {ts = fpc;} %{ on_value(ts, fpc-ts, indent); };

        LBR = '{';
        RBR = '}';
        ANYTOKEN = LBR >repeat_token;

        TOKEN = LBR %token_start
                (
                   ((space*? VALUE)  | ANYTOKEN)
                   (space*? (',' | RBR >token_stop) space*?)
                )* ;

        main := TOKEN ;
    }%%


    %% write data;
    %% write init;
    %% write exec;

    if (cs == test_error || !eot)
    {
        std::cout << "Error at position :" << (p-data.data()) << std::endl;
    }
    else
    {
        std::cout << "Parsed ok!" << std::endl;
    }

    std::cout << std::endl << std::endl;
}

int main()
{
    const std::string str1_ok = "Hello , Me";
    const std::string str1_fail = "Hello , Somebody";

    demo_easy(str1_ok);
    demo_easy(str1_fail);

    const std::string str2 = "{  1111  ,  2.5  ,{  3 , 4  ,{\"five str\",   6.6, {66, {111, 222, 333  },77,{1123124}},\"seven str\"}}, 8  }";
    demo_advanced(str2);

    return 0;
}

