#include "common.h"

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