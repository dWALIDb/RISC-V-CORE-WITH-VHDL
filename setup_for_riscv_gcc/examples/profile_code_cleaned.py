# this code should be used to profile subroutines :)

# you send a continuous stream of values and the cpu should 
# provide the number of cycles the subroutine took, 
# the output that subroutine should give and maybe more data

import serial
import time
import struct
import matplotlib.pyplot as plt
import numpy as np
import time
PI = 3.14159

# DATA SENT AS BYTES, BUT OVERALL WE SEND FLOATS TO CPU :) (SEND/RECIEVE BINARY DATA)
# WE SEND A LOT OF VALUES AND INCREMENT BY  A FIXED AMOUNT, TO GET A PLOT
# THIS APPLICATION IS SIMILAR TO SERIAL PLOTTER IN ARDUINO,IT WORKS WITH ONLY FLOATS THOUGH
# DATA MUST BE SENT AS BYTES AND WITHOUT NEW LINES, JUST RAW DATA

DELAY_UART = 0.000001 #1 us between bytes to send(because hardware is slow ?)

DELAY_PROCESSING = 0.003 # 3 ms as processing delay, while waiting for response (again slow?)

# float values are counted by uart_write(<float>,4)
# EACH WRITE OF 4 BYTES HAS A GRAPH :)

UART_BAUD = 115200
UART_PORT = 'COM5' 
ser=serial.Serial(UART_PORT,UART_BAUD,timeout=None)

# both lists are used for the graphs
results: list[float]=[] # list that holds data processed by cpu
inputs: list[float]=[] # list that holds data that was sent to cpu
response_delays : list[float]=[] 


print("HELLO FELLOW USER")
print("PRESS CTRL + C TO EXIT :)")

# used to stop counting:)
iters=0
# measures delay between sending bytes and response of CPU
# time taken by this code and the tiny delays are accounted too
# so it does need more ... polishing all this cus i dont have a cycle counter 
# in my architecture... what a shame ...

time.sleep(1) #just a delay, no real reason

# decompose float into bytes to send them individually
            
ser.write(bytes([0]))

try:
    while True:
        if ser.in_waiting>=12:
            #READING PACKS OF 4 BYTES that correspond to response of CPU 
            # READ INPUT TO SYSTEM THEN READ THE SYSTEM OUTPUT(RESPONSE) THEN READ SYSTEM DELAY
            line=ser.read(4)
            response1 = struct.unpack('<f',line)[0] #COMPOSING FLOATS (first elem of tuple has values)           
            
            line=ser.read(4)
            response2 = struct.unpack('<f',line)[0] #COMPOSING FLOATS (first elem of tuple has values)
            
            line=ser.read(4)
            response3= struct.unpack('<f',line)[0]
            
            inputs.append(response1)
            results.append(float(response2))
            response_delays.append(float(response3))

            #READING PACK OF 4 BYTES THAT CORRESPONDS TO # OF CYCLES TAKEN TO COMPUTE OUTPUT 
            iters+=1
            print(f'{iters}',end='\r')#shows last result, just to make sure something is happening
            # no need to trigger multiple times 
            # ser.write(bytes([0]))


except KeyboardInterrupt:

    print(f"\nSTOPPED after {iters} iters... and left {ser.in_waiting/8} pairs unprocessed\n")

finally:
    ser.close()
    user_input=input("would you like to plot the output ? (y/n): ")
    if user_input=="y":
        # now this changes depending on application
        # i made sure that i sent ann values last
        #values are interleaved in the list, meaning that each graph has its values (NUM_GRAPHS example: 7) appart
        # some more information about axes and stuff
        fig,axs= plt.subplots(2,1)
        axs[0].plot(inputs,results)
        axs[0].set_xlabel("X")
        axs[0].set_ylabel("Y")
        axs[0].set_title("CPU RESPONSE TO DATA")

        axs[1].plot(inputs,response_delays)
        axs[1].set_xlabel("X")
        axs[1].set_ylabel("Cycles")
        axs[1].set_title("CPU RESPONSE TIME")


        plt.show()
    
    
    # we get average computation time
    #i have a hard coded delay in this code, so i just subtract it to the average :)
    average_calculation_delay= np.average(response_delays)
    print()
    print(f"average calculation delay : {average_calculation_delay} cycles")

    print("max val",np.max(results))
    print("min val",np.min(results))
    print("max delay:",np.max(response_delays))
    print("min delay:",np.min(response_delays))


user_input=input("do you want to write this data into a file ? (y/n):")
if(user_input=="y"):
    fd=open("SAMPLES.bin","wb")
    array = np.array(results,dtype='float32')
    array.tofile(fd)
    print("written data into file (SAMPLES.bin)")
    print()
else:
    print("HAVE A NICE DAY :)")