import serial
import time
import struct

ser=serial.Serial('COM4',9600,timeout=0.1)

time.sleep(1)
a=float(-2.0)
bytess = struct.pack('f',a)
for b in bytess:
        ser.write(bytes([b]))
        ser.flush()
        time.sleep(0.05)
 
try:
    while True:
        if ser.in_waiting:
            line=ser.readline().decode(errors='replace').replace("\n"," ")
            print(f'{line}',end='\r')
            time.sleep(0.1)
            a+=0.01
            bytess = struct.pack('f',a)
            ser.write(bytess)
            for b in bytess:
                ser.write(bytes([b]))
                ser.flush()
                time.sleep(0.05)
        
except KeyboardInterrupt:
    print("\nSTOPPED\n")
finally:
    ser.close()