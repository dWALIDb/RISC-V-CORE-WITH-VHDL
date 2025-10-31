#include<iostream>
#include<thread>
#include<windows.h>
#include"comms.hpp"

#define PORT_NAME "COM4"
#define BAUDRATE 9600



int main(){
    Serial_port serial=Serial_port();
    serial.SetUpPort(PORT_NAME);
    serial.SetUpBaud(BAUDRATE);
    std::thread worker(Serial_port::ReadPort,&serial);
    float a=0.69f;
    while (1)
    {
        unsigned char* x;
        x=(unsigned char*)&a;
        serial.transmitter_buff[0]=(unsigned char)x[0];
        serial.transmitter_buff[1]=(unsigned char)x[1];
        serial.transmitter_buff[2]=(unsigned char)x[2];
        serial.transmitter_buff[3]=(unsigned char)x[3];
        serial.MSG_LENGTH=4;
        serial.WritePort();
        a+=0.1f;
        while(serial.reciever_buff[0]!='#');
    }
    

    return 0;
}