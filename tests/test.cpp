#include <iostream>
#include "<library>.h"

int main()
{
    std::string_view str("Hello World!");
    std::cout << str << std::endl;
    std::cout << add(3, 5) << std::endl;
    return 0;
}