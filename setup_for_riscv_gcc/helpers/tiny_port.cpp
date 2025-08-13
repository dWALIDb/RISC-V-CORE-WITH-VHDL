#include<iostream>
#include<thread>
#include"comms.hpp"
#include<windows.h>

#define PORT_NAME "COM5"
#define BAUDRATE 9600



int main(){
    Serial_port serial=Serial_port();

    serial.SetUpPort(PORT_NAME);
    serial.SetUpBaud(BAUDRATE);
    std::thread worker(Serial_port::ReadPort,&serial);
    while (1)
    {
    serial.transmitter_buff[0]=0x11;
    serial.transmitter_buff[1]=0x22;
    serial.transmitter_buff[2]=0x33;
    serial.transmitter_buff[3]=0x44;
    serial.WritePort();
    Sleep(2000);
    }
    

    return 0;
}