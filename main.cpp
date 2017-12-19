#include "common.h"



void run_demo_easy_match()
{
    const std::string str = "Hello , Me";
    demo_easy(str);
}

void run_demo_easy_fail()
{
    const std::string str = "Hello , Somebody";
    demo_easy(str);
}


void run_demo_advanced()
{
    const std::string str = "{  1111  ,  2.5  ,{  3 , 4  ,{\"five str\",   6.6, {66, {111, 222, 333  },77,{1123124}},\"seven str\"}}, 8  }";
    demo_advanced(str);
}



int main()
{
    run_demo_easy_match();

    run_demo_easy_fail();

    run_demo_advanced();

    return 0;
}
