import serial
import time
import struct
import matplotlib.pyplot as plt
import numpy as np

PI = 3.14159
DELAY_UART = 0.000001 #1 us between bytes to send
DELAY_PROCESSING = 0.01 #10 ms as processing delay, while waiting for response
INITIAL_VAL = -PI/2 #starting value to send
LAST_VAL = PI/2 #last value sent to CPU
STEP = 0.01 #increment on value sent to CPU

ser=serial.Serial('COM4',115200,timeout=0)
time.sleep(1)

a=float(0.01)
bytess = struct.pack('f',a)
for b in bytess:
        ser.write(bytes([b]))
        ser.flush()
        time.sleep(DELAY_UART)
try:
    while True:
        if ser.in_waiting:
            time.sleep(DELAY_PROCESSING)
            line=ser.read(4)
            response = struct.unpack('<f',line)[0] #first elem has values           
            print(f"{response}")

except KeyboardInterrupt:
    print(f"\nSTOPPED...\n")

finally:
    # print(results)
    ser.close()
    
