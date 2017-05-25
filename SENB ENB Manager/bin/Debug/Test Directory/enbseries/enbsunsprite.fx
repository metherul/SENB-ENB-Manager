//	K ENB Extensive Shaders  
//	Extensive Sunsprite Shader 
//	Code modifications by KYO aka Oyama w/some help from Boris ;)
//	Sunglare Technique Vertex Codes by Matso
//	Initial Lens Distortion Code by IceLaGlace
//	Sunglare and Lens Textures by --JawZ--
//	Copyright (c) 2007-2013 Boris Vorontsov
//	Hexagons and High Dispersion Sunglare
//
//	KYO : * DISABLE * USE_SUNGLARE below if using another .tga texture

//====================================================================================================
//	Internal parameters covering all Techniques
//====================================================================================================

float	fLensIntensity
<
	string UIName="Lens Intensity";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.050};

float	fLensScaleFactor
<
	string UIName="Lens Scale Factor";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.100};

//#define	 fLensIntensity		0.150	//Will affect all Lenses and all Draw Techniques at once		
//#define	 fLensScaleFactor	0.288	//Will affect all Lenses and all Draw techniques at once		

//1.0, 0.75, 0.66, 0.5, 0.25, 0.33, 0.322, so on


//====================================================================================================
//	Usefull Constants
//====================================================================================================

#define PI			3.1415926535897932384626433832795


//====================================================================================================
//	Enable / Disable full lines of lenses a/o Sunglare 
//	1 to enable, 0 to disable
//	Choose 1 PRIMARY method *ONLY* at a time
//====================================================================================================

#define USE_PRIMARY				1	//11 Lenses w/Color variations		
#define USE_PRIMARY_ALT				0	//18 Lenses w/Color Variations
#define USE_PRIMARY_ALT_2			0	//4  Lenses w/Color Variations

#define USE_SUNGLARE				1	//3  Lenses w/Color Variations //* disable for other .tga textures *

#define	USE_SECONDARY				1	//11 Lenses	
#define USE_SECONDARY_2				0	//11 Lenses	

#define USE_THIRDARY				0	//11 Lenses	
#define USE_THIRDARY_2				0	//11 Lenses	

#define USE_FOURTH				1	//3 Lenses w/Color Variations	
#define USE_FOURTH_2				1	//3 Lenses w/Color Variations


//====================================================================================================
//	Enable / Disable Time-Related Sunglare Dispersion Rays Length 
//	1 to enable, 0 to disable
//====================================================================================================

#define USE_DISPERSION_BOOST		0			
#define	fBoost_Sunglare			1.0					


//====================================================================================================
//	Enable / Disable Lens Distortions w/Chromatic Aberration on Edges 
//	Pointless for Sunglare
//	1 to enable, 0 to disable
//	Positive Distortions will "compact" Lenses'Edges, making them "rounder"
//	Negative Distortions will "enlarge" Lenses'Edges, making them "harder"
//	Doing so, positive will decrease size, negative will increase
//	Compensate both effects via LensSize
//	If using positive distortion, increase LensSize to compensate
//	If using negative distortion, decrease LensSize to compensate
//====================================================================================================

#define	USE_LENS_DISTORTIONS_PRIMARY		1
#define	USE_LENS_DISTORTIONS_PRIMARY_ALT	1
#define	USE_LENS_DISTORTIONS_PRIMARY_ALT_2	1

#define	USE_LENS_DISTORTIONS_SECONDARY		1
#define	USE_LENS_DISTORTIONS_SECONDARY_2	1

#define	USE_LENS_DISTORTIONS_THIRDARY		1
#define	USE_LENS_DISTORTIONS_THIRDARY_2		1

#define	USE_LENS_DISTORTIONS_FOURTH		1
#define	USE_LENS_DISTORTIONS_FOURTH_2		1

#define USE_CHROMA_FORMULA_PRIMARY		7	//[Choose from 1 to 7]
#define USE_CHROMA_FORMULA_PRIMARY_ALT		1	//[Choose from 1 to 7]
#define USE_CHROMA_FORMULA_PRIMARY_ALT_2	1	//[Choose from 1 to 7]

#define USE_CHROMA_FORMULA_SECONDARY		7	//[Choose from 1 to 7]
#define USE_CHROMA_FORMULA_SECONDARY_2		7	//[Choose from 1 to 7]

#define USE_CHROMA_FORMULA_THIRDARY		1	//[Choose from 1 to 7]
#define USE_CHROMA_FORMULA_THIRDARY_2		1	//[Choose from 1 to 7]

#define USE_CHROMA_FORMULA_FOURTH		1	//[Choose from 1 to 7]
#define USE_CHROMA_FORMULA_FOURTH_2		2	//[Choose from 1 to 7]

//====================================================================================================
//	PRIMARY 
#define fChromaticAmount_Primary		0.275 	
#define fLensSize_Primary			0.775  	// 0.5 = Original Size
#define fLensDistortion_Primary			2.0   	
#define fLensDistortionCubic_Primary		0.0

//====================================================================
//	PRIMARY_ALT 
#define fChromaticAmount_Primary_Alt		0.35 	
#define fLensSize_Primary_Alt			0.75   	
#define fLensDistortion_Primary_Alt		2.0   	
#define fLensDistortionCubic_Primary_Alt	0.0

//====================================================================
//	PRIMARY_ALT_2
#define fChromaticAmount_Primary_Alt_2		0.25 	
#define fLensSize_Primary_Alt_2			0.7   
#define fLensDistortion_Primary_Alt_2		1.75  	
#define fLensDistortionCubic_Primary_Alt_2	0.2

//====================================================================
//	SECONDARY 
#define fChromaticAmount_Secondary		0.25 	
#define fLensSize_Secondary			0.5   	
#define fLensDistortion_Secondary		0.0   	
#define fLensDistortionCubic_Secondary		0.0

//====================================================================
//	SECONDARY_2 
#define fChromaticAmount_Secondary_2		0.25 	
#define fLensSize_Secondary_2			0.5   	
#define fLensDistortion_Secondary_2		0.0   	
#define fLensDistortionCubic_Secondary_2	0.0

//====================================================================
//	THIRDARY
#define fChromaticAmount_Thirdary		0.25 	
#define fLensSize_Thirdary			0.5   	
#define fLensDistortion_Thirdary		0.0   	
#define fLensDistortionCubic_Thirdary		0.0

//====================================================================
//	THIRDARY_2
#define fChromaticAmount_Thirdary_2		0.25 	
#define fLensSize_Thirdary_2			0.5   	
#define fLensDistortion_Thirdary_2		0.0   	
#define fLensDistortionCubic_Thirdary_2		0.0

//====================================================================
//	FOURTH 
#define fChromaticAmount_Fourth			0.25 	
#define fLensSize_Fourth			0.7   	
#define fLensDistortion_Fourth			2.0  	
#define fLensDistortionCubic_Fourth		0.0

//====================================================================
//	FOURTH_2 
#define fChromaticAmount_Fourth_2		0.25 	
#define fLensSize_Fourth_2			0.75   	
#define fLensDistortion_Fourth_2		2.1   	
#define fLensDistortionCubic_Fourth_2		0.0


//====================================================================================================
//	Enable / Disable RGB Variations
//	RGB components vary accordingly to R/G/B multipliers below in Individual Parameters
//	1 to enable, 0 to disable
//====================================================================================================

#define USE_RGB_VARIATIONS_PRIMARY		1		
#define	USE_RGB_VARIATIONS_PRIMARY_ALT		1
#define	USE_RGB_VARIATIONS_PRIMARY_ALT_2	1
	
#define USE_RGB_VARIATIONS_SUNGLARE		1

#define	USE_RGB_VARIATIONS_FOURTH		1
#define	USE_RGB_VARIATIONS_FOURTH_2		1


//====================================================================================================
//	Enable / Disable Time-Related Variable Scales 
//	1 to enable, 0 to disable
//	Higher is Faster
//====================================================================================================

#define	USE_SCALE_VARIATIONS__PRIMARY			1
#define	fScaleTimeFactor_Primary			60.0
	
#define	USE_SCALE_VARIATIONS__PRIMARY_ALT		1
#define	fScaleTimeFactor_Primary_Alt			80.0
	
#define	USE_SCALE_VARIATIONS__PRIMARY_ALT_2		1
#define	fScaleTimeFactor_Primary_Alt_2			60.0
	
#define	USE_SCALE_VARIATIONS__SUNGLARE			1
#define	fScaleTimeFactor_Sunglare			60.0

#define	USE_SCALE_VARIATIONS__SECONDARY			1
#define	fScaleTimeFactor_Secondary			70.0

#define	USE_SCALE_VARIATIONS__SECONDARY_2		1
#define	fScaleTimeFactor_Secondary_2			70.0

#define	USE_SCALE_VARIATIONS__THIRDARY			1
#define	fScaleTimeFactor_Thirdary			60.0

#define	USE_SCALE_VARIATIONS__THIRDARY_2		1
#define	fScaleTimeFactor_Thirdary_2			60.0

#define	USE_SCALE_VARIATIONS__FOURTH			1
#define	fScaleTimeFactor_Fourth				120.0

#define	USE_SCALE_VARIATIONS__FOURTH_2			1
#define	fScaleTimeFactor_Fourth_2			90.0			


//====================================================================================================
//	Enable / Disable Time-Related Variable Intensities
//	1 to enable, 0 to disable
//	Higher is Faster
//	* NOTE * : DON'T USE VARIABLE INTENSITIES AND LIGHT EMULATION AT THE SAME TIME FOR SAME TARGET
//====================================================================================================

#define	USE_INTENSITY_VARIATIONS_PRIMARY		1
#define	fIntTimeFactor_Primary				60.0

#define	USE_INTENSITY_VARIATIONS_PRIMARY_ALT		1
#define	fIntTimeFactor_Primary_Alt			60.0

#define	USE_INTENSITY_VARIATIONS_PRIMARY_ALT_2		1
#define	fIntTimeFactor_Primary_Alt_2			60.0

#define	USE_INTENSITY_VARIATIONS_SUNGLARE		0
#define	fIntTimeFactor_Sunglare				60.0

#define	USE_INTENSITY_VARIATIONS_SECONDARY		0
#define	fIntTimeFactor_Secondary			70.0

#define	USE_INTENSITY_VARIATIONS_SECONDARY_2		1
#define	fIntTimeFactor_Secondary_2			70.0

#define	USE_INTENSITY_VARIATIONS_THIRDARY		0
#define	fIntTimeFactor_Thirdary				60.0

#define	USE_INTENSITY_VARIATIONS_THIRDARY_2		0
#define	fIntTimeFactor_Thirdary_2			60.0

#define	USE_INTENSITY_VARIATIONS_FOURTH			1
#define	fIntTimeFactor_Fourth				80.0

#define	USE_INTENSITY_VARIATIONS_FOURTH_2		1
#define	fIntTimeFactor_Fourth_2				50.0


//====================================================================================================
//	Enable / Disable Light Emulation (Flashes or Pulses) 
//	1 to enable, 0 to disable 
//	Set Low Velocity for Pulses, High Velocity for Flashes
//	0.0 to 1000.0 = Low
//	0.0 to 10000.0 = Medium
//	10000.0 and beyond = High
//	* NOTE * : DON'T USE LIGHT EMULATION AND VARIABLE INTENSITIES AT THE SAME TIME FOR SAME TARGET
//====================================================================================================
	
#define	USE_LIGHT_PRIMARY		0
#define	USE_LIGHT_PRIMARY_ALT		0	
#define	USE_LIGHT_PRIMARY_ALT_2		0

#define	USE_LIGHT_SUNGLARE		1

#define	USE_LIGHT_SECONDARY		0
#define	USE_LIGHT_SECONDARY_2		0
	
#define	USE_LIGHT_THIRDARY		0	
#define	USE_LIGHT_THIRDARY_2		0	

#define	USE_LIGHT_FOURTH		0	
#define	USE_LIGHT_FOURTH_2		0


#define	fLightVelocity_Primary		2.0
#define	fLightVelocity_Primary_Alt	2.0
#define	fLightVelocity_Primary_Alt_2	2.0

/**
 *	Set high value for Velocity here and do NOT intervene on second part
 */	
#define	fLightVelocity_Sunglare 	12000.0 + abs(frac(Timer.x * 20000.0)* 2.0 - 1.0)	

#define fLightVelocity_Secondary	20.0
#define fLightVelocity_Secondary_2	20.0			
					
#define fLightVelocity_Thirdary		40.0			
#define	fLightVelocity_Thirdary_2	20.0

#define fLightVelocity_Fourth		40.0			
#define	fLightVelocity_Fourth_2		20.0


//====================================================================================================
//	Enable / Disable Depth-Like Motion, full lines of Lenses 
//	Motion from Eye to Sun and back
//	1 to enable, 0 to disable
//	Higher is Faster
//====================================================================================================
	
#define USE_MOTION_PRIMARY		1
#define USE_MOTION_PRIMARY_ALT		1
#define USE_MOTION_PRIMARY_ALT_2	1

#define USE_MOTION_SUNGLARE		0

#define	USE_MOTION_SECONDARY		1
#define USE_MOTION_SECONDARY_2		1
		
#define USE_MOTION_THIRDARY		1	
#define USE_MOTION_THIRDARY_2		1	

#define USE_MOTION_FOURTH		1	
#define USE_MOTION_FOURTH_2		1	
	

#define	fVelocity_Primary		40.0
#define	fVelocity_Primary_Alt		50.0
#define	fVelocity_Primary_Alt_2		50.0

#define	fVelocity_Sunglare		200.0

#define	fVelocity_Secondary		35.0
#define	fVelocity_Secondary_2		35.0

#define	fVelocity_Thirdary		35.0
#define	fVelocity_Thirdary_2		35.0

#define	fVelocity_Fourth		50.0
#define	fVelocity_Fourth_2		45.0
	

//====================================================================================================
//	Enable / Disable Primary a/o Primary_Alt, Alt_2, etc... Per-Lenses Depth-Like Motion 
//	1 to enable, 0 to disable 
//	Positive = from Sun to Eye, Negative = from Eye to Sun
//====================================================================================================

#define	USE_LENSMOTION_PRIMARY	1	

#define	fMotionVelocity_Lens26		-60.0	
#define	fMotionVelocity_Lens27		100.0
#define	fMotionVelocity_Lens28		-60.0
#define	fMotionVelocity_Lens29		60.0
#define	fMotionVelocity_Lens30		-60.0
#define	fMotionVelocity_Lens31		60.0
#define	fMotionVelocity_Lens32		-40.0
#define	fMotionVelocity_Lens33		80.0
#define	fMotionVelocity_Lens34		-120.0
#define	fMotionVelocity_Lens35		100.0
#define	fMotionVelocity_Lens36		-100.0

#define	USE_LENSMOTION_PRIMARY_ALT	1	

#define	fMotionVelocity_Lens59		-60.0	
#define	fMotionVelocity_Lens60		40.0
#define	fMotionVelocity_Lens61		-60.0
#define	fMotionVelocity_Lens62		80.0
#define	fMotionVelocity_Lens63		-100.0
#define	fMotionVelocity_Lens64		60.0
#define	fMotionVelocity_Lens65		-40.0
#define	fMotionVelocity_Lens66		80.0
#define	fMotionVelocity_Lens67		-80.0
#define	fMotionVelocity_Lens68		80.0
#define	fMotionVelocity_Lens69		-100.0
#define	fMotionVelocity_Lens70		-60.0	
#define	fMotionVelocity_Lens71		60.0
#define	fMotionVelocity_Lens72		-80.0
#define	fMotionVelocity_Lens73		80.0
#define	fMotionVelocity_Lens74		-60.0
#define	fMotionVelocity_Lens75		80.0
#define	fMotionVelocity_Lens76		-60.0

#define	USE_LENSMOTION_PRIMARY_ALT_2	1

#define	fMotionVelocity_Lens77		-20.0	
#define	fMotionVelocity_Lens78		20.0
#define	fMotionVelocity_Lens79		-20.0
#define	fMotionVelocity_Lens80		20.0	


//====================================================================================================
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//	Internal Techniques Parameters - These affect whole lines
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//====================================================================================================
//	Scale multiply / compensate
//	Intensity multiply / compensate
//	Contrast - More is stronger opacity, also depends on Sun Intensity
//	Line Horizontal Position - Negative values will displace to left, Positive to right
//	Line Vertical Position - Negative values will displace to down, Positive to up 
//	0.0 HPos is neutral, equal to Primaries
//====================================================================================================

//	PRIMARY 

#define fScalePrimary			0.855		
#define fIntensityPrimary		1.0		
#define fContrastPrimary		1.0
#define fHPosPrimary			0.0
#define fVPosPrimary			0.0

//	PRIMARY_ALT

#define fScalePrimary_Alt		1.145		
#define fIntensityPrimary_Alt		0.985		//1.045
#define fContrastPrimary_Alt		0.9		//1.2
#define fHPosPrimary_Alt		0.0		
#define fVPosPrimary_Alt		0.25		//1.0 Displace	//0.25 Slight Displace	

//	PRIMARY_ALT_2

#define fScalePrimary_Alt_2		1.2		
#define fIntensityPrimary_Alt_2		1.2
#define fContrastPrimary_Alt_2		1.05
#define fHPosPrimary_Alt_2		0.0		
#define fVPosPrimary_Alt_2		0.0

//===========================================
//	SUNGLARE 

float	fScaleSunglare
<
	string UIName="Sunglare Scale";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.000;
	float UIMax=5.0;
> = {0.050};

float	fIntensitySunglare
<
	string UIName="Sunglare Intensity";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.000;
	float UIMax=5.0;
> = {0.050};

float	fContrastSunglare
<
	string UIName="Sunglare Contrast";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.000;
	float UIMax=5.0;
> = {0.100};

//#define fScaleSunglare			1.0	
//#define fIntensitySunglare		0.865	
//#define fContrastSunglare		1.025		//1.1 
#define fHPosSunglare			0.0
#define fVPosSunglare			0.0

//===========================================
//	SECONDARY 

#define fScaleSecondary			0.235  		//0.215		
#define fIntensitySecondary		0.725		
#define fContrastSecondary		1.1		
#define fHPosSecondary			9.0		
#define fVPosSecondary			-10.0	

//	SECONDARY_2 

#define fScaleSecondary_2		0.215
#define fIntensitySecondary_2		0.745
#define fContrastSecondary_2		1.1	
#define fHPosSecondary_2		-9.0		
#define fVPosSecondary_2		10.0		

//===========================================
//	THIRDARY 

#define fScaleThirdary			0.245		
#define fIntensityThirdary		1.05			
#define fContrastThirdary		1.2
#define fHPosThirdary			-50.0		
#define fVPosThirdary			50.0	

//	THIRDARY_2 

#define fScaleThirdary_2		0.245		
#define fIntensityThirdary_2		1.135			
#define fContrastThirdary_2		1.2
#define fHPosThirdary_2			50.0		
#define fVPosThirdary_2			50.0	

//===========================================
//	FOURTH 

#define fScaleFourth			0.625		
#define fIntensityFourth		0.875			
#define fContrastFourth			1.0
#define fHPosFourth			2.65		
#define fVPosFourth			2.35	

//	FOURTH_2 

#define fScaleFourth_2			1.015		
#define fIntensityFourth_2		1.025			
#define fContrastFourth_2		1.0
#define fHPosFourth_2			-2.0		
#define fVPosFourth_2			-0.5


//====================================================================================================
//	Internal Individual Parameters for SECONDARY
//	Offset, Scale, Scale Factor, Color RGB, Color Multiplier
//	RGB balance will also act as a separate intensity control for each Lens 
//	1.0, 1.0, 1.0 is full intensity / opacity
//	If color components are below 1.0, Lens is losing opacity
//	Counterbalance it by increasing f#_ColorMultiplier over 1.0		
//====================================================================================================

//Lens #1
#define f1_LensOffset		-0.8				//Sun to Eye	
#define f1_LensScale		0.083				//Size
#define f1_LensFactor		1.0				//Multiplier for Size
#define	f1_LensColor		float3(0.85, 0.85, 0.50)	//Color in RGB 
#define	f1_ColorMultiplier	1.0				//Color Multiplier

//Lens #2
#define f2_LensOffset		-0.47	
#define f2_LensScale		0.166
#define f2_LensFactor		1.0	
#define	f2_LensColor		float3(1.00, 0.95, 0.35)	
#define	f2_ColorMultiplier	1.0

//Lens #3
#define f3_LensOffset		-0.14	
#define f3_LensScale		0.212
#define f3_LensFactor		1.0
#define	f3_LensColor		float3(1.0, 1.0, 1.0)	
#define	f3_ColorMultiplier	1.0

//Lens #4
#define f4_LensOffset		0.14	
#define f4_LensScale		0.249
#define f4_LensFactor		0.75	
#define	f4_LensColor		float3(0.25, 1.0, 0.75)	
#define	f4_ColorMultiplier	1.2

//Lens #5
#define f5_LensOffset		0.47	
#define f5_LensScale		0.332
#define f5_LensFactor		1.0	
#define	f5_LensColor		float3(1.0, 0.75, 0.25)
#define	f5_ColorMultiplier	1.7

//Lens #6
#define f6_LensOffset		0.8	
#define f6_LensScale		0.415
#define f6_LensFactor		0.75	
#define	f6_LensColor		float3(0.90, 0.30, 0.75)	
#define	f6_ColorMultiplier	1.0

//Lens #7
#define f7_LensOffset		1.13	
#define f7_LensScale		0.498
#define f7_LensFactor		1.0	
#define	f7_LensColor		float3(1.0, 0.70, 0.30)
#define	f7_ColorMultiplier	1.2

//Lens #8
#define f8_LensOffset		1.46	
#define f8_LensScale		0.581
#define f8_LensFactor		0.5	
#define	f8_LensColor		float3(0.25, 0.95, 0.45)	
#define	f8_ColorMultiplier	1.5

//Lens #9
#define f9_LensOffset		1.79	
#define f9_LensScale		0.581
#define f9_LensFactor		0.85	
#define	f9_LensColor		float3(1.0, 1.0, 1.0)	
#define	f9_ColorMultiplier	1.1

//Lens #10
#define f10_LensOffset		2.12	
#define f10_LensScale		0.581
#define f10_LensFactor		1.0	
#define	f10_LensColor		float3(0.85, 0.55, 0.85)	
#define	f10_ColorMultiplier	1.0

//Lens #11
#define f11_LensOffset		2.43	
#define f11_LensScale		0.664
#define f11_LensFactor		1.11	
#define	f11_LensColor		float3(0.85, 0.85, 0.32)
#define	f11_ColorMultiplier	1.1


//Add or Remove additional Lenses controls here, as done above

//====================================================================================================
//	Internal Individual parameters for SUNGLARE 
//	Time-Related RGB Multipliers
//	f#_R is Lens red multiplier, f#_G is green, f#_B is blue
//====================================================================================================

#if (USE_RGB_VARIATIONS_SUNGLARE == 1)

//Lens #12	
#define	f12_LensScale		0.11
#define	f12_LensColor		float3(1.0 + abs(frac(Timer.x * f12_R)* 2.0 - 1.0), 0.90 + abs(frac(Timer.x * f12_G)* 2.0 - 1.0), 0.30 + abs(frac(Timer.x * f12_B)* 2.0 - 1.0))
#define	f12_ColorMultiplier 	1.1
#define f12_R			2000.0		
#define f12_G			6000.0
#define f12_B			200.0

//Lens #13
#define f13_LensScale		0.33
#define	f13_LensColor		float3(0.25 + abs(frac(Timer.x * f13_R)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f13_G)* 2.0 - 1.0), 0.25 + abs(frac(Timer.x * f13_B)* 2.0 - 1.0))	
#define	f13_ColorMultiplier 	1.0
#define f13_R			2000.0		
#define f13_G			600.0
#define f13_B			200.0

//Lens #14
#define f14_LensScale		0.66 
#define	f14_LensColor		float3(0.85 + abs(frac(Timer.x * f14_R)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f14_G)* 2.0 - 1.0), 0.30 + abs(frac(Timer.x * f14_B)* 2.0 - 1.0))	
#define	f14_ColorMultiplier 	1.0
#define f14_R			6000.0		
#define f14_G			7000.0
#define f14_B			200.0


#else


//Lens #12
#define	f12_LensScale		0.11
#define	f12_LensColor		float3(1.0, 0.90, 0.30)
#define	f12_ColorMultiplier 	1.1

//Lens #13
#define f13_LensScale		0.33
#define	f13_LensColor		float3(1.0, 1.0, 1.0)	
#define	f13_ColorMultiplier 	1.0

//Lens #14
#define f14_LensScale		0.66 
#define	f14_LensColor		float3(1.0, 1.0, 1.0)	
#define	f14_ColorMultiplier 	1.0

#endif


//KYO : add a/o remove passes of technique below

//====================================================================================================
//	Internal Individual parameters for SECONDARY 2
//====================================================================================================

//Lens #15
#define f15_LensOffset		-0.8				//Sun to Eye	
#define f15_LensScale		0.083				//Size 
#define f15_LensFactor		1.0				//Multiplier for Size	
#define	f15_LensColor		float3(0.75, 0.75, 0.50)	//Color in RGB 	
#define	f15_ColorMultiplier	1.0				//Color Multiplier

//Lens #16
#define f16_LensOffset		-0.47	
#define f16_LensScale		0.166
#define f16_LensFactor		1.0	
#define	f16_LensColor		float3(0.85, 0.65, 0.85)	
#define	f16_ColorMultiplier	1.0

//Lens #17
#define f17_LensOffset		-0.14	
#define f17_LensScale		0.212
#define f17_LensFactor		1.0
#define	f17_LensColor		float3(1.0, 1.0, 1.0)	
#define	f17_ColorMultiplier	1.0

//Lens #18
#define f18_LensOffset		0.14	
#define f18_LensScale		0.249
#define f18_LensFactor		0.75	
#define	f18_LensColor		float3(0.25, 1.0, 0.75)	
#define	f18_ColorMultiplier	1.0

//Lens #19
#define f19_LensOffset		0.47	
#define f19_LensScale		0.332
#define f19_LensFactor		1.0	
#define	f19_LensColor		float3(1.0, 0.85, 0.22)
#define	f19_ColorMultiplier	2.0

//Lens #20
#define f20_LensOffset		0.8	
#define f20_LensScale		0.415
#define f20_LensFactor		0.75	
#define	f20_LensColor		float3(0.90, 0.30, 0.75)	
#define	f20_ColorMultiplier	1.0

//Lens #21
#define f21_LensOffset		1.13	
#define f21_LensScale		0.498
#define f21_LensFactor		1.0	
#define	f21_LensColor		float3(1.0, 1.0, 1.0)
#define	f21_ColorMultiplier	1.0

//Lens #22
#define f22_LensOffset		1.46	
#define f22_LensScale		0.581
#define f22_LensFactor		0.5	
#define	f22_LensColor		float3(0.25, 0.95, 0.45)	
#define	f22_ColorMultiplier	1.5

//Lens #23
#define f23_LensOffset		1.79	
#define f23_LensScale		0.581
#define f23_LensFactor		0.85	
#define	f23_LensColor		float3(1.0, 1.0, 1.0)	
#define	f23_ColorMultiplier	1.0

//Lens #24
#define f24_LensOffset		2.12	
#define f24_LensScale		0.581
#define f24_LensFactor		1.0	
#define	f24_LensColor		float3(0.95, 0.55, 0.85)	
#define	f24_ColorMultiplier	1.0

//Lens #25
#define f25_LensOffset		2.43	
#define f25_LensScale		0.664
#define f25_LensFactor		1.11	
#define	f25_LensColor		float3(0.75, 0.75, 0.42)
#define	f25_ColorMultiplier	1.0


//KYO : add a/o remove passes of technique below

//====================================================================================================
//	Internal Individual parameters for PRIMARY
//	Time-Related RGB Multipliers
//	f#_R is Lens red multiplier, f#_G is green, f#_B is blue
//====================================================================================================

#if (USE_RGB_VARIATIONS_PRIMARY == 1)

//Lens #26
#define f26_LensOffset		-0.8					
#define f26_LensScale		0.083				
#define f26_LensFactor		0.8				
#define	f26_LensColor		float3(0.95  + abs(frac(Timer.x * f26_R)* 2.0 - 1.0), 0.82 + abs(frac(Timer.x * f26_G)* 2.0 - 1.0), 0.30 + abs(frac(Timer.x * f26_B)* 2.0 - 1.0))	
#define	f26_ColorMultiplier	1.3				
#define f26_R			2000.0		
#define f26_G			200.0
#define f26_B			4000.0

//Lens #27
#define f27_LensOffset		-0.47	
#define f27_LensScale		0.166
#define f27_LensFactor		1.0	
#define	f27_LensColor		float3(0.85 + abs(frac(Timer.x * f27_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f27_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f27_B)* 2.0 - 1.0))	
#define	f27_ColorMultiplier	1.0
#define f27_R			2000.0		
#define f27_G			200.0
#define f27_B			200.0

//Lens #28
#define f28_LensOffset		-0.14	
#define f28_LensScale		0.212
#define f28_LensFactor		1.0
#define	f28_LensColor		float3(1.0 + abs(frac(Timer.x * f28_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f28_G)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f28_B)* 2.0 - 1.0))	
#define	f28_ColorMultiplier	1.0
#define f28_R			200.0		
#define f28_G			200.0
#define f28_B			600.0

//Lens #29
#define f29_LensOffset		0.14	
#define f29_LensScale		0.249
#define f29_LensFactor		0.75	
#define	f29_LensColor		float3(0.25 + abs(frac(Timer.x * f29_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f29_G)* 2.0 - 1.0), 0.55 + abs(frac(Timer.x * f29_B)* 2.0 - 1.0))	
#define	f29_ColorMultiplier	1.8	
#define f29_R			2000.0		
#define f29_G			4000.0
#define f29_B			6000.0			

//Lens #30
#define f30_LensOffset		0.47	
#define f30_LensScale		0.332
#define f30_LensFactor		1.0	
#define	f30_LensColor		float3(1.0 + abs(frac(Timer.x * f30_R)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f30_G)* 2.0 - 1.0), 0.22 + abs(frac(Timer.x * f30_B)* 2.0 - 1.0))
#define	f30_ColorMultiplier	1.5	
#define f30_R			2000.0		
#define f30_G			4000.0
#define f30_B			200.0			

//Lens #31
#define f31_LensOffset		0.8	
#define f31_LensScale		0.415
#define f31_LensFactor		0.75	
#define	f31_LensColor		float3(0.60 + abs(frac(Timer.x * f31_R)* 2.0 - 1.0), 0.60 + abs(frac(Timer.x * f31_G)* 2.0 - 1.0), 0.75 + abs(frac(Timer.x * f31_B)* 2.0 - 1.0))	
#define	f31_ColorMultiplier	1.4
#define f31_R			200.0		
#define f31_G			1000.0
#define f31_B			600.0				

//Lens #32
#define f32_LensOffset		1.13	
#define f32_LensScale		0.498
#define f32_LensFactor		1.0	
#define	f32_LensColor		float3(1.0 + abs(frac(Timer.x * f32_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f32_G)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f32_B)* 2.0 - 1.0))
#define	f32_ColorMultiplier	1.0
#define f32_R			200.0		
#define f32_G			2000.0
#define f32_B			200.0

//Lens #33
#define f33_LensOffset		1.46	
#define f33_LensScale		0.581
#define f33_LensFactor		0.5	
#define	f33_LensColor		float3(0.25 + abs(frac(Timer.x * f33_R)* 2.0 - 1.0), 0.95 + abs(frac(Timer.x * f33_G)* 2.0 - 1.0), 0.35 + abs(frac(Timer.x * f33_B)* 2.0 - 1.0))	
#define	f33_ColorMultiplier	1.6	
#define f33_R			4000.0		
#define f33_G			200.0
#define f33_B			200.0			

//Lens #34
#define f34_LensOffset		1.79	
#define f34_LensScale		0.581
#define f34_LensFactor		0.85	
#define	f34_LensColor		float3(1.0 + abs(frac(Timer.x * f34_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f34_G)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f34_B)* 2.0 - 1.0))	
#define	f34_ColorMultiplier	1.0
#define f34_R			20.0		
#define f34_G			200.0
#define f34_B			20.0

//Lens #35
#define f35_LensOffset		2.12	
#define f35_LensScale		0.581
#define f35_LensFactor		1.0	
#define	f35_LensColor		float3(0.7 + abs(frac(Timer.x * f35_R)* 2.0 - 1.0), 0.7 + abs(frac(Timer.x * f35_G)* 2.0 - 1.0), 0.7 + abs(frac(Timer.x * f35_B)* 2.0 - 1.0))	
#define	f35_ColorMultiplier	1.0
#define f35_R			200.0		
#define f35_G			200.0
#define f35_B			200.0

//Lens #36
#define f36_LensOffset		2.43	
#define f36_LensScale		0.664
#define f36_LensFactor		1.11	
#define	f36_LensColor		float3(0.95 + abs(frac(Timer.x * f36_R)* 2.0 - 1.0), 0.95 + abs(frac(Timer.x * f36_G)* 2.0 - 1.0), 0.62 + abs(frac(Timer.x * f36_B)* 2.0 - 1.0))
#define	f36_ColorMultiplier	1.0
#define f36_R			200.0		
#define f36_G			1000.0
#define f36_B			20.0

#else

//Lens #26
#define f26_LensOffset		-0.8				//Sun to Eye	
#define f26_LensScale		0.083				//Size 
#define f26_LensFactor		0.8				//Multiplier for Size	
#define	f26_LensColor		float3(0.95, 0.82, 0.30)	//Color in RGB	
#define	f26_ColorMultiplier	1.5				//Color Multiplier

//Lens #27
#define f27_LensOffset		-0.47	
#define f27_LensScale		0.166
#define f27_LensFactor		1.0	
#define	f27_LensColor		float3(0.85, 0.65, 0.85)	
#define	f27_ColorMultiplier	1.0

//Lens #28
#define f28_LensOffset		-0.14	
#define f28_LensScale		0.212
#define f28_LensFactor		1.0
#define	f28_LensColor		float3(1.0, 1.0, 1.0)	
#define	f28_ColorMultiplier	1.0

//Lens #29
#define f29_LensOffset		0.14	
#define f29_LensScale		0.249
#define f29_LensFactor		0.75	
#define	f29_LensColor		float3(0.25, 1.0, 0.55)	
#define	f29_ColorMultiplier	2.0				

//Lens #30
#define f30_LensOffset		0.47	
#define f30_LensScale		0.332
#define f30_LensFactor		1.0	
#define	f30_LensColor		float3(1.0, 0.85, 0.22)
#define	f30_ColorMultiplier	2.5				

//Lens #31
#define f31_LensOffset		0.8	
#define f31_LensScale		0.415
#define f31_LensFactor		0.75	
#define	f31_LensColor		float3(0.60, 0.60, 0.75)	
#define	f31_ColorMultiplier	2.0				

//Lens #32
#define f32_LensOffset		1.13	
#define f32_LensScale		0.498
#define f32_LensFactor		1.0	
#define	f32_LensColor		float3(1.0, 1.0, 1.0)
#define	f32_ColorMultiplier	1.0

//Lens #33
#define f33_LensOffset		1.46	
#define f33_LensScale		0.581
#define f33_LensFactor		0.5	
#define	f33_LensColor		float3(0.25, 0.95, 0.35)	
#define	f33_ColorMultiplier	2.3				

//Lens #34
#define f34_LensOffset		1.79	
#define f34_LensScale		0.581
#define f34_LensFactor		0.85	
#define	f34_LensColor		float3(1.0, 1.0, 1.0)	
#define	f34_ColorMultiplier	1.0

//Lens #35
#define f35_LensOffset		2.12	
#define f35_LensScale		0.581
#define f35_LensFactor		1.0	
#define	f35_LensColor		float3(1.0, 1.0, 1.0)	
#define	f35_ColorMultiplier	1.0

//Lens #36
#define f36_LensOffset		2.43	
#define f36_LensScale		0.664
#define f36_LensFactor		1.11	
#define	f36_LensColor		float3(0.95, 0.95, 0.62)
#define	f36_ColorMultiplier	1.2

#endif


//KYO : add a/o remove passes of technique below

//====================================================================================================
//	Internal Individual parameters for THIRDARY
//====================================================================================================

//Lens #37
#define f37_LensOffset		-0.8				//Sun to Eye	
#define f37_LensScale		0.083				//Size 
#define f37_LensFactor		1.0				//Multiplier for Size	
#define	f37_LensColor		float3(0.75, 0.75, 0.30)	//Color in RGB 	
#define	f37_ColorMultiplier	1.0				//Color Multiplier

//Lens #38
#define f38_LensOffset		-0.47	
#define f38_LensScale		0.166
#define f38_LensFactor		1.0	
#define	f38_LensColor		float3(0.85, 0.65, 0.85)	
#define	f38_ColorMultiplier	1.0

//Lens #39
#define f39_LensOffset		-0.14	
#define f39_LensScale		0.212
#define f39_LensFactor		1.0
#define	f39_LensColor		float3(1.0, 1.0, 1.0)	
#define	f39_ColorMultiplier	1.0

//Lens #40
#define f40_LensOffset		0.14	
#define f40_LensScale		0.249
#define f40_LensFactor		0.75	
#define	f40_LensColor		float3(0.25, 1.0, 0.75)	
#define	f40_ColorMultiplier	1.0

//Lens #41
#define f41_LensOffset		0.47	
#define f41_LensScale		0.332
#define f41_LensFactor		1.0	
#define	f41_LensColor		float3(0.0, 0.0, 0.75)
#define	f41_ColorMultiplier	1.0

//Lens #42
#define f42_LensOffset		0.8	
#define f42_LensScale		0.415
#define f42_LensFactor		0.75	
#define	f42_LensColor		float3(0.60, 0.60, 0.75)	
#define	f42_ColorMultiplier	1.0

//Lens #43
#define f43_LensOffset		1.13	
#define f43_LensScale		0.498
#define f43_LensFactor		1.0	
#define	f43_LensColor		float3(1.0, 1.0, 1.0)
#define	f43_ColorMultiplier	1.0

//Lens #44
#define f44_LensOffset		1.46	
#define f44_LensScale		0.581
#define f44_LensFactor		0.5	
#define	f44_LensColor		float3(0.25, 0.95, 0.35)	
#define	f44_ColorMultiplier	1.0

//Lens #45
#define f45_LensOffset		1.79	
#define f45_LensScale		0.581
#define f45_LensFactor		0.85	
#define	f45_LensColor		float3(1.0, 1.0, 1.0)	
#define	f45_ColorMultiplier	1.0

//Lens #46
#define f46_LensOffset		2.12	
#define f46_LensScale		0.581
#define f46_LensFactor		1.0	
#define	f46_LensColor		float3(1.0, 1.0, 1.0)	
#define	f46_ColorMultiplier	1.0

//Lens #47
#define f47_LensOffset		2.43	
#define f47_LensScale		0.664
#define f47_LensFactor		1.11	
#define	f47_LensColor		float3(0.95, 0.95, 0.62)
#define	f47_ColorMultiplier	1.0


//KYO : add a/o remove passes of technique below

//====================================================================================================
//	Internal Individual parameters for THIRDARY 2
//====================================================================================================

//Lens #48
#define f48_LensOffset		-0.8				//Sun to Eye	
#define f48_LensScale		0.083				//Size 
#define f48_LensFactor		1.0				//Multiplier for Size	
#define	f48_LensColor		float3(0.75, 0.75, 0.50)	//Color in RGB 	
#define	f48_ColorMultiplier	1.0				//Color Multiplier

//Lens #49
#define f49_LensOffset		-0.47	
#define f49_LensScale		0.166
#define f49_LensFactor		1.0	
#define	f49_LensColor		float3(0.85, 0.65, 0.85)	
#define	f49_ColorMultiplier	1.0

//Lens #50
#define f50_LensOffset		-0.14	
#define f50_LensScale		0.212
#define f50_LensFactor		1.0
#define	f50_LensColor		float3(1.0, 1.0, 1.0)	
#define	f50_ColorMultiplier	1.0

//Lens #51
#define f51_LensOffset		0.14	
#define f51_LensScale		0.249
#define f51_LensFactor		0.75	
#define	f51_LensColor		float3(0.25, 1.0, 0.75)	
#define	f51_ColorMultiplier	1.0

//Lens #52
#define f52_LensOffset		0.47	
#define f52_LensScale		0.332
#define f52_LensFactor		1.0	
#define	f52_LensColor		float3(0.0, 0.0, 0.75)
#define	f52_ColorMultiplier	1.0

//Lens #53
#define f53_LensOffset		0.8	
#define f53_LensScale		0.415
#define f53_LensFactor		0.75	
#define	f53_LensColor		float3(0.60, 0.60, 0.75)	
#define	f53_ColorMultiplier	1.0

//Lens #54
#define f54_LensOffset		1.13	
#define f54_LensScale		0.498
#define f54_LensFactor		1.0	
#define	f54_LensColor		float3(1.0, 1.0, 1.0)
#define	f54_ColorMultiplier	1.0

//Lens #55
#define f55_LensOffset		1.46	
#define f55_LensScale		0.581
#define f55_LensFactor		0.5	
#define	f55_LensColor		float3(0.25, 0.95, 0.35)	
#define	f55_ColorMultiplier	1.0

//Lens #56
#define f56_LensOffset		1.79	
#define f56_LensScale		0.581
#define f56_LensFactor		0.85	
#define	f56_LensColor		float3(1.0, 1.0, 1.0)	
#define	f56_ColorMultiplier	1.0

//Lens #57
#define f57_LensOffset		2.12	
#define f57_LensScale		0.581
#define f57_LensFactor		1.0	
#define	f57_LensColor		float3(1.0, 1.0, 1.0)	
#define	f57_ColorMultiplier	1.0

//Lens #58
#define f58_LensOffset		2.43	
#define f58_LensScale		0.664
#define f58_LensFactor		1.11	
#define	f58_LensColor		float3(0.95, 0.95, 0.62)
#define	f58_ColorMultiplier	1.0


//KYO : add a/o remove passes of technique below

//====================================================================================================
//	Internal Individual parameters for PRIMARY_ALT 
//	Time-Related Colour Multipliers
//	f#_R is Lens red multiplier, f#_G is green, f#_B is blue
//====================================================================================================

#if (USE_RGB_VARIATIONS_PRIMARY_ALT == 1)

//Lens #59
#define f59_LensOffset		-0.8							
#define f59_LensScale		0.083		
#define f59_LensFactor		1.0						
#define	f59_LensColor		float3(0.95 + abs(frac(Timer.x * f59_R)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f59_G)* 2.0 - 1.0), 0.30 + abs(frac(Timer.x * f59_B)* 2.0 - 1.0))		
#define	f59_ColorMultiplier	1.6	
#define f59_R			200.0		
#define f59_G			200.0
#define f59_B			1000.0						

//Lens #60
#define f60_LensOffset		-0.6	
#define f60_LensScale		0.103 
#define f60_LensFactor		1.0	
#define	f60_LensColor		float3(0.85 + abs(frac(Timer.x * f60_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f60_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f60_B)* 2.0 - 1.0))	
#define	f60_ColorMultiplier	1.0
#define f60_R			2000.0		
#define f60_G			4000.0
#define f60_B			200.0	

//Lens #61
#define f61_LensOffset		-0.4	
#define f61_LensScale		0.123 
#define f61_LensFactor		1.0	
#define	f61_LensColor		float3(0.85 + abs(frac(Timer.x * f61_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f61_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f61_B)* 2.0 - 1.0))	
#define	f61_ColorMultiplier	1.0
#define f61_R			2000.0		
#define f61_G			200.0
#define f61_B			6000.0	

//Lens #62
#define f62_LensOffset		-0.2	
#define f62_LensScale		0.143 
#define f62_LensFactor		1.0
#define	f62_LensColor		float3(1.0 + abs(frac(Timer.x * f62_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f62_G)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f62_B)* 2.0 - 1.0))	
#define	f62_ColorMultiplier	1.0
#define f62_R			2000.0		
#define f62_G			5000.0
#define f62_B			200.0	

//Lens #63
#define f63_LensOffset		0.0	
#define f63_LensScale		0.143 
#define f63_LensFactor		1.0	
#define	f63_LensColor		float3(0.85 + abs(frac(Timer.x * f63_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f63_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f63_B)* 2.0 - 1.0))	
#define	f63_ColorMultiplier	1.0
#define f63_R			2000.0		
#define f63_G			600.0
#define f63_B			2000.0	

//Lens #64
#define f64_LensOffset		0.2	
#define f64_LensScale		0.163 
#define f64_LensFactor		1.0	
#define	f64_LensColor		float3(0.2 + abs(frac(Timer.x * f64_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f64_G)* 2.0 - 1.0), 0.55 + abs(frac(Timer.x * f64_B)* 2.0 - 1.0))	
#define	f64_ColorMultiplier	2.0	
#define f64_R			2000.0		
#define f64_G			600.0
#define f64_B			2000.0				

//Lens #65
#define f65_LensOffset		0.4	
#define f65_LensScale		0.183 
#define f65_LensFactor		1.0	
#define	f65_LensColor		float3(1.0 + abs(frac(Timer.x * f65_R)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f65_G)* 2.0 - 1.0), 0.22 + abs(frac(Timer.x * f65_B)* 2.0 - 1.0))
#define	f65_ColorMultiplier	2.5	
#define f65_R			200.0		
#define f65_G			6000.0
#define f65_B			2000.0				

//Lens #66
#define f66_LensOffset		0.6	
#define f66_LensScale		0.203 
#define f66_LensFactor		1.0	
#define	f66_LensColor		float3(0.85 + abs(frac(Timer.x * f66_R)* 2.0 - 1.0), 0.60 + abs(frac(Timer.x * f66_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f66_B)* 2.0 - 1.0))	
#define	f66_ColorMultiplier	1.0
#define f66_R			2000.0		
#define f66_G			1000.0
#define f66_B			600.0	

//Lens #67
#define f67_LensOffset		0.8	
#define f67_LensScale		0.223 
#define f67_LensFactor		1.0	
#define	f67_LensColor		float3(0.60 + abs(frac(Timer.x * f67_R)* 2.0 - 1.0), 0.60 + abs(frac(Timer.x * f67_G)* 2.0 - 1.0), 0.75 + abs(frac(Timer.x * f67_B)* 2.0 - 1.0))	
#define	f67_ColorMultiplier	2.0	
#define f67_R			200.0		
#define f67_G			6000.0
#define f67_B			200.0				

//Lens #68
#define f68_LensOffset		1.0	
#define f68_LensScale		0.323 
#define f68_LensFactor		1.0	
#define	f68_LensColor		float3(1.0 + abs(frac(Timer.x * f68_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f68_G)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f68_B)* 2.0 - 1.0))
#define	f68_ColorMultiplier	1.0
#define f68_R			2000.0		
#define f68_G			6000.0
#define f68_B			200.0	

//Lens #69
#define f69_LensOffset		1.2	
#define f69_LensScale		0.263 
#define f69_LensFactor		1.0	
#define	f69_LensColor		float3(0.25 + abs(frac(Timer.x * f69_R)* 2.0 - 1.0), 0.95 + abs(frac(Timer.x * f69_G)* 2.0 - 1.0), 0.35 + abs(frac(Timer.x * f69_B)* 2.0 - 1.0))	
#define	f69_ColorMultiplier	2.3	
#define f69_R			2000.0		
#define f69_G			6000.0
#define f69_B			2000.0			

//Lens #70
#define f70_LensOffset		1.4	
#define f70_LensScale		0.333
#define f70_LensFactor		1.0	
#define	f70_LensColor		float3(0.85 + abs(frac(Timer.x * f70_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f70_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f70_B)* 2.0 - 1.0))	
#define	f70_ColorMultiplier	1.0
#define f70_R			200.0		
#define f70_G			600.0
#define f70_B			2000.0	

//Lens #71
#define f71_LensOffset		1.6
#define f71_LensScale		0.303 
#define f71_LensFactor		1.0	
#define	f71_LensColor		float3(0.85 + abs(frac(Timer.x * f71_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f71_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f71_B)* 2.0 - 1.0))	
#define	f71_ColorMultiplier	1.0
#define f71_R			300.0		
#define f71_G			600.0
#define f71_B			200.0	

//Lens #72
#define f72_LensOffset		1.8	
#define f72_LensScale		0.363 
#define f72_LensFactor		1.0	
#define	f72_LensColor		float3(1.0 +  abs(frac(Timer.x * f72_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f72_G)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f72_B)* 2.0 - 1.0))	
#define	f72_ColorMultiplier	1.0
#define f72_R			300.0		
#define f72_G			6000.0
#define f72_B			2000.0	

//Lens #73
#define f73_LensOffset		2.0	
#define f73_LensScale		0.343
#define f73_LensFactor		1.0	
#define	f73_LensColor		float3(0.85 + abs(frac(Timer.x * f73_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f73_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f73_B)* 2.0 - 1.0))	
#define	f73_ColorMultiplier	1.0
#define f73_R			3000.0		
#define f73_G			100.0
#define f73_B			2000.0	

//Lens #74
#define f74_LensOffset		2.2	
#define f74_LensScale		0.363
#define f74_LensFactor		1.0	
#define	f74_LensColor		float3(1.0 + abs(frac(Timer.x * f74_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f74_G)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f74_B)* 2.0 - 1.0))	
#define	f74_ColorMultiplier	1.0
#define f74_R			20.0		
#define f74_G			600.0
#define f74_B			2000.0	

//Lens #75
#define f75_LensOffset		2.4	
#define f75_LensScale		0.383
#define f75_LensFactor		1.0	
#define	f75_LensColor		float3(0.95 + abs(frac(Timer.x * f75_R)* 2.0 - 1.0), 0.95 + abs(frac(Timer.x * f75_G)* 2.0 - 1.0), 0.62 + abs(frac(Timer.x * f75_B)* 2.0 - 1.0))
#define	f75_ColorMultiplier	1.2
#define f75_R			2000.0		
#define f75_G			6000.0
#define f75_B			2000.0	

//Lens #76
#define f76_LensOffset		2.6	
#define f76_LensScale		0.403 
#define f76_LensFactor		1.0	
#define	f76_LensColor		float3(0.85 + abs(frac(Timer.x * f76_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f76_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f76_B)* 2.0 - 1.0))	
#define	f76_ColorMultiplier	1.0
#define f76_R			3000.0		
#define f76_G			5000.0
#define f76_B			200.0	


#else


//Lens #59
#define f59_LensOffset		-0.8				//Sun to Eye	
#define f59_LensScale		0.083				//Size 
#define f59_LensFactor		1.0				//Multiplier for Size
#define	f59_LensColor		float3(0.95, 0.85, 0.30)	//Color in RGB 	
#define	f59_ColorMultiplier	1.6				//Color Multiplier

//Lens #60
#define f60_LensOffset		-0.6	
#define f60_LensScale		0.103
#define f60_LensFactor		1.0	
#define	f60_LensColor		float3(0.85, 0.65, 0.85)	
#define	f60_ColorMultiplier	1.0

//Lens #61
#define f61_LensOffset		-0.4	
#define f61_LensScale		0.123
#define f61_LensFactor		1.0	
#define	f61_LensColor		float3(0.85, 0.65, 0.85)	
#define	f61_ColorMultiplier	1.0

//Lens #62
#define f62_LensOffset		-0.2	
#define f62_LensScale		0.143
#define f62_LensFactor		1.0
#define	f62_LensColor		float3(1.0, 1.0, 1.0)	
#define	f62_ColorMultiplier	1.0

//Lens #63
#define f63_LensOffset		0.0	
#define f63_LensScale		0.143
#define f63_LensFactor		1.0	
#define	f63_LensColor		float3(0.85, 0.65, 0.85)	
#define	f63_ColorMultiplier	1.0

//Lens #64
#define f64_LensOffset		0.2	
#define f64_LensScale		0.163
#define f64_LensFactor		1.0	
#define	f64_LensColor		float3(0.25, 1.0, 0.55)	
#define	f64_ColorMultiplier	2.0			

//Lens #65
#define f65_LensOffset		0.4	
#define f65_LensScale		0.183
#define f65_LensFactor		1.0	
#define	f65_LensColor		float3(1.0, 0.85, 0.22)
#define	f65_ColorMultiplier	2.5				

//Lens #66
#define f66_LensOffset		0.6	
#define f66_LensScale		0.203
#define f66_LensFactor		1.0	
#define	f66_LensColor		float3(0.85, 0.65, 0.85)	
#define	f66_ColorMultiplier	1.0

//Lens #67
#define f67_LensOffset		0.8	
#define f67_LensScale		0.223
#define f67_LensFactor		1.0	
#define	f67_LensColor		float3(0.60, 0.60, 0.75)	
#define	f67_ColorMultiplier	2.0				

//Lens #68
#define f68_LensOffset		1.0	
#define f68_LensScale		0.243
#define f68_LensFactor		1.0	
#define	f68_LensColor		float3(1.0, 1.0, 1.0)
#define	f68_ColorMultiplier	1.0

//Lens #69
#define f69_LensOffset		1.2	
#define f69_LensScale		0.263
#define f69_LensFactor		1.0	
#define	f69_LensColor		float3(0.25, 0.95, 0.35)	
#define	f69_ColorMultiplier	2.3				

//Lens #70
#define f70_LensOffset		1.4	
#define f70_LensScale		0.283
#define f70_LensFactor		1.0	
#define	f70_LensColor		float3(0.85, 0.65, 0.85)	
#define	f70_ColorMultiplier	1.0

//Lens #71
#define f71_LensOffset		1.6
#define f71_LensScale		0.303
#define f71_LensFactor		1.0	
#define	f71_LensColor		float3(0.85, 0.65, 0.85)	
#define	f71_ColorMultiplier	1.0

//Lens #72
#define f72_LensOffset		1.8	
#define f72_LensScale		0.323
#define f72_LensFactor		1.0	
#define	f72_LensColor		float3(1.0, 1.0, 1.0)	
#define	f72_ColorMultiplier	1.0

//Lens #73
#define f73_LensOffset		2.0	
#define f73_LensScale		0.343
#define f73_LensFactor		1.0	
#define	f73_LensColor		float3(0.85, 0.65, 0.85)	
#define	f73_ColorMultiplier	1.0

//Lens #74
#define f74_LensOffset		2.2	
#define f74_LensScale		0.363
#define f74_LensFactor		1.0	
#define	f74_LensColor		float3(1.0, 1.0, 1.0)	
#define	f74_ColorMultiplier	1.0

//Lens #75
#define f75_LensOffset		2.4	
#define f75_LensScale		0.383
#define f75_LensFactor		1.0	
#define	f75_LensColor		float3(0.95, 0.95, 0.62)
#define	f75_ColorMultiplier	1.2

//Lens #76
#define f76_LensOffset		2.6	
#define f76_LensScale		0.403
#define f76_LensFactor		1.0	
#define	f76_LensColor		float3(0.85, 0.65, 0.85)	
#define	f76_ColorMultiplier	1.0

#endif 


//KYO : add a/o remove passes of technique below

//====================================================================================================
//	Internal Individual parameters for PRIMARY_ALT_2
//	Time-Related Colour Multipliers
//	f#_R is Lens red multiplier, f#_G is green, f#_B is blue
//====================================================================================================

#if (USE_RGB_VARIATIONS_PRIMARY_ALT_2 == 1)

//Lens #77
#define f77_LensOffset		-0.5							
#define f77_LensScale		0.1		
#define f77_LensFactor		1.0						
#define	f77_LensColor		float3(0.95 + abs(frac(Timer.x * f77_R)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f77_G)* 2.0 - 1.0), 0.30 + abs(frac(Timer.x * f77_B)* 2.0 - 1.0))		
#define	f77_ColorMultiplier	1.6	
#define f77_R			200.0		
#define f77_G			200.0
#define f77_B			1000.0						

//Lens #78
#define f78_LensOffset		0.5	
#define f78_LensScale		0.333 
#define f78_LensFactor		1.0	
#define	f78_LensColor		float3(0.85 + abs(frac(Timer.x * f78_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f78_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f78_B)* 2.0 - 1.0))	
#define	f78_ColorMultiplier	1.0
#define f78_R			2000.0		
#define f78_G			4000.0
#define f78_B			200.0	

//Lens #79
#define f79_LensOffset		1.0	
#define f79_LensScale		0.665
#define f79_LensFactor		1.0	
#define	f79_LensColor		float3(0.85 + abs(frac(Timer.x * f79_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f79_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f79_B)* 2.0 - 1.0))	
#define	f79_ColorMultiplier	1.0
#define f79_R			2000.0		
#define f79_G			200.0
#define f79_B			6000.0	

//Lens #80
#define f80_LensOffset		1.8	
#define f80_LensScale		0.885 
#define f80_LensFactor		1.0
#define	f80_LensColor		float3(1.0 + abs(frac(Timer.x * f80_R)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f80_G)* 2.0 - 1.0), 1.0 + abs(frac(Timer.x * f80_B)* 2.0 - 1.0))	
#define	f80_ColorMultiplier	1.0
#define f80_R			2000.0		
#define f80_G			5000.0
#define f80_B			200.0	


#else


//Lens #77
#define f77_LensOffset		-0.5							
#define f77_LensScale		0.1	
#define f77_LensFactor		1.0						
#define	f77_LensColor		float3(0.95, 0.65, 0.30)		
#define	f77_ColorMultiplier	1.6						

//Lens #78
#define f78_LensOffset		0.5	
#define f78_LensScale		0.333
#define f78_LensFactor		1.0	
#define	f78_LensColor		float3(0.85, 0.65, 0.85)	
#define	f78_ColorMultiplier	1.0

//Lens #79
#define f79_LensOffset		1.0	
#define f79_LensScale		0.665
#define f79_LensFactor		1.0	
#define	f79_LensColor		float3(0.85, 0.65, 0.85)	
#define	f79_ColorMultiplier	1.0

//Lens #80
#define f80_LensOffset		1.8	
#define f80_LensScale		0.885 
#define f80_LensFactor		1.0
#define	f80_LensColor		float3(1.0, 1.0, 1.0)
#define	f80_ColorMultiplier	1.0

#endif

//KYO : add a/o remove passes of technique below

//====================================================================================================
//	Internal Individual parameters for FOURTH
//	Time-Related Colour Multipliers
//	f#_R is Lens red multiplier, f#_G is green, f#_B is blue
//====================================================================================================

#if (USE_RGB_VARIATIONS_FOURTH == 1)

//Lens #81
#define f81_LensOffset		-0.5							
#define f81_LensScale		0.1		
#define f81_LensFactor		1.0						
#define	f81_LensColor		float3(0.95 + abs(frac(Timer.x * f81_R)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f81_G)* 2.0 - 1.0), 0.30 + abs(frac(Timer.x * f81_B)* 2.0 - 1.0))		
#define	f81_ColorMultiplier	1.6	
#define f81_R			200.0		
#define f81_G			200.0
#define f81_B			1000.0						

//Lens #82
#define f82_LensOffset		0.5	
#define f82_LensScale		0.455
#define f82_LensFactor		1.0	
#define	f82_LensColor		float3(0.85 + abs(frac(Timer.x * f82_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f82_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f82_B)* 2.0 - 1.0))	
#define	f82_ColorMultiplier	1.0
#define f82_R			2000.0		
#define f82_G			4000.0
#define f82_B			200.0	

//Lens #83
#define f83_LensOffset		1.0	
#define f83_LensScale		0.665
#define f83_LensFactor		1.5	
#define	f83_LensColor		float3(0.85 + abs(frac(Timer.x * f83_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f83_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f83_B)* 2.0 - 1.0))	
#define	f83_ColorMultiplier	1.3
#define f83_R			2000.0		
#define f83_G			200.0
#define f83_B			6000.0	


#else


//Lens #81
#define f81_LensOffset		-0.5							
#define f81_LensScale		0.1	
#define f81_LensFactor		1.0						
#define	f81_LensColor		float3(0.95, 0.65, 0.30)		
#define	f81_ColorMultiplier	1.6						

//Lens #82
#define f82_LensOffset		0.5	
#define f82_LensScale		0.455
#define f82_LensFactor		1.0	
#define	f82_LensColor		float3(0.85, 0.65, 0.85)	
#define	f82_ColorMultiplier	1.0

//Lens #83
#define f83_LensOffset		1.5	
#define f83_LensScale		0.665
#define f83_LensFactor		1.3	
#define	f83_LensColor		float3(0.85, 0.65, 0.85)	
#define	f83_ColorMultiplier	1.0

#endif

//KYO : add a/o remove passes of technique below

//====================================================================================================
//	Internal Individual parameters for FOURTH_2
//	Time-Related Colour Multipliers
//	f#_R is Lens red multiplier, f#_G is green, f#_B is blue
//====================================================================================================

#if (USE_RGB_VARIATIONS_FOURTH_2 == 1)

//Lens #84
#define f84_LensOffset		-0.5							
#define f84_LensScale		0.2		
#define f84_LensFactor		0.85						
#define	f84_LensColor		float3(0.95 + abs(frac(Timer.x * f84_R)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f84_G)* 2.0 - 1.0), 0.30 + abs(frac(Timer.x * f84_B)* 2.0 - 1.0))		
#define	f84_ColorMultiplier	1.2	
#define f84_R			200.0		
#define f84_G			200.0
#define f84_B			1000.0						

//Lens #85
#define f85_LensOffset		0.5	
#define f85_LensScale		0.333
#define f85_LensFactor		1.0	
#define	f85_LensColor		float3(0.85 + abs(frac(Timer.x * f85_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f85_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f85_B)* 2.0 - 1.0))	
#define	f85_ColorMultiplier	1.0
#define f85_R			2000.0		
#define f85_G			4000.0
#define f85_B			200.0	

//Lens #86
#define f86_LensOffset		1.5	
#define f86_LensScale		0.665
#define f86_LensFactor		1.5	
#define	f86_LensColor		float3(0.85 + abs(frac(Timer.x * f86_R)* 2.0 - 1.0), 0.65 + abs(frac(Timer.x * f86_G)* 2.0 - 1.0), 0.85 + abs(frac(Timer.x * f86_B)* 2.0 - 1.0))	
#define	f86_ColorMultiplier	1.0
#define f86_R			2000.0		
#define f86_G			200.0
#define f86_B			6000.0	


#else


//Lens #84
#define f84_LensOffset		-0.5							
#define f84_LensScale		0.3	
#define f84_LensFactor		0.85						
#define	f84_LensColor		float3(0.95, 0.65, 0.30)		
#define	f84_ColorMultiplier	1.2						

//Lens #85
#define f85_LensOffset		0.5	
#define f85_LensScale		0.333
#define f85_LensFactor		1.0	
#define	f85_LensColor		float3(0.85, 0.65, 0.85)	
#define	f85_ColorMultiplier	1.0

//Lens #86
#define f86_LensOffset		1.5	
#define f86_LensScale		0.665
#define f86_LensFactor		1.0	
#define	f86_LensColor		float3(0.85, 0.65, 0.85)	
#define	f86_ColorMultiplier	1.0

#endif

//===================================================================================================
//===================================================================================================
//	External parameters
//===================================================================================================
//===================================================================================================
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	ScreenSize;
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	Timer;
//xy=sun position on screen, w=visibility
float4	LightParameters;
//textures
texture2D texColor;
texture2D texMask;

sampler2D SamplerColor = sampler_state
{
	Texture   = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;				
	MipMapLodBias=0;
};

sampler2D SamplerMask = sampler_state
{
	Texture   = <texMask>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

struct VS_OUTPUT_POST
{
	float4 vpos  : POSITION;
	float2 txcoord : TEXCOORD0;
};

struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord : TEXCOORD0;
};

/**
 * Pseudo-random number generator - returns a number generated according to the provided vector
 */
float Random(float2 co)
{
    return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
}

/**
 * Timer Formulas
 */
/**
	float timepassed=Timer.x* Value;		
	timepassed=frac(timepassed_Light) * 2.0 - 1.0;
	timepassed=abs(timepassed_Light);

-1.0 - 1.0
	float amplitude = 1.0;
	float frequency = 1.0;
	float Value= sin(2 * PI * frequency * Timer.x) * amplitude;

0.0 - 1.0
	float amplitude = 1.0;
	float frequency = 1.0;
	float Value = (0.5 * sin(2 * PI * frequency * Timer.x) + 0.5) * amplitude;
*/
/**
 * Several Lens moving similar to Lens effect
 * Transformed in vertex shader and drawed separately 
 * Offset is set in passes of technique
 */

VS_OUTPUT_POST VS_Secondary(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_SECONDARY == 1)
	float timepassed_1=Timer.x* fVelocity_Secondary;			
	timepassed_1=frac(timepassed_1) * 2.0 - 1.0;
	timepassed_1=abs(timepassed_1);
	float4 pos = float4(IN.pos.x + fHPosSecondary,IN.pos.y + fVPosSecondary,IN.pos.z,1.0) + timepassed_1;
#else
	float4 pos = float4(IN.pos.x + fHPosSecondary,IN.pos.y + fVPosSecondary,IN.pos.z,1.0);
#endif
	pos.y*=ScreenSize.z;
	float timepassed_Scale_Secondary=(Timer.x* (fScaleTimeFactor_Secondary * 8.0));			
	timepassed_Scale_Secondary=frac(timepassed_Scale_Secondary) * 2.0 - 1.0;
	timepassed_Scale_Secondary=abs(timepassed_Scale_Secondary);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_SECONDARY == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScaleSecondary + timepassed_Scale_Secondary))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScaleSecondary)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Secondary(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, fContrastSecondary);				
	clip(sunmask-0.02);		
	
	float timepassed_Scale_Secondary=(Timer.x* (fScaleTimeFactor_Secondary * 8.0));			
	timepassed_Scale_Secondary=frac(timepassed_Scale_Secondary) * 2.0 - 1.0;
	timepassed_Scale_Secondary=abs(timepassed_Scale_Secondary);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;
	
#if (USE_LENS_DISTORTIONS_SECONDARY == 1)
#if (USE_CHROMA_FORMULA_SECONDARY == 1)
	float3 eta_Secondary = float3(1.0+fChromaticAmount_Secondary*0.9,1.0+fChromaticAmount_Secondary*0.6,1.0+fChromaticAmount_Secondary*0.3);
#elif (USE_CHROMA_FORMULA_SECONDARY == 2)
	float3 eta_Secondary = float3(1.0+fChromaticAmount_Secondary*0.6,1.0+fChromaticAmount_Secondary*0.9,1.0+fChromaticAmount_Secondary*0.3);
#elif (USE_CHROMA_FORMULA_SECONDARY == 3)
	float3 eta_Secondary = float3(1.0+fChromaticAmount_Secondary*0.3,1.0+fChromaticAmount_Secondary*0.6,1.0+fChromaticAmount_Secondary*0.9);
#elif (USE_CHROMA_FORMULA_SECONDARY == 4)
	float3 eta_Secondary = float3(1.0+fChromaticAmount_Secondary*0.3,1.0+fChromaticAmount_Secondary*0.9,1.0+fChromaticAmount_Secondary*0.6);
#elif (USE_CHROMA_FORMULA_SECONDARY == 5)
	float3 eta_Secondary = float3(1.0+fChromaticAmount_Secondary*0.3,1.0+fChromaticAmount_Secondary*0.3,1.0+fChromaticAmount_Secondary*0.3);
#elif (USE_CHROMA_FORMULA_SECONDARY == 6)
	float3 eta_Secondary = float3(1.0+fChromaticAmount_Secondary*0.9,1.0+fChromaticAmount_Secondary*0.3,1.0+fChromaticAmount_Secondary*0.3);
#elif (USE_CHROMA_FORMULA_SECONDARY == 7)
	float3 eta_Secondary = float3(1.0+fChromaticAmount_Secondary*0.9,1.0+fChromaticAmount_Secondary*0.9,1.0+fChromaticAmount_Secondary*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_SECONDARY == 1)
	float LensZoom_Secondary = (1.0 / fLensSize_Secondary) * (fLensScaleFactor * (fScaleSecondary + timepassed_Scale_Secondary));	//Index on Timed-Size Vars
#else
	float LensZoom_Secondary = 1.0 / fLensSize_Secondary;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Secondary == 0.0){
 	f = 1 + r2 * fLensDistortion_Secondary;
	}else{
      	f = 1 + r2 * (fLensDistortion_Secondary + fLensDistortionCubic_Secondary * sqrt(r2));
	};

	float x = (f*LensZoom_Secondary*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Secondary*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Secondary.r)*LensZoom_Secondary*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Secondary.g)*LensZoom_Secondary*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Secondary.b)*LensZoom_Secondary*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif	

	float amplitudeSecondary = 1.0;
	float frequencySecondary = 1.0;
	float TimeFactorSecondary=(0.5 * sin(2 * PI * frequencySecondary * Timer.x * (8.0 * fIntTimeFactor_Secondary)) + 0.75) * amplitudeSecondary;	//+ 0.5 Non-Limiter
	float timepassed_Light=Timer.x* fLightVelocity_Secondary;		
	timepassed_Light=frac(timepassed_Light) * 2.0 - 1.0;
	timepassed_Light=abs(timepassed_Light);

#if (USE_LIGHT_SECONDARY == 1)
	sunmask*=(LightParameters.w + timepassed_Light) * (fLensIntensity * (fIntensitySecondary - timepassed_Light * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensitySecondary);
#endif
#if (USE_INTENSITY_VARIATIONS_SECONDARY == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensitySecondary) * TimeFactorSecondary );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensitySecondary);
#endif

#if (USE_LENS_DISTORTIONS_SECONDARY == 1)
	res.xyz=origcolor.xyz * sunmask;
#else
	res.xyz=origcolor * sunmask;
#endif
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=(colorfilter * colormultiplier);
	res.w=1.0;
	return res;
}

/**
 *	SUNGLARE
 */

VS_OUTPUT_POST VS_Sunglare(VS_INPUT_POST IN, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_SUNGLARE == 1)
	float timepassed_2=Timer.x* fVelocity_Sunglare;			
	timepassed_2=frac(timepassed_2) * 2.0 - 1.0;
	timepassed_2=abs(timepassed_2);
	float4 pos = float4(IN.pos.x + fHPosSunglare,IN.pos.y + fVPosSunglare,IN.pos.z,1.0) + timepassed_2;
#else
	float4 pos = float4(IN.pos.x + fHPosSunglare,IN.pos.y + fVPosSunglare,IN.pos.z,1.0);
#endif
	pos.y *= ScreenSize.z;

#if (USE_DISPERSION_BOOST == 1)
	float timepassed_Dispersion=Timer.x* fBoost_Sunglare;			
	timepassed_Dispersion=frac(timepassed_Dispersion) * 2.0 - 1.0;
	timepassed_Dispersion=abs(timepassed_Dispersion);
	float l = length(LightParameters.xy)  + timepassed_Dispersion;
#else
	float l = length(LightParameters.xy);
#endif
	float timepassed_Scale_Sunglare=(Timer.x* (fScaleTimeFactor_Sunglare * 8.0));			
	timepassed_Scale_Sunglare=frac(timepassed_Scale_Sunglare) * 2.0 - 1.0;
	timepassed_Scale_Sunglare=abs(timepassed_Scale_Sunglare);
	float scaleFactor = (2.0 - 1.0 / (l * l + 1.0)) * scale;
	float2 shift = LightParameters.xy;

#if (USE_SCALE_VARIATIONS_SUNGLARE == 1)
	pos.xy=pos.xy*(scaleFactor * (fScaleSunglare + timepassed_Scale_Sunglare))  + shift;
 #else
	pos.xy=pos.xy * (scaleFactor *  fScaleSunglare) + shift;
#endif
	OUT.vpos = pos;
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}

float4 PS_Sunglare(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, fContrastSunglare);
	clip(sunmask-0.02);					
	float4 origcolor=tex2D(SamplerColor, coord.xy);

	float amplitudeSunglare = 1.0;
	float frequencySunglare = 1.0;
	float TimeFactorSunglare=(0.5 * sin(2 * PI * frequencySunglare * Timer.x * (8.0 * fIntTimeFactor_Sunglare)) + 0.75) * amplitudeSunglare;	//+ 0.5 Non-Limiter

#if (USE_LIGHT_SUNGLARE == 1)
	float timepassed_Light2=Timer.x* fLightVelocity_Sunglare;
	timepassed_Light2=frac(timepassed_Light2) * 2.0 - 1.0;
	timepassed_Light2=abs(timepassed_Light2);
	float timepassed_Pulse=(Timer.x* timepassed_Light2)* 20.0;		//KYO : Timer in Timer :P
	timepassed_Pulse=frac(timepassed_Pulse) * 2.0 - 1.0;
	timepassed_Pulse=abs(timepassed_Pulse);
	sunmask*=(LightParameters.w + timepassed_Light2) * (fLensIntensity * (fIntensitySunglare - timepassed_Light2 * 1.1));
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensitySunglare);
#endif

#if (USE_INTENSITY_VARIATIONS_SUNGLARE == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensitySunglare) * TimeFactorSunglare );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensitySunglare);
#endif
	res.xyz=origcolor.a * sunmask;
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

/**
 *	SECONDARY_2
 */

VS_OUTPUT_POST VS_Secondary_2(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_SECONDARY_2 == 1)
	float timepassed_3=Timer.x* fVelocity_Secondary_2;			
	timepassed_3=frac(timepassed_3) * 2.0 - 1.0;
	timepassed_3=abs(timepassed_3);
	float4 pos = float4(IN.pos.x + fHPosSecondary_2,IN.pos.y + fVPosSecondary_2,IN.pos.z,1.0) + timepassed_3;
#else
	float4 pos = float4(IN.pos.x + fHPosSecondary_2,IN.pos.y + fVPosSecondary_2,IN.pos.z,1.0);
#endif		
	pos.y*=ScreenSize.z;

	float timepassed_Scale_Secondary_2=(Timer.x* (fScaleTimeFactor_Secondary_2 * 8.0));			
	timepassed_Scale_Secondary_2=frac(timepassed_Scale_Secondary_2) * 2.0 - 1.0;
	timepassed_Scale_Secondary_2=abs(timepassed_Scale_Secondary_2);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_SECONDARY_2 == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScaleSecondary_2 + timepassed_Scale_Secondary_2))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScaleSecondary_2)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Secondary_2(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, fContrastSecondary_2);				
	clip(sunmask-0.02);							

	float timepassed_Scale_Secondary_2=(Timer.x* (fScaleTimeFactor_Secondary_2 * 8.0));			
	timepassed_Scale_Secondary_2=frac(timepassed_Scale_Secondary_2) * 2.0 - 1.0;
	timepassed_Scale_Secondary_2=abs(timepassed_Scale_Secondary_2);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;
	
#if (USE_LENS_DISTORTIONS_SECONDARY_2 == 1)
#if (USE_CHROMA_FORMULA_SECONDARY_2 == 1)
	float3 eta_Secondary_2 = float3(1.0+fChromaticAmount_Secondary_2*0.9,1.0+fChromaticAmount_Secondary_2*0.6,1.0+fChromaticAmount_Secondary_2*0.3);
#elif (USE_CHROMA_FORMULA_SECONDARY_2 == 2)
	float3 eta_Secondary_2 = float3(1.0+fChromaticAmount_Secondary_2*0.6,1.0+fChromaticAmount_Secondary_2*0.9,1.0+fChromaticAmount_Secondary_2*0.3);
#elif (USE_CHROMA_FORMULA_SECONDARY_2 == 3)
	float3 eta_Secondary_2 = float3(1.0+fChromaticAmount_Secondary_2*0.3,1.0+fChromaticAmount_Secondary_2*0.6,1.0+fChromaticAmount_Secondary_2*0.9);
#elif (USE_CHROMA_FORMULA_SECONDARY_2 == 4)
	float3 eta_Secondary_2 = float3(1.0+fChromaticAmount_Secondary_2*0.3,1.0+fChromaticAmount_Secondary_2*0.9,1.0+fChromaticAmount_Secondary_2*0.6);
#elif (USE_CHROMA_FORMULA_SECONDARY_2 == 5)
	float3 eta_Secondary_2 = float3(1.0+fChromaticAmount_Secondary_2*0.3,1.0+fChromaticAmount_Secondary_2*0.3,1.0+fChromaticAmount_Secondary_2*0.3);
#elif (USE_CHROMA_FORMULA_SECONDARY_2 == 6)
	float3 eta_Secondary_2 = float3(1.0+fChromaticAmount_Secondary_2*0.9,1.0+fChromaticAmount_Secondary_2*0.3,1.0+fChromaticAmount_Secondary_2*0.3);
#elif (USE_CHROMA_FORMULA_SECONDARY_2 == 7)
	float3 eta_Secondary_2 = float3(1.0+fChromaticAmount_Secondary_2*0.9,1.0+fChromaticAmount_Secondary_2*0.9,1.0+fChromaticAmount_Secondary_2*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_SECONDARY_2 == 1)
	float LensZoom_Secondary_2 = (1.0 / fLensSize_Secondary_2) * (fLensScaleFactor * (fScaleSecondary_2 + timepassed_Scale_Secondary_2));	//Index on Timed-Size Vars
#else
	float LensZoom_Secondary_2 = 1.0 / fLensSize_Secondary_2;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Secondary_2 == 0.0){
 	f = 1 + r2 * fLensDistortion_Secondary_2;
	}else{
      	f = 1 + r2 * (fLensDistortion_Secondary_2 + fLensDistortionCubic_Secondary_2 * sqrt(r2));
	};

	float x = (f*LensZoom_Secondary_2*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Secondary_2*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Secondary_2.r)*LensZoom_Secondary_2*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Secondary_2.g)*LensZoom_Secondary_2*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Secondary_2.b)*LensZoom_Secondary_2*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif	

	float amplitudeSecondary_2 = 1.0;
	float frequencySecondary_2 = 1.0;
	float TimeFactorSecondary_2=(0.5 * sin(2 * PI * frequencySecondary_2 * Timer.x * (8.0 * fIntTimeFactor_Secondary_2)) + 0.75) * amplitudeSecondary_2;	//+ 0.5 Non-Limiter
	float timepassed_Light3=Timer.x* fLightVelocity_Secondary_2;		
	timepassed_Light3=frac(timepassed_Light3) * 2.0 - 1.0;
	timepassed_Light3=abs(timepassed_Light3);

#if (USE_LIGHT_SECONDARY_2 == 1)
	sunmask*=(LightParameters.w + timepassed_Light3) * (fLensIntensity * (fIntensitySecondary_2 - timepassed_Light3 * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensitySecondary_2);
#endif
#if (USE_INTENSITY_VARIATIONS_SECONDARY_2 == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensitySecondary_2) * TimeFactorSecondary_2 );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensitySecondary_2);
#endif

#if (USE_LENS_DISTORTIONS_SECONDARY_2 == 1)
	res.xyz=origcolor.xyz * sunmask;
#else
	res.xyz=origcolor * sunmask;
#endif
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

/**
 *	PRIMARY
 */

VS_OUTPUT_POST VS_Primary(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_PRIMARY == 1)
	float timepassed_4=Timer.x* fVelocity_Primary;			
	timepassed_4=frac(timepassed_4) * 2.0 - 1.0;
	timepassed_4=abs(timepassed_4);
	float4 pos = float4(IN.pos.x + fHPosPrimary,IN.pos.y + fVPosPrimary,IN.pos.z,1.0) + timepassed_4;
#else
	float4 pos = float4(IN.pos.x + fHPosPrimary,IN.pos.y + fVPosPrimary,IN.pos.z,1.0);
#endif
	pos.y*=ScreenSize.z;
	float timepassed_Scale_Primary=(Timer.x* (fScaleTimeFactor_Primary * 8.0));			
	timepassed_Scale_Primary=frac(timepassed_Scale_Primary) * 2.0 - 1.0;
	timepassed_Scale_Primary=abs(timepassed_Scale_Primary);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_PRIMARY == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScalePrimary + timepassed_Scale_Primary))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScalePrimary)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Primary(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, fContrastPrimary);					
	clip(sunmask-0.02);	
						
	float timepassed_Scale_Primary=(Timer.x* (fScaleTimeFactor_Primary * 8.0));			
	timepassed_Scale_Primary=frac(timepassed_Scale_Primary) * 2.0 - 1.0;
	timepassed_Scale_Primary=abs(timepassed_Scale_Primary);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;

#if (USE_LENS_DISTORTIONS_PRIMARY == 1)
#if (USE_CHROMA_FORMULA_PRIMARY == 1)
	float3 eta_Primary = float3(1.0+fChromaticAmount_Primary*0.9,1.0+fChromaticAmount_Primary*0.6,1.0+fChromaticAmount_Primary*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY == 2)
	float3 eta_Primary = float3(1.0+fChromaticAmount_Primary*0.6,1.0+fChromaticAmount_Primary*0.9,1.0+fChromaticAmount_Primary*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY == 3)
	float3 eta_Primary = float3(1.0+fChromaticAmount_Primary*0.3,1.0+fChromaticAmount_Primary*0.6,1.0+fChromaticAmount_Primary*0.9);
#elif (USE_CHROMA_FORMULA_PRIMARY == 4)
	float3 eta_Primary = float3(1.0+fChromaticAmount_Primary*0.3,1.0+fChromaticAmount_Primary*0.9,1.0+fChromaticAmount_Primary*0.6);
#elif (USE_CHROMA_FORMULA_PRIMARY == 5)
	float3 eta_Primary = float3(1.0+fChromaticAmount_Primary*0.3,1.0+fChromaticAmount_Primary*0.3,1.0+fChromaticAmount_Primary*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY == 6)
	float3 eta_Primary = float3(1.0+fChromaticAmount_Primary*0.9,1.0+fChromaticAmount_Primary*0.3,1.0+fChromaticAmount_Primary*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY == 7)
	float3 eta_Primary = float3(1.0+fChromaticAmount_Primary*0.9,1.0+fChromaticAmount_Primary*0.9,1.0+fChromaticAmount_Primary*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_PRIMARY == 1)
	float LensZoom_Primary = (1.0 / fLensSize_Primary) * (fLensScaleFactor * (fScalePrimary + timepassed_Scale_Primary));	//Index on Timed-Size Vars
#else
	float LensZoom_Primary = 1.0 / fLensSize_Primary;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Primary == 0.0){
 	f = 1 + r2 * fLensDistortion_Primary;
	}else{
      	f = 1 + r2 * (fLensDistortion_Primary + fLensDistortionCubic_Primary * sqrt(r2));
	};

	float x = (f*LensZoom_Primary*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Primary*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Primary.r)*LensZoom_Primary*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Primary.g)*LensZoom_Primary*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Primary.b)*LensZoom_Primary*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif	

	float amplitudePrimary = 1.0;
	float frequencyPrimary = 1.0;
	float TimeFactorPrimary=(0.5 * sin(2 * PI * frequencyPrimary * Timer.x * (8.0 * fIntTimeFactor_Primary)) + 0.75) * amplitudePrimary;	//+ 0.5 Non-Limiter
	float timepassed_Light4=Timer.x* fLightVelocity_Primary;		
	timepassed_Light4=frac(timepassed_Light4) * 2.0 - 1.0;
	timepassed_Light4=abs(timepassed_Light4);

#if (USE_LIGHT_PRIMARY == 1)
	sunmask*=(LightParameters.w + timepassed_Light4) * (fLensIntensity * (fIntensityPrimary - timepassed_Light4 * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensityPrimary);
#endif
#if (USE_INTENSITY_VARIATIONS_PRIMARY == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensityPrimary) * TimeFactorPrimary );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensityPrimary);
#endif

#if (USE_LENS_DISTORTIONS_PRIMARY == 1)
	res.xyz=origcolor.xyz * sunmask;
#else
	res.xyz=origcolor * sunmask; 
#endif
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

/**
 *	THIRDARY
 */

VS_OUTPUT_POST VS_Thirdary(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_THIRDARY == 1)
	float timepassed_5=Timer.x* fVelocity_Thirdary;			
	timepassed_5=frac(timepassed_5) * 2.0 - 1.0;
	timepassed_5=abs(timepassed_5);
	float4 pos = float4(IN.pos.x + fHPosThirdary,IN.pos.y + fVPosThirdary,IN.pos.z,1.0) + timepassed_5;
#else
	float4 pos = float4(IN.pos.x + fHPosThirdary,IN.pos.y + fVPosThirdary,IN.pos.z,1.0);
#endif		
	pos.y*=ScreenSize.z;
	float timepassed_Scale_Thirdary=(Timer.x* (fScaleTimeFactor_Thirdary * 8.0));			
	timepassed_Scale_Thirdary=frac(timepassed_Scale_Thirdary) * 2.0 - 1.0;
	timepassed_Scale_Thirdary=abs(timepassed_Scale_Thirdary);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_THIRDARY == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScaleThirdary + timepassed_Scale_Thirdary))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScaleThirdary)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Thirdary(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;

	//read sun visibility as amount of effect
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, fContrastThirdary);					
	clip(sunmask-0.02);		
	
	float timepassed_Scale_Thirdary=(Timer.x* (fScaleTimeFactor_Thirdary * 8.0));			
	timepassed_Scale_Thirdary=frac(timepassed_Scale_Thirdary) * 2.0 - 1.0;
	timepassed_Scale_Thirdary=abs(timepassed_Scale_Thirdary);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;

#if (USE_LENS_DISTORTIONS_THIRDARY == 1)
#if (USE_CHROMA_FORMULA_THIRDARY == 1)
	float3 eta_Thirdary = float3(1.0+fChromaticAmount_Thirdary*0.9,1.0+fChromaticAmount_Thirdary*0.6,1.0+fChromaticAmount_Thirdary*0.3);
#elif (USE_CHROMA_FORMULA_THIRDARY == 2)
	float3 eta_Thirdary = float3(1.0+fChromaticAmount_Thirdary*0.6,1.0+fChromaticAmount_Thirdary*0.9,1.0+fChromaticAmount_Thirdary*0.3);
#elif (USE_CHROMA_FORMULA_THIRDARY == 3)
	float3 eta_Thirdary = float3(1.0+fChromaticAmount_Thirdary*0.3,1.0+fChromaticAmount_Thirdary*0.6,1.0+fChromaticAmount_Thirdary*0.9);
#elif (USE_CHROMA_FORMULA_THIRDARY == 4)
	float3 eta_Thirdary = float3(1.0+fChromaticAmount_Thirdary*0.3,1.0+fChromaticAmount_Thirdary*0.9,1.0+fChromaticAmount_Thirdary*0.6);
#elif (USE_CHROMA_FORMULA_THIRDARY == 5)
	float3 eta_Thirdary = float3(1.0+fChromaticAmount_Thirdary*0.3,1.0+fChromaticAmount_Thirdary*0.3,1.0+fChromaticAmount_Thirdary*0.3);
#elif (USE_CHROMA_FORMULA_THIRDARY == 6)
	float3 eta_Thirdary = float3(1.0+fChromaticAmount_Thirdary*0.9,1.0+fChromaticAmount_Thirdary*0.3,1.0+fChromaticAmount_Thirdary*0.3);
#elif (USE_CHROMA_FORMULA_THIRDARY == 7)
	float3 eta_Thirdary = float3(1.0+fChromaticAmount_Thirdary*0.9,1.0+fChromaticAmount_Thirdary*0.9,1.0+fChromaticAmount_Thirdary*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_THIRDARY == 1)
	float LensZoom_Thirdary = (1.0 / fLensSize_Thirdary) * (fLensScaleFactor * (fScaleThirdary + timepassed_Scale_Thirdary));	//Index on Timed-Size Vars
#else
	float LensZoom_Thirdary = 1.0 / fLensSize_Thirdary;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Thirdary == 0.0){
 	f = 1 + r2 * fLensDistortion_Thirdary;
	}else{
      	f = 1 + r2 * (fLensDistortion_Thirdary + fLensDistortionCubic_Thirdary * sqrt(r2));
	};

	float x = (f*LensZoom_Thirdary*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Thirdary*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Thirdary.r)*LensZoom_Thirdary*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Thirdary.g)*LensZoom_Thirdary*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Thirdary.b)*LensZoom_Thirdary*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif	

	float amplitudeThirdary = 1.0;
	float frequencyThirdary = 1.0;
	float TimeFactorThirdary=(0.5 * sin(2 * PI * frequencyThirdary * Timer.x * (8.0 * fIntTimeFactor_Thirdary)) + 0.75) * amplitudeThirdary;	//+ 0.5 Non-Limiter
	float timepassed_Light5=Timer.x* fLightVelocity_Thirdary;		
	timepassed_Light5=frac(timepassed_Light5) * 2.0 - 1.0;
	timepassed_Light5=abs(timepassed_Light5);

#if (USE_LIGHT_THIRDARY == 1)
	sunmask*=(LightParameters.w + timepassed_Light5) * (fLensIntensity * (fIntensityThirdary - timepassed_Light5 * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensityThirdary);
#endif
#if (USE_INTENSITY_VARIATIONS_THIRDARY == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensityThirdary) * TimeFactorThirdary );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensityThirdary);
#endif

#if (USE_LENS_DISTORTIONS_THIRDARY == 1)
	res.xyz=origcolor.xyz * sunmask;
#else
	res.xyz=origcolor * sunmask;
#endif
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

/**
 *	THIRDARY_2
 */

VS_OUTPUT_POST VS_Thirdary_2(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_THIRDARY_2 == 1)
	float timepassed_6=Timer.x* fVelocity_Thirdary_2;			
	timepassed_6=frac(timepassed_6) * 2.0 - 1.0;
	timepassed_6=abs(timepassed_6);
	float4 pos = float4(IN.pos.x + fHPosThirdary_2,IN.pos.y + fVPosThirdary_2,IN.pos.z,1.0) + timepassed_6;
#else
	float4 pos = float4(IN.pos.x + fHPosThirdary_2,IN.pos.y + fVPosThirdary_2,IN.pos.z,1.0);
#endif
	pos.y*=ScreenSize.z;
	float timepassed_Scale_Thirdary_2=(Timer.x* (fScaleTimeFactor_Thirdary_2 * 8.0));			
	timepassed_Scale_Thirdary_2=frac(timepassed_Scale_Thirdary_2) * 2.0 - 1.0;
	timepassed_Scale_Thirdary_2=abs(timepassed_Scale_Thirdary_2);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_THIRDARY_2 == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScaleThirdary_2 + timepassed_Scale_Thirdary_2))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScaleThirdary_2)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Thirdary_2(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, fContrastThirdary_2);					
	clip(sunmask-0.02);		
	
	float timepassed_Scale_Thirdary_2=(Timer.x* (fScaleTimeFactor_Thirdary_2 * 8.0));			
	timepassed_Scale_Thirdary_2=frac(timepassed_Scale_Thirdary_2) * 2.0 - 1.0;
	timepassed_Scale_Thirdary_2=abs(timepassed_Scale_Thirdary_2);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;

#if (USE_LENS_DISTORTIONS_THIRDARY_2 == 1)
#if (USE_CHROMA_FORMULA_THIRDARY_2 == 1)
	float3 eta_Thirdary_2 = float3(1.0+fChromaticAmount_Thirdary_2*0.9,1.0+fChromaticAmount_Thirdary_2*0.6,1.0+fChromaticAmount_Thirdary_2*0.3);
#elif (USE_CHROMA_FORMULA_THIRDARY_2 == 2)
	float3 eta_Thirdary_2 = float3(1.0+fChromaticAmount_Thirdary_2*0.6,1.0+fChromaticAmount_Thirdary_2*0.9,1.0+fChromaticAmount_Thirdary_2*0.3);
#elif (USE_CHROMA_FORMULA_THIRDARY_2 == 3)
	float3 eta_Thirdary_2 = float3(1.0+fChromaticAmount_Thirdary_2*0.3,1.0+fChromaticAmount_Thirdary_2*0.6,1.0+fChromaticAmount_Thirdary_2*0.9);
#elif (USE_CHROMA_FORMULA_THIRDARY_2 == 4)
	float3 eta_Thirdary_2 = float3(1.0+fChromaticAmount_Thirdary_2*0.3,1.0+fChromaticAmount_Thirdary_2*0.9,1.0+fChromaticAmount_Thirdary_2*0.6);
#elif (USE_CHROMA_FORMULA_THIRDARY_2 == 5)
	float3 eta_Thirdary_2 = float3(1.0+fChromaticAmount_Thirdary_2*0.3,1.0+fChromaticAmount_Thirdary_2*0.3,1.0+fChromaticAmount_Thirdary_2*0.3);
#elif (USE_CHROMA_FORMULA_THIRDARY_2 == 6)
	float3 eta_Thirdary_2 = float3(1.0+fChromaticAmount_Thirdary_2*0.9,1.0+fChromaticAmount_Thirdary_2*0.3,1.0+fChromaticAmount_Thirdary_2*0.3);
#elif (USE_CHROMA_FORMULA_THIRDARY_2 == 7)
	float3 eta_Thirdary_2 = float3(1.0+fChromaticAmount_Thirdary_2*0.9,1.0+fChromaticAmount_Thirdary_2*0.9,1.0+fChromaticAmount_Thirdary_2*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_THIRDARY_2 == 1)
	float LensZoom_Thirdary_2 = (1.0 / fLensSize_Thirdary_2) * (fLensScaleFactor * (fScaleThirdary_2 + timepassed_Scale_Thirdary_2));	//Index on Timed-Size Vars
#else
	float LensZoom_Thirdary_2 = 1.0 / fLensSize_Thirdary_2;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Thirdary_2 == 0.0){
 	f = 1 + r2 * fLensDistortion_Thirdary_2;
	}else{
      	f = 1 + r2 * (fLensDistortion_Thirdary_2 + fLensDistortionCubic_Thirdary_2 * sqrt(r2));
	};

	float x = (f*LensZoom_Thirdary_2*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Thirdary_2*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Thirdary_2.r)*LensZoom_Thirdary_2*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Thirdary_2.g)*LensZoom_Thirdary_2*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Thirdary_2.b)*LensZoom_Thirdary_2*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif	

	float amplitudeThirdary_2 = 1.0;
	float frequencyThirdary_2 = 1.0;
	float TimeFactorThirdary_2=(0.5 * sin(2 * PI * frequencyThirdary_2 * Timer.x * (8.0 * fIntTimeFactor_Thirdary_2)) + 0.75) * amplitudeThirdary_2;	//+ 0.5 Non-Limiter
	float timepassed_Light6=Timer.x* fLightVelocity_Thirdary_2;		
	timepassed_Light6=frac(timepassed_Light6) * 2.0 - 1.0;
	timepassed_Light6=abs(timepassed_Light6);

#if (USE_LIGHT_THIRDARY_2 == 1)
	sunmask*=(LightParameters.w + timepassed_Light6) * (fLensIntensity * (fIntensityThirdary_2 - timepassed_Light6 * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensityThirdary_2);
#endif
#if (USE_INTENSITY_VARIATIONS_THIRDARY_2 == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensityThirdary_2) * TimeFactorThirdary_2 );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensityThirdary_2);
#endif

#if (USE_LENS_DISTORTIONS_THIRDARY_2 == 1)
	res.xyz=origcolor.xyz * sunmask;
#else
	res.xyz=origcolor * sunmask;
#endif
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

/**
 *	PRIMARY_ALT
 */

VS_OUTPUT_POST VS_Primary_Alt(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_PRIMARY_ALT == 1)
	float timepassed_7=Timer.x* fVelocity_Primary_Alt;			
	timepassed_7=frac(timepassed_7) * 2.0 - 1.0;
	timepassed_7=abs(timepassed_7);
	float4 pos = float4(IN.pos.x + fHPosPrimary_Alt,IN.pos.y + fVPosPrimary_Alt,IN.pos.z,1.0) + timepassed_7;
#else
	float4 pos = float4(IN.pos.x + fHPosPrimary_Alt,IN.pos.y + fVPosPrimary_Alt,IN.pos.z,1.0);
#endif
	pos.y*=ScreenSize.z;
	float timepassed_Scale_Primary_Alt=(Timer.x* (fScaleTimeFactor_Primary_Alt * 80.0));			
	timepassed_Scale_Primary_Alt=frac(timepassed_Scale_Primary_Alt) * 2.0 - 1.0;
	timepassed_Scale_Primary_Alt=abs(timepassed_Scale_Primary_Alt);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_PRIMARY_ALT == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScalePrimary_Alt + timepassed_Scale_Primary_Alt))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScalePrimary_Alt)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Primary_Alt(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask,fContrastPrimary_Alt);					
	clip(sunmask-0.02);

	float timepassed_Scale_Primary_Alt=(Timer.x* (fScaleTimeFactor_Primary_Alt * 8.0));			
	timepassed_Scale_Primary_Alt=frac(timepassed_Scale_Primary_Alt) * 2.0 - 1.0;
	timepassed_Scale_Primary_Alt=abs(timepassed_Scale_Primary_Alt);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;

#if (USE_LENS_DISTORTIONS_PRIMARY_ALT == 1)
#if (USE_CHROMA_FORMULA_PRIMARY_ALT == 1)
	float3 eta_Primary_Alt = float3(1.0+fChromaticAmount_Primary_Alt*0.9,1.0+fChromaticAmount_Primary_Alt*0.6,1.0+fChromaticAmount_Primary_Alt*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT == 2)
	float3 eta_Primary_Alt = float3(1.0+fChromaticAmount_Primary_Alt*0.6,1.0+fChromaticAmount_Primary_Alt*0.9,1.0+fChromaticAmount_Primary_Alt*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT == 3)
	float3 eta_Primary_Alt = float3(1.0+fChromaticAmount_Primary_Alt*0.3,1.0+fChromaticAmount_Primary_Alt*0.6,1.0+fChromaticAmount_Primary_Alt*0.9);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT == 4)
	float3 eta_Primary_Alt = float3(1.0+fChromaticAmount_Primary_Alt*0.3,1.0+fChromaticAmount_Primary_Alt*0.9,1.0+fChromaticAmount_Primary_Alt*0.6);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT == 5)
	float3 eta_Primary_Alt = float3(1.0+fChromaticAmount_Primary_Alt*0.3,1.0+fChromaticAmount_Primary_Alt*0.3,1.0+fChromaticAmount_Primary_Alt*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT == 6)
	float3 eta_Primary_Alt = float3(1.0+fChromaticAmount_Primary_Alt*0.9,1.0+fChromaticAmount_Primary_Alt*0.3,1.0+fChromaticAmount_Primary_Alt*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT == 7)
	float3 eta_Primary_Alt = float3(1.0+fChromaticAmount_Primary_Alt*0.9,1.0+fChromaticAmount_Primary_Alt*0.9,1.0+fChromaticAmount_Primary_Alt*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_PRIMARY_ALT == 1)
	float LensZoom_Primary_Alt = (1.0 / fLensSize_Primary_Alt) * (fLensScaleFactor * (fScalePrimary_Alt + timepassed_Scale_Primary_Alt));	//Index on Timed-Size Vars
#else
	float LensZoom_Primary_Alt = 1.0 / fLensSize_Primary_Alt;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Primary_Alt == 0.0){
 	f = 1 + r2 * fLensDistortion_Primary_Alt;
	}else{
      	f = 1 + r2 * (fLensDistortion_Primary_Alt + fLensDistortionCubic_Primary_Alt * sqrt(r2));
	};

	float x = (f*LensZoom_Primary_Alt*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Primary_Alt*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Primary_Alt.r)*LensZoom_Primary_Alt*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Primary_Alt.g)*LensZoom_Primary_Alt*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Primary_Alt.b)*LensZoom_Primary_Alt*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif
	float amplitudePrimary_Alt = 1.0;
	float frequencyPrimary_Alt = 1.0;
	float TimeFactorPrimary_Alt=(0.5 * sin(2 * PI * frequencyPrimary_Alt * Timer.x * (8.0 * fIntTimeFactor_Primary_Alt)) + 0.75) * amplitudePrimary_Alt;	//+ 0.5 Non-Limiter
	float timepassed_Light7=Timer.x* fLightVelocity_Primary_Alt;		
	timepassed_Light7=frac(timepassed_Light7) * 2.0 - 1.0;
	timepassed_Light7=abs(timepassed_Light7);

#if (USE_LIGHT_PRIMARY_ALT == 1)
	sunmask*=(LightParameters.w + timepassed_Light7) * (fLensIntensity * (fIntensityPrimary_Alt - timepassed_Light7 * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensityPrimary_Alt);
#endif
#if (USE_INTENSITY_VARIATIONS_PRIMARY_ALT == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensityPrimary_Alt) * TimeFactorPrimary_Alt );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensityPrimary_Alt);
#endif

#if (USE_LENS_DISTORTIONS_PRIMARY_ALT == 1)
	res.xyz=origcolor.xyz * sunmask; 
#else
	res.xyz=origcolor * sunmask; 
#endif
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

/**
 *	PRIMARY_ALT_2
 */

VS_OUTPUT_POST VS_Primary_Alt_2(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_PRIMARY_ALT_2 == 1)
	float timepassed_9=Timer.x* fVelocity_Primary_Alt_2;			
	timepassed_9=frac(timepassed_9) * 2.0 - 1.0;
	timepassed_9=abs(timepassed_9);
	float4 pos = float4(IN.pos.x + fHPosPrimary_Alt_2,IN.pos.y + fVPosPrimary_Alt_2,IN.pos.z,1.0) + timepassed_9;
#else
	float4 pos = float4(IN.pos.x + fHPosPrimary_Alt_2,IN.pos.y + fVPosPrimary_Alt_2,IN.pos.z,1.0);
#endif
	pos.y*=ScreenSize.z;
	float timepassed_Scale_Primary_Alt_2=(Timer.x* (fScaleTimeFactor_Primary_Alt_2 * 8.0));			
	timepassed_Scale_Primary_Alt_2=frac(timepassed_Scale_Primary_Alt_2) * 2.0 - 1.0;
	timepassed_Scale_Primary_Alt_2=abs(timepassed_Scale_Primary_Alt_2);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_PRIMARY_ALT_2 == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScalePrimary_Alt_2 + timepassed_Scale_Primary_Alt_2))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScalePrimary_Alt_2)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Primary_Alt_2(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask,fContrastPrimary_Alt_2);					
	clip(sunmask-0.02);

	float timepassed_Scale_Primary_Alt_2=(Timer.x* (fScaleTimeFactor_Primary_Alt_2 * 8.0));			
	timepassed_Scale_Primary_Alt_2=frac(timepassed_Scale_Primary_Alt_2) * 2.0 - 1.0;
	timepassed_Scale_Primary_Alt_2=abs(timepassed_Scale_Primary_Alt_2);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;

#if (USE_LENS_DISTORTIONS_PRIMARY_ALT_2 == 1)
#if (USE_CHROMA_FORMULA_PRIMARY_ALT_2 == 1)
	float3 eta_Primary_Alt_2 = float3(1.0+fChromaticAmount_Primary_Alt_2*0.9,1.0+fChromaticAmount_Primary_Alt_2*0.6,1.0+fChromaticAmount_Primary_Alt_2*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT_2 == 2)
	float3 eta_Primary_Alt_2 = float3(1.0+fChromaticAmount_Primary_Alt_2*0.6,1.0+fChromaticAmount_Primary_Alt_2*0.9,1.0+fChromaticAmount_Primary_Alt_2*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT_2 == 3)
	float3 eta_Primary_Alt_2 = float3(1.0+fChromaticAmount_Primary_Alt_2*0.3,1.0+fChromaticAmount_Primary_Alt_2*0.6,1.0+fChromaticAmount_Primary_Alt_2*0.9);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT_2 == 4)
	float3 eta_Primary_Alt_2 = float3(1.0+fChromaticAmount_Primary_Alt_2*0.3,1.0+fChromaticAmount_Primary_Alt_2*0.9,1.0+fChromaticAmount_Primary_Alt_2*0.6);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT_2 == 5)
	float3 eta_Primary_Alt_2 = float3(1.0+fChromaticAmount_Primary_Alt_2*0.3,1.0+fChromaticAmount_Primary_Alt_2*0.3,1.0+fChromaticAmount_Primary_Alt_2*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT_2 == 6)
	float3 eta_Primary_Alt_2 = float3(1.0+fChromaticAmount_Primary_Alt_2*0.9,1.0+fChromaticAmount_Primary_Alt_2*0.3,1.0+fChromaticAmount_Primary_Alt_2*0.3);
#elif (USE_CHROMA_FORMULA_PRIMARY_ALT_2 == 7)
	float3 eta_Primary_Alt_2 = float3(1.0+fChromaticAmount_Primary_Alt_2*0.9,1.0+fChromaticAmount_Primary_Alt_2*0.9,1.0+fChromaticAmount_Primary_Alt_2*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_PRIMARY_ALT_2 == 1)
	float LensZoom_Primary_Alt_2 = (1.0 / fLensSize_Primary_Alt_2) * (fLensScaleFactor * (fScalePrimary_Alt_2 + timepassed_Scale_Primary_Alt_2));	//Index on Timed-Size Vars
#else
	float LensZoom_Primary_Alt_2 = 1.0 / fLensSize_Primary_Alt_2;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Primary_Alt_2 == 0.0){
 	f = 1 + r2 * fLensDistortion_Primary_Alt_2;
	}else{
      	f = 1 + r2 * (fLensDistortion_Primary_Alt_2 + fLensDistortionCubic_Primary_Alt_2 * sqrt(r2));
	};

	float x = (f*LensZoom_Primary_Alt_2*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Primary_Alt_2*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Primary_Alt_2.r)*LensZoom_Primary_Alt_2*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Primary_Alt_2.g)*LensZoom_Primary_Alt_2*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Primary_Alt_2.b)*LensZoom_Primary_Alt_2*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif							

	float amplitudePrimary_Alt_2 = 1.0;
	float frequencyPrimary_Alt_2 = 1.0;
	float TimeFactorPrimary_Alt_2=(0.5 * sin(2 * PI * frequencyPrimary_Alt_2 * Timer.x * (8.0 * fIntTimeFactor_Primary_Alt_2)) + 0.75) * amplitudePrimary_Alt_2;	//+ 0.5 Non-Limiter
	float timepassed_Light9=Timer.x* fLightVelocity_Primary_Alt_2;		
	timepassed_Light9=frac(timepassed_Light9) * 2.0 - 1.0;
	timepassed_Light9=abs(timepassed_Light9);

#if (USE_LIGHT_PRIMARY_ALT_2 == 1)
	sunmask*=(LightParameters.w + timepassed_Light9) * (fLensIntensity * (fIntensityPrimary_Alt_2 - timepassed_Light9 * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensityPrimary_Alt_2);
#endif
#if (USE_INTENSITY_VARIATIONS_PRIMARY_ALT_2 == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensityPrimary_Alt_2) * TimeFactorPrimary_Alt_2 );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensityPrimary_Alt_2);
#endif

#if (USE_LENS_DISTORTIONS_PRIMARY_ALT_2 == 1)
	res.xyz=origcolor.xyz * sunmask; 
#else
	res.xyz=origcolor * sunmask; 
#endif 
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

/**
 *	FOURTH
 */

VS_OUTPUT_POST VS_Fourth(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_FOURTH == 1)
	float timepassed_10=Timer.x* fVelocity_Fourth;			
	timepassed_10=frac(timepassed_10) * 2.0 - 1.0;
	timepassed_10=abs(timepassed_10);
	float4 pos = float4(IN.pos.x + fHPosFourth,IN.pos.y + fVPosFourth,IN.pos.z,1.0) + timepassed_10;
#else
	float4 pos = float4(IN.pos.x + fHPosFourth,IN.pos.y + fVPosFourth,IN.pos.z,1.0);
#endif
	pos.y*=ScreenSize.z;
	float timepassed_Scale_Fourth=(Timer.x* (fScaleTimeFactor_Fourth * 8.0));			
	timepassed_Scale_Fourth=frac(timepassed_Scale_Fourth) * 2.0 - 1.0;
	timepassed_Scale_Fourth=abs(timepassed_Scale_Fourth);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_FOURTH == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScaleFourth + timepassed_Scale_Fourth))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScaleFourth)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Fourth(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask,fContrastFourth);					
	clip(sunmask-0.02);	
	
	float timepassed_Scale_Fourth=(Timer.x* (fScaleTimeFactor_Fourth * 8.0));			
	timepassed_Scale_Fourth=frac(timepassed_Scale_Fourth) * 2.0 - 1.0;
	timepassed_Scale_Fourth=abs(timepassed_Scale_Fourth);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;

#if (USE_LENS_DISTORTIONS_FOURTH == 1)
#if (USE_CHROMA_FORMULA_FOURTH == 1)
	float3 eta_Fourth = float3(1.0+fChromaticAmount_Fourth*0.9,1.0+fChromaticAmount_Fourth*0.6,1.0+fChromaticAmount_Fourth*0.3);
#elif (USE_CHROMA_FORMULA_FOURTH == 2)
	float3 eta_Fourth = float3(1.0+fChromaticAmount_Fourth*0.6,1.0+fChromaticAmount_Fourth*0.9,1.0+fChromaticAmount_Fourth*0.3);
#elif (USE_CHROMA_FORMULA_FOURTH == 3)
	float3 eta_Fourth = float3(1.0+fChromaticAmount_Fourth*0.3,1.0+fChromaticAmount_Fourth*0.6,1.0+fChromaticAmount_Fourth*0.9);
#elif (USE_CHROMA_FORMULA_FOURTH == 4)
	float3 eta_Fourth = float3(1.0+fChromaticAmount_Fourth*0.3,1.0+fChromaticAmount_Fourth*0.9,1.0+fChromaticAmount_Fourth*0.6);
#elif (USE_CHROMA_FORMULA_FOURTH == 5)
	float3 eta_Fourth = float3(1.0+fChromaticAmount_Fourth*0.3,1.0+fChromaticAmount_Fourth*0.3,1.0+fChromaticAmount_Fourth*0.3);
#elif (USE_CHROMA_FORMULA_FOURTH == 6)
	float3 eta_Fourth = float3(1.0+fChromaticAmount_Fourth*0.9,1.0+fChromaticAmount_Fourth*0.3,1.0+fChromaticAmount_Fourth*0.3);
#elif (USE_CHROMA_FORMULA_FOURTH == 7)
	float3 eta_Fourth = float3(1.0+fChromaticAmount_Fourth*0.9,1.0+fChromaticAmount_Fourth*0.9,1.0+fChromaticAmount_Fourth*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_FOURTH == 1)
	float LensZoom_Fourth = (1.0 / fLensSize_Fourth) * (fLensScaleFactor * (fScaleFourth + timepassed_Scale_Fourth));	//Index on Timed-Size Vars
#else
	float LensZoom_Fourth = 1.0 / fLensSize_Fourth;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Fourth == 0.0){
 	f = 1 + r2 * fLensDistortion_Fourth;
	}else{
      	f = 1 + r2 * (fLensDistortion_Fourth + fLensDistortionCubic_Fourth * sqrt(r2));
	};

	float x = (f*LensZoom_Fourth*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Fourth*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Fourth.r)*LensZoom_Fourth*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Fourth.g)*LensZoom_Fourth*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Fourth.b)*LensZoom_Fourth*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif	

	float amplitudeFourth = 1.0;
	float frequencyFourth = 1.0;
	float TimeFactorFourth=(0.5 * sin(2 * PI * frequencyFourth * Timer.x * (8.0 * fIntTimeFactor_Fourth)) + 0.75) * amplitudeFourth;	//+ 0.5 Non-Limiter
	float timepassed_Light10=Timer.x* fLightVelocity_Fourth;		
	timepassed_Light10=frac(timepassed_Light10) * 2.0 - 1.0;
	timepassed_Light10=abs(timepassed_Light10);

#if (USE_LIGHT_FOURTH == 1)
	sunmask*=(LightParameters.w + timepassed_Light10) * (fLensIntensity * (fIntensityFourth - timepassed_Light10 * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensityFourth);
#endif
#if (USE_INTENSITY_VARIATIONS_FOURTH == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensityFourth) * TimeFactorFourth );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensityFourth);
#endif

#if (USE_LENS_DISTORTIONS_FOURTH == 1)
	res.xyz=origcolor.xyz * sunmask; 
#else
	res.xyz=origcolor * sunmask; 
#endif
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

/**
 *	FOURTH_2
 */

VS_OUTPUT_POST VS_Fourth_2(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;
#if (USE_MOTION_FOURTH_2 == 1)
	float timepassed_11=Timer.x* fVelocity_Fourth_2;			
	timepassed_11=frac(timepassed_11) * 2.0 - 1.0;
	timepassed_11=abs(timepassed_11);
	float4 pos = float4(IN.pos.x + fHPosFourth_2,IN.pos.y + fVPosFourth_2,IN.pos.z,1.0) + timepassed_11;
#else
	float4 pos = float4(IN.pos.x + fHPosFourth_2,IN.pos.y + fVPosFourth_2,IN.pos.z,1.0);
#endif
	pos.y*=ScreenSize.z;
	float timepassed_Scale_Fourth_2=(Timer.x* (fScaleTimeFactor_Fourth_2 * 8.0));			
	timepassed_Scale_Fourth_2=frac(timepassed_Scale_Fourth_2) * 2.0 - 1.0;
	timepassed_Scale_Fourth_2=abs(timepassed_Scale_Fourth_2);

	//TO DO : create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;

#if (USE_SCALE_VARIATIONS_FOURTH_2 == 1)
	pos.xy=pos.xy*((scale * fLensScaleFactor) * (fScaleFourth_2 + timepassed_Scale_Fourth_2))  - shift;
 #else
	pos.xy=pos.xy*((scale * fLensScaleFactor) * fScaleFourth_2)  - shift;
#endif
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;
	return OUT;
}

float4 PS_Fourth_2(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask,fContrastFourth_2);					
	clip(sunmask-0.02);	
	
	float timepassed_Scale_Fourth_2=(Timer.x* (fScaleTimeFactor_Fourth_2 * 8.0));			
	timepassed_Scale_Fourth_2=frac(timepassed_Scale_Fourth_2) * 2.0 - 1.0;
	timepassed_Scale_Fourth_2=abs(timepassed_Scale_Fourth_2);

	float2 invscreensize=ScreenSize.x;
	invscreensize.y=invscreensize.y/ScreenSize.z;

#if (USE_LENS_DISTORTIONS_FOURTH_2 == 1)
#if (USE_CHROMA_FORMULA_FOURTH_2 == 1)
	float3 eta_Fourth_2 = float3(1.0+fChromaticAmount_Fourth_2*0.9,1.0+fChromaticAmount_Fourth_2*0.6,1.0+fChromaticAmount_Fourth_2*0.3);
#elif (USE_CHROMA_FORMULA_FOURTH_2 == 2)
	float3 eta_Fourth_2 = float3(1.0+fChromaticAmount_Fourth_2*0.6,1.0+fChromaticAmount_Fourth_2*0.9,1.0+fChromaticAmount_Fourth_2*0.3);
#elif (USE_CHROMA_FORMULA_FOURTH_2 == 3)
	float3 eta_Fourth_2 = float3(1.0+fChromaticAmount_Fourth_2*0.3,1.0+fChromaticAmount_Fourth_2*0.6,1.0+fChromaticAmount_Fourth_2*0.9);
#elif (USE_CHROMA_FORMULA_FOURTH_2 == 4)
	float3 eta_Fourth_2 = float3(1.0+fChromaticAmount_Fourth_2*0.3,1.0+fChromaticAmount_Fourth_2*0.9,1.0+fChromaticAmount_Fourth_2*0.6);
#elif (USE_CHROMA_FORMULA_FOURTH_2 == 5)
	float3 eta_Fourth_2 = float3(1.0+fChromaticAmount_Fourth_2*0.3,1.0+fChromaticAmount_Fourth_2*0.3,1.0+fChromaticAmount_Fourth_2*0.3);
#elif (USE_CHROMA_FORMULA_FOURTH_2 == 6)
	float3 eta_Fourth_2 = float3(1.0+fChromaticAmount_Fourth_2*0.9,1.0+fChromaticAmount_Fourth_2*0.3,1.0+fChromaticAmount_Fourth_2*0.3);
#elif (USE_CHROMA_FORMULA_FOURTH_2 == 7)
	float3 eta_Fourth_2 = float3(1.0+fChromaticAmount_Fourth_2*0.9,1.0+fChromaticAmount_Fourth_2*0.9,1.0+fChromaticAmount_Fourth_2*0.3);
#endif
	float2 center;
	center.x = coord.x-0.5;
	center.y = coord.y-0.5;

#if (USE_SCALE_VARIATIONS_FOURTH_2 == 1)
	float LensZoom_Fourth_2 = (1.0 / fLensSize_Fourth_2) * (fLensScaleFactor * (fScaleFourth_2 + timepassed_Scale_Fourth_2));	//Index on Timed-Size Vars
#else
	float LensZoom_Fourth_2 = 1.0 / fLensSize_Fourth_2;
#endif

	float r2 = (IN.txcoord.x-0.5) * (IN.txcoord.x-0.5) + (IN.txcoord.y-0.5) * (IN.txcoord.y-0.5);     
	float f = 0;
	if( fLensDistortionCubic_Fourth_2 == 0.0){
 	f = 1 + r2 * fLensDistortion_Fourth_2;
	}else{
      	f = 1 + r2 * (fLensDistortion_Fourth_2 + fLensDistortionCubic_Fourth_2 * sqrt(r2));
	};

	float x = (f*LensZoom_Fourth_2*(coord.x-0.5)+0.5);
	float y = (f*LensZoom_Fourth_2*(coord.y-0.5)+0.5);
	float2 rCoords = (f*eta_Fourth_2.r)*LensZoom_Fourth_2*(center.xy*0.5)+0.5;
	float2 gCoords = (f*eta_Fourth_2.g)*LensZoom_Fourth_2*(center.xy*0.5)+0.5;
	float2 bCoords = (f*eta_Fourth_2.b)*LensZoom_Fourth_2*(center.xy*0.5)+0.5;
	float4 inputDistord = float4(tex2D(SamplerColor,rCoords).r, tex2D(SamplerColor,gCoords).g, tex2D(SamplerColor,bCoords).b, tex2D(SamplerColor,float2(x,y)).a);
	float4 origcolor = float4(inputDistord.r,inputDistord.g,inputDistord.b,1);
	float4 tcol=origcolor;	
#else					
	float4 origcolor=tex2D(SamplerColor, coord.xy);
#endif	

	float amplitudeFourth_2 = 1.0;
	float frequencyFourth_2 = 1.0;
	float TimeFactorFourth_2=(0.5 * sin(2 * PI * frequencyFourth_2 * Timer.x * (8.0 * fIntTimeFactor_Fourth_2)) + 0.75) * amplitudeFourth_2;	//+ 0.5 Non-Limiter
	float timepassed_Light11=Timer.x* fLightVelocity_Fourth_2;		
	timepassed_Light11=frac(timepassed_Light11) * 2.0 - 1.0;
	timepassed_Light11=abs(timepassed_Light11);

#if (USE_LIGHT_FOURTH_2 == 1)
	sunmask*=(LightParameters.w + timepassed_Light11) * (fLensIntensity * (fIntensityFourth_2 - timepassed_Light11 * 1.1));		
#else
	sunmask*=LightParameters.w * (fLensIntensity * fIntensityFourth_2);
#endif
#if (USE_INTENSITY_VARIATIONS_FOURTH_2 == 1) 
	sunmask*=LightParameters.w* ((fLensIntensity * fIntensityFourth_2) * TimeFactorFourth_2 );
#else
	sunmask*=LightParameters.w* (fLensIntensity * fIntensityFourth_2);
#endif

#if (USE_LENS_DISTORTIONS_FOURTH_2 == 1)
	res.xyz=origcolor.xyz * sunmask; 
#else
	res.xyz=origcolor * sunmask; 
#endif
	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black
	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

//==================================================================================
//==================================================================================
//==================================================================================

/**
 *	TECHNIQUES
 */

technique Draw
{
#if (USE_SECONDARY == 1)
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Secondary(f1_LensOffset, (f1_LensScale * f1_LensFactor));	//offset, scale, scale factor
		PixelShader  = compile ps_3_0 PS_Secondary(f1_LensColor, f1_ColorMultiplier);			//Color RGB

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P1
	{
		VertexShader = compile vs_3_0 VS_Secondary(f2_LensOffset, (f2_LensScale * f2_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f2_LensColor, f2_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P2
	{
		VertexShader = compile vs_3_0 VS_Secondary(f3_LensOffset, (f3_LensScale * f3_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f3_LensColor, f3_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P3
	{
		VertexShader = compile vs_3_0 VS_Secondary(f4_LensOffset, (f4_LensScale * f4_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f4_LensColor, f4_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P4
	{
		VertexShader = compile vs_3_0 VS_Secondary(f5_LensOffset, (f5_LensScale * f5_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f5_LensColor, f5_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P5
	{
		VertexShader = compile vs_3_0 VS_Secondary(f6_LensOffset, (f6_LensScale * f6_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f6_LensColor, f6_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P6
	{
		VertexShader = compile vs_3_0 VS_Secondary(f7_LensOffset, (f7_LensScale * f7_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f7_LensColor, f7_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P7
	{
		VertexShader = compile vs_3_0 VS_Secondary(f8_LensOffset, (f8_LensScale * f8_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f8_LensColor, f8_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P8
	{
		VertexShader = compile vs_3_0 VS_Secondary(f9_LensOffset, (f9_LensScale * f9_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f9_LensColor, f9_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P9
	{
		VertexShader = compile vs_3_0 VS_Secondary(f10_LensOffset, (f10_LensScale * f10_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f10_LensColor, f10_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P10
	{
		VertexShader = compile vs_3_0 VS_Secondary(f11_LensOffset, (f11_LensScale * f11_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary(f11_LensColor, f11_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
#endif

// Add or Remove passes here, then renumber passes below
	
#if (USE_SUNGLARE == 1)
	pass P11
	{
		VertexShader = compile vs_3_0 VS_Sunglare(f12_LensScale);
		PixelShader  = compile ps_3_0 PS_Sunglare(f12_LensColor, f12_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P12
	{
		VertexShader = compile vs_3_0 VS_Sunglare(f13_LensScale);	
		PixelShader  = compile ps_3_0 PS_Sunglare(f13_LensColor, f13_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P13
	{
		VertexShader = compile vs_3_0 VS_Sunglare(f14_LensScale);	
		PixelShader  = compile ps_3_0 PS_Sunglare(f14_LensColor, f14_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
#endif

//Add or Remove passes here, then renumber passes below

#if (USE_SECONDARY_2 == 1)
	pass P14
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f15_LensOffset, (f15_LensScale * f15_LensFactor));	//offset, scale, scale factor
		PixelShader  = compile ps_3_0 PS_Secondary_2(f15_LensColor, f15_ColorMultiplier);			//Color RGB

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P15
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f16_LensOffset, (f16_LensScale * f16_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f16_LensColor, f16_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P16
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f17_LensOffset, (f17_LensScale * f17_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f17_LensColor, f17_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P17
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f18_LensOffset, (f18_LensScale * f18_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f18_LensColor, f18_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P18
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f19_LensOffset, (f19_LensScale * f19_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f19_LensColor, f19_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P19
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f20_LensOffset, (f20_LensScale * f20_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f20_LensColor, f20_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P20
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f21_LensOffset, (f21_LensScale * f21_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f21_LensColor, f21_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P21
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f22_LensOffset, (f22_LensScale * f22_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f22_LensColor, f22_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P22
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f23_LensOffset, (f23_LensScale * f23_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f23_LensColor, f23_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P23
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f24_LensOffset, (f24_LensScale * f24_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f24_LensColor, f24_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P24
	{
		VertexShader = compile vs_3_0 VS_Secondary_2(f25_LensOffset, (f25_LensScale * f25_LensFactor));
		PixelShader  = compile ps_3_0 PS_Secondary_2(f25_LensColor, f25_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
#endif

//Add or Remove passes here, then renumber passes below

#if (USE_PRIMARY == 1)
	pass P25
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f26_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens26)* 2.0 - 1.0), (f26_LensScale * f26_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f26_LensOffset, (f26_LensScale * f26_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f26_LensColor, f26_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P26
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f27_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens27)* 2.0 - 1.0), (f27_LensScale * f27_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f27_LensOffset, (f27_LensScale * f27_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f27_LensColor, f27_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P27
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f28_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens28)* 2.0 - 1.0), (f28_LensScale * f28_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f28_LensOffset, (f28_LensScale * f28_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f28_LensColor, f28_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P28
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f29_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens29)* 2.0 - 1.0), (f29_LensScale * f29_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f29_LensOffset, (f29_LensScale * f29_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f29_LensColor, f29_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P29
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f30_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens30)* 2.0 - 1.0), (f30_LensScale * f30_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f30_LensOffset, (f30_LensScale * f30_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f30_LensColor, f30_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P30
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f31_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens31)* 2.0 - 1.0), (f31_LensScale * f31_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f31_LensOffset, (f31_LensScale * f31_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f31_LensColor, f31_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P31
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f32_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens32)* 2.0 - 1.0), (f32_LensScale * f32_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f32_LensOffset, (f32_LensScale * f32_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f32_LensColor, f32_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P32
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f33_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens33)* 2.0 - 1.0), (f33_LensScale * f33_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f33_LensOffset, (f33_LensScale * f33_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f33_LensColor, f33_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P33
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f34_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens34)* 2.0 - 1.0), (f34_LensScale * f34_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f34_LensOffset, (f34_LensScale * f34_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f34_LensColor, f34_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P34
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f35_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens35)* 2.0 - 1.0), (f35_LensScale * f35_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f35_LensOffset, (f35_LensScale * f35_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f35_LensColor, f35_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P35
	{
#if (USE_LENSMOTION_PRIMARY == 1)
		VertexShader = compile vs_3_0 VS_Primary(f36_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens36)* 2.0 - 1.0), (f36_LensScale * f36_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary(f36_LensOffset, (f36_LensScale * f36_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary(f36_LensColor, f36_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
#endif

//Add or Remove passes here, then renumber passes below

#if (USE_THIRDARY == 1)
	pass P36
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f37_LensOffset, (f37_LensScale * f37_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f37_LensColor, f37_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P37
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f38_LensOffset, (f38_LensScale * f38_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f38_LensColor, f38_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P38
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f39_LensOffset, (f39_LensScale * f39_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f39_LensColor, f39_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P39
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f40_LensOffset, (f40_LensScale * f40_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f40_LensColor, f40_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P40
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f41_LensOffset, (f41_LensScale * f41_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f41_LensColor, f41_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P41
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f42_LensOffset, (f42_LensScale * f42_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f42_LensColor, f42_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P42
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f43_LensOffset, (f43_LensScale * f43_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f43_LensColor, f43_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P43
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f44_LensOffset, (f44_LensScale * f44_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f44_LensColor, f44_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P44
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f45_LensOffset, (f45_LensScale * f45_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f45_LensColor, f45_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P45
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f46_LensOffset, (f46_LensScale * f46_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f46_LensColor, f46_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P46
	{
		VertexShader = compile vs_3_0 VS_Thirdary(f47_LensOffset, (f47_LensScale * f47_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary(f47_LensColor, f47_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
#endif

//Add or Remove passes here, then renumber passes below

#if (USE_THIRDARY_2 == 1)
	pass P47
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f48_LensOffset, (f48_LensScale * f48_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f48_LensColor, f48_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P48
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f49_LensOffset, (f49_LensScale * f49_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f49_LensColor, f49_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P49
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f50_LensOffset, (f50_LensScale * f50_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f50_LensColor, f50_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P50
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f51_LensOffset, (f51_LensScale * f51_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f51_LensColor, f51_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P51
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f52_LensOffset, (f52_LensScale * f52_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f52_LensColor, f52_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P52
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f53_LensOffset, (f53_LensScale * f53_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f53_LensColor, f53_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P53
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f54_LensOffset, (f54_LensScale * f54_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f54_LensColor, f54_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P54
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f55_LensOffset, (f55_LensScale * f55_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f55_LensColor, f55_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P55
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f56_LensOffset, (f56_LensScale * f56_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f56_LensColor, f56_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P56
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f57_LensOffset, (f57_LensScale * f57_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f57_LensColor, f57_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P57
	{
		VertexShader = compile vs_3_0 VS_Thirdary_2(f58_LensOffset, (f58_LensScale * f58_LensFactor));
		PixelShader  = compile ps_3_0 PS_Thirdary_2(f58_LensColor, f58_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
#endif

//Add or Remove passes here, then renumber passes below

#if (USE_PRIMARY_ALT == 1)
	pass P58
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f59_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens59)* 2.0 - 1.0), (f59_LensScale * f59_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f59_LensOffset, (f59_LensScale * f59_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f59_LensColor, f59_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P59
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f60_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens60)* 2.0 - 1.0), (f60_LensScale * f60_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f60_LensOffset, (f60_LensScale * f60_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f60_LensColor, f60_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P60
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f61_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens61)* 2.0 - 1.0), (f61_LensScale * f61_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f61_LensOffset, (f61_LensScale * f61_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f61_LensColor, f61_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P61
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f62_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens62)* 2.0 - 1.0), (f62_LensScale * f62_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f62_LensOffset, (f62_LensScale * f62_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f62_LensColor, f62_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P62
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f63_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens63)* 2.0 - 1.0), (f63_LensScale * f63_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f63_LensOffset, (f63_LensScale * f63_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f63_LensColor, f63_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P63
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f64_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens64)* 2.0 - 1.0), (f64_LensScale * f64_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f64_LensOffset, (f64_LensScale * f64_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f64_LensColor, f64_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P64
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f65_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens65)* 2.0 - 1.0), (f65_LensScale * f65_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f65_LensOffset, (f65_LensScale * f65_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f65_LensColor, f65_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P65
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f66_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens66)* 2.0 - 1.0), (f66_LensScale * f66_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f66_LensOffset, (f66_LensScale * f66_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f66_LensColor, f66_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P66
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f67_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens67)* 2.0 - 1.0), (f67_LensScale * f67_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f67_LensOffset, (f67_LensScale * f67_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f67_LensColor, f67_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P67
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f68_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens68)* 2.0 - 1.0), (f68_LensScale * f68_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f68_LensOffset, (f68_LensScale * f68_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f68_LensColor, f68_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P68
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f69_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens69)* 2.0 - 1.0), (f69_LensScale * f69_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f69_LensOffset, (f69_LensScale * f69_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f69_LensColor, f69_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P69
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f70_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens70)* 2.0 - 1.0), (f70_LensScale * f70_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f70_LensOffset, (f70_LensScale * f70_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f70_LensColor, f70_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P70
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f71_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens71)* 2.0 - 1.0), (f71_LensScale * f71_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f71_LensOffset, (f71_LensScale * f71_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f71_LensColor, f71_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P71
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f72_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens72)* 2.0 - 1.0), (f72_LensScale * f72_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f72_LensOffset, (f72_LensScale * f72_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f72_LensColor, f72_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P72
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f73_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens73)* 2.0 - 1.0), (f73_LensScale * f73_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f73_LensOffset, (f73_LensScale * f73_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f73_LensColor, f73_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P73
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f74_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens74)* 2.0 - 1.0), (f74_LensScale * f74_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f74_LensOffset, (f74_LensScale * f74_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f74_LensColor, f74_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P74
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f75_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens75)* 2.0 - 1.0), (f75_LensScale * f75_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f75_LensOffset, (f75_LensScale * f75_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f75_LensColor, f75_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P75
	{
#if (USE_LENSMOTION_PRIMARY_ALT == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt(f76_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens76)* 2.0 - 1.0), (f76_LensScale * f76_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt(f76_LensOffset, (f76_LensScale * f76_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt(f76_LensColor, f76_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

#endif

//Add or Remove passes here, then renumber passes below
#if (USE_PRIMARY_ALT_2 == 1)
	pass P76
	{
#if (USE_LENSMOTION_PRIMARY_ALT_2 == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt_2(f77_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens77)* 2.0 - 1.0), (f77_LensScale * f77_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt_2(f77_LensOffset, (f77_LensScale * f77_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt_2(f77_LensColor, f77_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P77
	{
#if (USE_LENSMOTION_PRIMARY_ALT_2 == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt_2(f78_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens78)* 2.0 - 1.0), (f78_LensScale * f78_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt_2(f78_LensOffset, (f78_LensScale * f78_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt_2(f78_LensColor, f78_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P78
	{
#if (USE_LENSMOTION_PRIMARY_ALT_2 == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt_2(f79_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens79)* 2.0 - 1.0), (f79_LensScale * f79_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt_2(f79_LensOffset, (f79_LensScale * f79_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt_2(f79_LensColor, f79_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P79
	{
#if (USE_LENSMOTION_PRIMARY_ALT_2 == 1)
		VertexShader = compile vs_3_0 VS_Primary_Alt_2(f80_LensOffset + abs(frac(Timer.x * fMotionVelocity_Lens80)* 2.0 - 1.0), (f80_LensScale * f80_LensFactor));
#else
		VertexShader = compile vs_3_0 VS_Primary_Alt_2(f80_LensOffset, (f80_LensScale * f80_LensFactor));
#endif
		PixelShader  = compile ps_3_0 PS_Primary_Alt_2(f80_LensColor, f80_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

#endif

//Add or Remove passes here, then renumber passes below
#if (USE_FOURTH == 1)
	pass P80
	{
		VertexShader = compile vs_3_0 VS_Fourth(f81_LensOffset, (f81_LensScale * f81_LensFactor));
		PixelShader  = compile ps_3_0 PS_Fourth(f81_LensColor, f81_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P81
	{
		VertexShader = compile vs_3_0 VS_Fourth(f82_LensOffset, (f82_LensScale * f82_LensFactor));
		PixelShader  = compile ps_3_0 PS_Fourth(f82_LensColor, f82_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P82
	{
		VertexShader = compile vs_3_0 VS_Fourth(f83_LensOffset, (f83_LensScale * f83_LensFactor));
		PixelShader  = compile ps_3_0 PS_Fourth(f83_LensColor, f83_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
#endif

//Add or Remove passes here, then renumber passes below
#if (USE_FOURTH_2 == 1)
	pass P83
	{
		VertexShader = compile vs_3_0 VS_Fourth_2(f84_LensOffset, (f84_LensScale * f84_LensFactor));
		PixelShader  = compile ps_3_0 PS_Fourth_2(f84_LensColor, f84_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P84
	{
		VertexShader = compile vs_3_0 VS_Fourth_2(f85_LensOffset, (f85_LensScale * f85_LensFactor));
		PixelShader  = compile ps_3_0 PS_Fourth_2(f85_LensColor, f85_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P85
	{
		VertexShader = compile vs_3_0 VS_Fourth_2(f86_LensOffset, (f86_LensScale * f86_LensFactor));
		PixelShader  = compile ps_3_0 PS_Fourth_2(f86_LensColor, f86_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
#endif

//Add or Remove passes here, then renumber passes below

}