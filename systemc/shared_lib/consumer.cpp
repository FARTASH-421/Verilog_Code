#include "consumer.h"

void consumer::receiver()
{
    std::cout << "@" << sc_time_stamp() << ": " << name() << ": Received new data: 0x" << std::hex << data << std::endl;
}