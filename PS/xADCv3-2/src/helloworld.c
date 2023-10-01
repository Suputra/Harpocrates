#include "xparameters.h"
#include "xadcps.h"
#include "xstatus.h"
#include "stdio.h"
#include "xil_printf.h"

#define XADC_DEVICE_ID                                    XPAR_XADCPS_0_DEVICE_ID

#define printf xil_printf /* Small foot-print printf function */


static XAdcPs XAdcInst;      /* XADC driver instance */


int main(void)
{
	  print("Hello World");
	  XAdcPs_Config *ConfigPtr;
	  u32 VccPdroRawData;
	  float VccPintData;

	  float scalar;

	  XAdcPs *XAdcInstPtr = &XAdcInst;

	  ConfigPtr = XAdcPs_LookupConfig(XADC_DEVICE_ID);
	  if (ConfigPtr == NULL) {
								   return XST_FAILURE;
	  }

	  scalar = 1000 * 0.8 / 2.4;

	  XAdcPs_CfgInitialize(XAdcInstPtr, ConfigPtr,
																																													ConfigPtr->BaseAddress);


	  XAdcPs_SetSequencerMode(XAdcInstPtr, XADCPS_SEQ_MODE_CONTINPASS);//XADCPS_SEQ_MODE_SAFE);



	  while (1)
		{
			   VccPdroRawData = XAdcPs_GetAdcData(XAdcInstPtr, XADCPS_CH_VPVN);
			   VccPintData = XAdcPs_RawToVoltage(VccPdroRawData) * scalar;
			   printf("\r\n%0d",(int)(VccPintData));
			   //printf("%03d \r\n",VccPdroRawData);

			   //for(int i = 0; i < 10; i\+\+);

		}


	  xil_printf("Successfully ran adcps polled printf Example\r\n");
	  return XST_SUCCESS;
}
