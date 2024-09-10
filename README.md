# RISC V
RISC V is an open Instruction Set Architecture used for the developement of custom processors.  
It is the **fifth** generation of developement hence, the V (in risv-V).  
The architecture is well documented by the RISC V organization, where the ISA is discussed.  
It has a base instruction set named RV32I containing all instructions necessary for a fully fledged 32-bit cental processing unit. It still
offers other extensions for more implementations depending on the manufacturers.  
  
In this implementation, 2 extensions are considered:  
**First**,the floating point extension (F) that provides a floating point register file, and instructions that handel floating point operands.  
**Second**,the integer multiply divide (M) that provides integer multiplication and division instructions.  

The naming convension specified in the *RISV V SPEC 2.2* specifies that using extensions requires using the letters corresponding to each extension with a specific ordering, hence, 
the top level of the design is named **RV32IMF**, it specifies that the CPU is 32-bit riscv soft core that provides base instructions, floating point instructions, and integer multiply 
devide instructions.  

# INTERNAL ARCHITECTURE  
The design is split into *five* stages to boost performance, and after implementation it turned out to be not as complicated as it seems.  
the stages are fetch,decode,execute,memory and write back.  

# FETCH STAGE
The module contains a RAM for instructions, a register that holds the program counter value and it outputs the instruction's op code, functionality fields, read/write addresses and 
immediate values. it always output PC+4 for next instruction.  
**NOTE THAT WE ADD 4 BECAUSE MEMORY IS LITTLE ENDIAN AND ALL INSTRUCTIONS ARE 32 BITS**  

# DECODE STAGE 
The module contains two 32x32 bit register files that are used for integer and floating point operations, the integer register file has the address *ZERO* as a hardwired zero that is 
very usefull, it also sign extends the encoded values in instructions that use immediate values.

# EXECUTE STAGE
The module handles all calculations and comparisons necessary for out instructions, it has three big modules that handle the majority of computations, namely arithmetic logic unit and 
multiply divide unit for integer operations and floating point unit for floating point operations, it calculates addresses depending on the different immediate fields generating by each 
format, finally it has comparators to generate flags used for conditional branch instructions that affect next instruction's address.

# MEMORY STAGE
The module contain the data ram that is used to store and load data and also set up the next incoming instruction depending on the flow of the program, **NORMALLY** the program counter 
gets the address of current instruction incremented by four, but due to some instructions the program counter may have different values such as an 12-bit offset, a totally different 
address or interrupt service routine address, for branches, control unit generates the desired flags and compares them to flags generated by the ALU, if they are equal the the branch 
address is taken, else we load the next instruction.  

# WRITE BACK STAGE 
This stage desides what data to write back to registers of the decode stage along with the address or it writes to the output register that may be used by the user.

# INTERRUPTS AND MY CUSTOM INSTRUCTIONS
Interrupts are not discussed widely in this ISA (at least i didn't find information) so i decided to design my own instructions for that.  

**INTERRUPT ENABLE INSTRUCTION:** it enables interrupt flag in control unit to accept interrupts, it is incoded as the JALR instruction but has different opcode. RD is used to store the 
address of the program counter of the interrupted instruction, RS1 and 12-bit immediate are used to generate the *INTERRUPT SERVICE ROUTINE* that is stored in MEMORY STAGE to be used 
uppon interrupting.  

If the internal interrupt flag is high and an interrupt is issued, it won't be acknowledged untill the instruction is executed and interrupt signal is still high, then the control unit 
enters the interrupt state where interrupt_acknoledged signal is high to enable the following :  
-PC recieves the interrupt service routine.  
-The interrupted instruction is stored in the register address specified in the interrupt enable instruction.  
-Internal interrupt flag is disabled.
After that the ISR is executed normally.  

**INTERRUPT DISABLE INSTRUCTION:** it disables interrupts so the signal will not affect the program flow.  

**INPUT DATA INSTRUCTION:** it is enoded as a load instruction but has different opcode and has source address1 as 0 because it reads user data into the ram.  

**OUTPUT DATA INSTRUCTION:** it is encoded as a store instruction but has different opcode and write address is 0 because it outputs data to the user.  
# RISC V ASSEMBLER 
The assembler is written in C++, the header file *"assembler_class"* provides the **assembler** class and the methods for converting 
assembly to machine code. The instruction can have no operands up to 3 operands.  
the following table organizes all the instructions:
| INSTRUCTION | ASSEMBLY FORMAT | DESCRIPTION |
|:-----------:|:---------------:|:-----------:|
|INTERRUPT_DISABLE|INTERRUPT_DISABLE|NO INTERRUPTS ARE CONSIDERED|
|JUMP AND LINK|JAL rd,20_bit_offset|rd=pc+4 , pc=pc+4+20_bit_OFFSET|
|ADD UPPER IMMEDIATE TO pc|AUIPC rd,upper_20_bit_offset|rd=pc+upper_20_bit_offset|
|LOAD UPPER IMMEDIATE|LUI rd,upper_20_bit_immediate|rd=upper_20_bit_immediate|
|MOVE INT TO FLOAT|FMV.W.X rd,rs|MOVE rs int REGISTER ADDRESS TO rd fp REGISTER ADDRESS WITHOUT CONVERSION |
|MOVE FLOAT TO INT|FMV.X.W rd,rs|MOVE rs fp REGISTER ADDRESS TO rd int REGISTER ADDRESS WITHOUT CONVERSION |
|CONVERT FLOAT TO INT|FMV.W.S rd,rs|CONVERT rs fp REGISTER ADDRESS TO rd signed int REGISTER ADDRESS|
|CONVERT INT TO FLOAT|FMV.S.W rd,rs|CONVERT rs signed int REGISTER ADDRESS TO rd fp REGISTER ADDRESS|
|MOVE fp VALUE|FMV rd,rs|MOVE FLOAT VALUE FROM rs FLOAT REGISTER ADDRESS to rd FLOAT REGISTER ADDRESS|
|GET NEGATIVE OF fp register|FNEG rd,rs|NEGATIVE VALUE OF FLOAT rs AND PUT IN rd IF ALREADY NEGATIVE, IT DOESN'T AFFECT|
|GET ABSOLUTE VALUE OF fp register|FABS rd,rs|ABSOLUTE VALUE OF FLOAT rs AND PUT IN rd|
|INPUT DATA FROM USER|IN_DATA rs,12_bit_offset|PUT READ DATA FROM USER IN RAM ADDRESS POINTER BY INTEGER rs+12_bit_offset|
|OUTPUT DATA TO USER|OUT_DATA rs,12_bit_offset|READ FROM RAM ADDRESS POINTER BY INTEGER rs+12_bit_offset TO USER|
|ADD INTEGERS|ADD rd,rs1,rs2|ADD rs1 AND rs2 THEN PUT IN rd|
|SUB INTEGERS|SUB rd,rs1,rs2|SUB rs1 AND rs2 THEN PUT IN rd|
|LOGICAL OR INTEGERS|OR rd,rs1,rs2|LOGICAL OR rs1 AND rs2 THEN PUT IN rd|
|LOGICAL AND INTEGERS|AND rd,rs1,rs2|LOGICAL AND rs1 AND rs2 THEN PUT IN rd|
|LOGICAL XOR INTEGERS|XOR rd,rs1,rs2|LOGICAL XOR rs1 AND rs2 THEN PUT IN rd|
|SHIFT LEFT LOGICAL|SLL rd,rs1,rs2|shift rs1 BY lower 5 bits of rs2 THEN PUT IN rd|
|SHIFT RIGHT LOGICAL|SRL rd,rs1,rs2|shift rs1 BY lower 5 bits of rs2 THEN PUT IN rd|
|SHIFT RIGHT ARITHMETIC|SRA rd,rs1,rs2|shift rs1 BY lower 5 bits of rs2 THEN PUT IN rd|
|SET LESS THAN|SLT rd,rs1,rs2|rd=1 when rs1<rs2 else rd=0 |
|SET LESS THAN UNSIGNED|SLTU rd,rs1,rs2|rd=1 when rs1<rs2 else rd=0 |
|ADD INTEGERS|ADDI rd,rs1,12_bit_immediate|ADD rs1 AND 12_bit_immediate THEN PUT IN rd|
|LOGICAL OR INTEGERS|ORI rd,rs1,12_bit_immediate|LOGICAL OR rs1 AND 12_bit_immediate THEN PUT IN rd|
|LOGICAL AND INTEGERS|ANDI rd,rs1,12_bit_immediate|LOGICAL AND rs1 AND 12_bit_immediate THEN PUT IN rd|
|LOGICAL XOR INTEGERS|XORI rd,rs1,12_bit_immediate|LOGICAL XOR rs1 AND 12_bit_immediate THEN PUT IN rd|
|SHIFT LEFT LOGICAL|SLLI rd,rs1,5_bit_immediate|SHIFT rs1 BY 5_bit_immediate THEN PUT IN rd|
|SHIFT RIGHT LOGICAL|SRLI rd,rs1,5_bit_immediate|SHIFT rs1 BY 5_bit_immediate THEN PUT IN rd|
|SHIFT RIGHT ARITHMETIC|SRAI rd,rs1,5_bit_immediate|SHIFT rs1 BY 5_bit_immediate THEN PUT IN rd|
|SET LESS THAN|SLTI rd,rs1,5_bit_immediate|rd=1 when rs1<5_bit_immediate else rd=0 |
|SET LESS THAN UNSIGNED|SLTIU rd,rs1,5_bit_immediate|rd=1 when rs1<5_bit_immediate else rd=0 |
|MULTIPLY INTEGER|MUL rd,rs1,rs2|MULTIPLY INTEGER AND PUT lower 32 BITS IN rd|
|MULTIPLY INTEGER|MULH rd,rs1,rs2|MULTIPLY INTEGER AND PUT UPPER 32 BITS IN rd|
|MULTIPLY INTEGER|MULHSU rd,rs1,rs2|MULTIPLY INTEGER rs1 SIGNED AND rs2 UNSIGNED AND PUT UPPER 32 BITS IN rd|
|MULTIPLY INTEGER|MULHU rd,rs1,rs2|MULTIPLY INTEGER UNSIGNED AND PUT UPPER 32 BITS IN rd|
|DIVIDE INTEGER|DIV rd,rs1,rs2|DIVIDE INTEGER  AND PUT IN rd|
|DIVIDE INTEGER|DIVU rd,rs1,rs2|DIVIDE INTEGER UNSIGNED AND PUT IN rd|
|REMAINDER INTEGER|REM rd,rs1,rs2|REMAINDER INTEGER  AND PUT IN rd|
|REMAINDER INTEGER|REMU rd,rs1,rs2|REMAINDER INTEGER UNSIGNED AND PUT IN rd|
|ADD FLOATS|FADD rd,rs1,rs2|ADD FLOATS rs1 AND rs2 AND PUT IN rd|
|MULTIPLY FLOATS|FMUL rd,rs1,rs2|MUL FLOATS rs1 AND rs2 AND PUT IN rd|
|DIVIDE FLOATS|FDIV rd,rs1,rs2|DIV FLOATS rs1 AND rs2 AND PUT IN rd|
|MAX OF FLOATS|FMAX rd,rs1,rs2|MAX OF FLOATS rs1 AND rs2 AND PUT IN rd|
|MIN OF FLOATS|FMAX rd,rs1,rs2|MIN OF FLOATS rs1 AND rs2 AND PUT IN rd|
|LOAD FLOAT|FLW rd,rs1,12_bit_offset|LOAD FLOAT FROM ADDRESS rs1+12_bit_offSet AND PUT IN rd|
|STORE FLOAT|FSW rd,rs1,12_bit_offset|STORE FLOAT IN ADDRESS rs1+12_bit_offSet AND PUT IN rd|
|BRANCH IF EQUAL|BEQ rs1,rs2,12_bit_offset|BRANCH IF rs1=rs2|
|BRANCH IF NOT EQUAL|BNEQ rs1,rs2,12_bit_offset|BRANCH IF rs1!=rs2|
|BRANCH IF LESS THAN|BLT rs1,rs2,12_bit_offset|BRANCH IF rs1<rs2|
|BRANCH IF LESS THAN|BLTU rs1,rs2,12_bit_offset|BRANCH IF rs1<rs2 UNSIGNED|
|BRANCH IF GREATER OR EQUAL|BGE rs1,rs2,12_bit_offset|BRANCH IF rs1>=rs2|
|BRANCH IF GREATER OR EQUAL|BGEU rs1,rs2,12_bit_offset|BRANCH IF rs1>=rs2 UNSIGNED|
|JUMP AND LINK REGISTER|JALR rd,rs1,12_bit_offset|rd=pc+4;pc=rs1+12_bit_offset|
|LOAD WORD|LW rd,rs1,12_bit_offset|PUT CONTENT OF ADDRESS RS1+12_bit_offset IN rd|
|STORE WORD|SW rs1,rs2,12_bit_offset|PUT rs1 IN ADDRESS=rs2+12_bit_offset|
|ENABLE INTERRUPT|INTERRUPT_ENBALE rd,rs1,12_bit_offset|PUT INTERRUPTED ADDRESS IN rd AND ISR=rs1+12_bit_offset|
