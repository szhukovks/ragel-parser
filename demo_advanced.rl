#include "common.h"

void on_value(const char *p, size_t len, size_t indent)
{
    std::cout <<  std::string(indent-1, '\t') <<  std::string(p, len)  << std::endl;
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