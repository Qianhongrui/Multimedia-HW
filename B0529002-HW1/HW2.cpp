#include <math.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include <fstream>
  
using namespace std;
using std::string;
using std::fstream;
typedef struct wave_t{
  char        RIFF[4];    // RIFF Header   Magic header
  unsigned long    ChunkSize;   // RIFF Chunk Size 
  char        WAVE[4];    // WAVE Header   
  char        Format[4];     // FMT header 
  char          ChunkID[4]; 
  unsigned long    Subchunk1Size; // Size of the fmt chunk                
  unsigned short   AudioFormat;  // Audio format 1=PCM,6=mulaw,7=alaw, 257=IBM Mu-Law, 258=IBM A-Law, 259=ADPCM 
  unsigned short   NumChannels;   // Number of channels 1=Mono 2=Sterio          
  unsigned long    SampleRate; // Sampling Frequency in Hz               
  unsigned long    ByteRate;  // bytes per second 
  unsigned short   BlockAlign;   // 2=16-bit mono, 4=16-bit stereo 
  unsigned short   BitsPerSample; // Number of bits per sample   
  char        Subchunk2ID[4]; // "data" string  
  char        Subchunk1ID[4]; // "data" string  
  unsigned long    Subchunk2Size; // Sampled data length  
  
}wav_hdr; 
double* DCT(char *buff,int buffsize); 
char* IDCT(double *buff,int buffsize);
int main(void)
{
        int i;
        int cnt=0;
        char right,left;
        int size=32;
        char buff[size],nbuff[size];
        char ddd[100];
        unsigned char ttt[100];
        FILE *fp1,*fp2,*fp3;
        wave_t input;
        fp1=fopen("Nello.wav","rb");
        fp2=fopen("tmp.txt","w+");
        fp3=fopen("b.wav","wb");
        fprintf(fp2,"left\tright\n");
        printf("read header\n");
        ///////read header///////////
        fread(&input.ChunkID,4,1,fp1);
        fread(&input.ChunkSize,4,1,fp1);
        fread(&input.Format,4,1,fp1);
        fread(&input.Subchunk1ID,4,1,fp1);
        fread(&input.Subchunk1Size,4,1,fp1);
        fread(&input.AudioFormat,2,1,fp1);
        fread(&input.NumChannels,2,1,fp1);
        fread(&input.SampleRate,4,1,fp1);
        fread(&input.ByteRate,4,1,fp1);
        fread(&input.BlockAlign,2,1,fp1);
        fread(&input.BitsPerSample,2,1,fp1);
        fread(&input.Subchunk2ID,4,1,fp1);
        fread(&input.Subchunk2Size,4,1,fp1);
        printf("size is %d bytes \n",input.Subchunk2Size);
        printf(" %d Channels \n",input.NumChannels);
        printf("read data\n");

        ////////write header/////////////
        fwrite(&input.ChunkID,4,1,fp3);
        fwrite(&input.ChunkSize,4,1,fp3);
        fwrite(&input.Format,4,1,fp3);
        fwrite(&input.Subchunk1ID,4,1,fp3);
        fwrite(&input.Subchunk1Size,4,1,fp3);
        fwrite(&input.AudioFormat,2,1,fp3);
        fwrite(&input.NumChannels,2,1,fp3);
        fwrite(&input.SampleRate,4,1,fp3);
        fwrite(&input.ByteRate,4,1,fp3);
        fwrite(&input.BlockAlign,2,1,fp3);
        fwrite(&input.BitsPerSample,2,1,fp3);
        fwrite(&input.Subchunk2ID,4,1,fp3);
        fwrite(&input.Subchunk2Size,4,1,fp3);


        ////////copy audio raw data/////////////
        for(i=0;i<input.Subchunk2Size;i+=size){
                fread(&buff,size,1,fp1);

                
                fwrite(&buff,size,1,fp3);
        }

        printf("%d\n",cnt);
        printf("end\n");
        fclose(fp1);
        fclose(fp2);
        fclose(fp3);
        return 0;
}
double* DCT(char *buff,int buffsize){
	char nbuff[32];
	double ibuff[32],nibuff[32];
	double temp=0,C,N=buffsize;
	for(int i=0;i<buffsize;i++){
		ibuff[i]=(double)buff[i]-48;
	}
	for(int i=0;i<buffsize;i++){
		if(i==0)
			C=sqrt(2)/2;
		else
			C=1;
		for(int j=0;j<buffsize;j++){
			temp+=cos((2*j+1)*i*M_PI/2/N)*ibuff[j];
		}
	
		nibuff[i]=C/sqrt(N/2)*temp;
	}
	/*for(int i=0;i<buffsize;i++){
		nbuff[i]=nibuff[i]+48;
	}*/
	
	return ibuff;
}
char* IDCT(double *buff,int buffsize){
	char nbuff[32];
	double ibuff[32],nibuff[32];
	double temp=0,C,N=buffsize;
	for(int i=0;i<buffsize;i++){
		for(int j=0;j<buffsize;j++){
			if(j==0)
				C=sqrt(2)/2;
			else
				C=1;
		
			temp+=C/sqrt(N/2)*cos((2*i+1)*j*M_PI/2/N)*buff[j];
		
		}
			nibuff[i]=temp;
	
	}
	for(int i=0;i<buffsize;i++){
		nbuff[i]=buff[i]+48;
	}
	return nbuff;
}
