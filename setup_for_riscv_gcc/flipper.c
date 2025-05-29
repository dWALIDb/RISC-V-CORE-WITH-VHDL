#include<stdio.h>
#include<string.h>
#include <stdlib.h>
#include <errno.h>

int main(){
    FILE* f =fopen("C:\\Users\\DELL\\Desktop\\xpack_RISCV_gcc\\newfirst.bin","rb");
    if (f==NULL)
    {
        perror("fopen");
        printf("Failed to open file CODE: %d :)",errno);
    }

    fseek(f,0,SEEK_END);
    int size=ftell(f);
    printf("FILE SIZE: %d\n" ,size);
    rewind(f);
    
    unsigned char* a= (unsigned char *) malloc(sizeof(unsigned char)*size) ;
    int read_bytes=fread(a,1,size,f);
    fclose(f);
    
    char line[256]={0};
    int pc=0;

    FILE* fw0=fopen("C:\\Users\\DELL\\Desktop\\xpack_RISCV_gcc\\mif_0.mif","w");
    FILE* fw=fopen("C:\\Users\\DELL\\Desktop\\xpack_RISCV_gcc\\instructions.txt","w");
    
    sprintf(line,"DEPTH=256;\nWIDTH=8;\nADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n[0..255] : 00;\n");
    fwrite(line,1,84,fw0);
    line[0]=0;
    for (int i = 0; i < size; i+=1,pc+=1)
    {
        sprintf(line,"%d : %02x ;\n",pc,a[i]);
        fwrite(line,1,strlen(line),fw0);
        
        for (int j = i; (j-i) < 4; j++)
        {            
            for (int k = 0; k < 8; k++)
            { 
                sprintf(line,"%x",(((a[j]<<k)& 0x80)>>7));
                fwrite(line,1,1,fw);
            }
            fwrite("\n",1,1,fw);   
        }
        // printf("%02x %02x %02x %02x\n",a[i+3],a[i+2],a[i+1],a[i+0]);    
        line[0]=0;
    }
    sprintf(line,"END;");
    
    fwrite(line,1,4,fw0);
    
    fclose(fw0);
    free(a);
}