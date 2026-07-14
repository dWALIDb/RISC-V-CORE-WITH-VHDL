import sounddevice as sd
import struct

# load binary file that has the sound we want to play, then play the sound

file_path=r'C:\Users\DELL\Desktop\master_proj\C_python_setp\SAMPLES.bin'
fd=open(file_path,"rb")
raw_binary_data=fd.read()
print()
print(f"read {len(raw_binary_data)} bytes from {file_path}\n")

# using unpack to convert this bytes object into a float object little endian then the count then type
# print(format(f'<{len(raw_binary_data)//4}f'))
floats=struct.unpack(format(f'<{len(raw_binary_data)//4}f'),raw_binary_data)


sample_rate = 8000

sd.play(floats, sample_rate)
sd.wait()
