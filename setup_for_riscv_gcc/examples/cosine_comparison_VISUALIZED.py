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


INITIAL_VAL = -PI #starting value to send

LAST_VAL = PI #last value sent to CPU

STEP = 0.01 #increment on value sent to CPU

# float values are counted by uart_write(<float>,4)
# EACH WRITE OF 4 BYTES HAS A GRAPH :)
NUM_GRAPHS = 7 #how many float values are sent in one iteration, that correspond to 1 graph

UART_BAUD = 115200
UART_PORT = 'COM4' 
ser=serial.Serial(UART_PORT,UART_BAUD,timeout=0)

# both lists are used for the graphs
results: list[float]=[] # list that holds data processed by cpu
inputs: list[float]=[] # list that holds data that was sent to cpu
response_delays : list[float]=[] 


# used to stop counting:)
iters=0
# measures delay between sending bytes and response of CPU
# time taken by this code and the tiny delays are accounted too
# so it does need more ... polishing all this cus i dont have a cycle counter 
# in my architecture... what a shame ...

time.sleep(1) #just a delay, no real reason

a=float(INITIAL_VAL) #STARTING 
# decompose float into bytes to send them individually
bytess = struct.pack('f',a)
for b in bytess:
        ser.write(bytes([b]))
        ser.flush()
        time.sleep(DELAY_UART)

current_start=time.perf_counter()

try:
    while True:
        if ser.in_waiting:
            time.sleep(DELAY_PROCESSING)
            response_delays.append(time.perf_counter()-current_start)
            # line=ser.readline().decode(errors='replace').replace("\n"," ")
            #READING PACKS OF 4 BYTES 
            while ser.in_waiting>=4:
                line=ser.read(4)
                response = struct.unpack('<f',line)[0] #COMPOSING FLOATS (first elem of tuple has values)           
                results.append(float(response))

            print(f'{response}',end='\r')#shows last result, just to make sure something is happening
            
            inputs.append(a)
            ser.reset_input_buffer(); #discard anything that came later than when we read
            a+=STEP #move one step 
            
            iters+=1
            # stop depending on the range specified by user
            if iters>int((LAST_VAL-INITIAL_VAL)/STEP) :
                print(f"\nSTOPPED after {iters} iters...\n")
                break

            bytess = struct.pack('f',a)
            for b in bytess:
                ser.write(bytes([b]))
                ser.flush()
                time.sleep(DELAY_UART)

        current_start=time.perf_counter()

except KeyboardInterrupt:
    print(f"\nSTOPPED after {iters} iters...\n")

finally:
    # now this changes depending on application
    # i made sure that i sent ann values last
    #values are interleaved in the list, meaning that each graph has its values (NUM_GRAPHS example: 7) appart
    ann_cos = results[NUM_GRAPHS-1::NUM_GRAPHS]
    real_cos=np.cos(inputs)
    for i in range(0,NUM_GRAPHS):
        #changing the labels, to make visualization clear 
        chosen_label=  "ANN" if i==(NUM_GRAPHS-1) else f"TS n={i+1}"
        plt.plot(inputs,results[i::NUM_GRAPHS],label=chosen_label)
    # some more information about axes and stuff
    plt.plot(inputs,real_cos,label="True cosine")
    plt.xlabel("X")
    plt.ylabel("COS(X)")
    plt.title("cosine function approximation")
    plt.legend()
    plt.show()
    ser.close()
    

    #calculating MAE between the results
    mean=np.mean(np.abs(np.subtract(real_cos,ann_cos)))
    print(f"Mean Absolute Error between ANN and real cosine : {mean}")
    print()
    for i in range(0,NUM_GRAPHS-1):
        mean=np.mean(np.abs(np.subtract(real_cos,results[i::NUM_GRAPHS])))
        print(f"Mean Absolute Error between Taylor Series n={i+1} and real cosine : {mean}")
    
    print()

    for i in range(0,NUM_GRAPHS-1):
        mean=np.mean(np.abs(np.subtract(ann_cos,results[i::NUM_GRAPHS])))
        print(f"Mean Absolute Error between Taylor Series n={i+1} and ANN cosine : {mean}")

# we get average computation time
#i have a hard coded delay in this code, so i just subtract it to the average :)
average_calculation_delay= np.average(response_delays) - DELAY_PROCESSING
print()
print(f"average calculation delay : {average_calculation_delay*1000} ms")