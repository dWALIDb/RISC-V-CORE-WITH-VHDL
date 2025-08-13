#include<stdio.h>
#include<string.h>
#include <stdlib.h>
#include <errno.h>

int main(int argc, char** argv){
    if(argc<3){
        printf("Please provide .bin file followed target memory size.\n");
        printf("It  automatically generates .mif file named mif_0.mif on the same path\n");
        return -1;
    }

    const int mem_size= atoi(argv[2]);
   
    FILE* bin_file =fopen(argv[1],"rb");
    if (bin_file==NULL)
    {
        perror("fopen");
        printf("Failed to open file CODE: %d :)\n",errno);
        return -1;
    }

    fseek(bin_file,0,SEEK_END);
    int size=ftell(bin_file);
    printf("FILE SIZE: %d\n" ,size);
    rewind(bin_file);
    
    unsigned char* read_data= (unsigned char *) malloc(sizeof(unsigned char)*size) ;
    fread(read_data,1,size,bin_file);
    fclose(bin_file);
    
    char line[256]={0};
    int pc=0;
    char path[256];

    sprintf(path,"./mif_0.mif");
    FILE* fw0=fopen(path,"w");
    
    sprintf(line,"DEPTH=%d;\nWIDTH=32;\nADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n[0..%d] : 00000000;\n",mem_size,mem_size-1);
    fwrite(line,1,strlen(line),fw0);
    
    line[0]=0x00;
    // memory is word addressable with byte enables making it flexible
    // so address 0 has 32 bits, then extra logic decides what bytes to read from/write to,
    for (int i = 0; i < size; i+=4,pc+=1)
    {
        // little endian shinanigans
        sprintf(line,"%d : %02x%02x%02x%02x ;\n",pc,read_data[i+3],read_data[i+2],read_data[i+1],read_data[i+0]);
        fwrite(line,1,strlen(line),fw0);
        line[0]=0x00;
    }
    sprintf(line,"END;");
    
    fwrite(line,1,strlen(line),fw0);
    
    fclose(fw0);
 
    free(read_data);
}