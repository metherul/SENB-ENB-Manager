//++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// visit http://enbdev.com for updates
// Copyright (c) 2007-2013 Boris Vorontsov
// Nighteye code by scegielski http://www.nexusmods.com/skyrim/mods/50731/?
//++++++++++++++++++++++++++++++++++++++++++++

//use original game processing first, then mine
//#define APPLYGAMECOLORCORRECTION

//#define LETTERBOX_BARS      1   // Enable Matso's cinematic bars (black bars at top and bottom).

// #########################
// BEGIN NIGHTEYE  UTILITIES
// #########################

// ##########################################
// INCLUDE ENHANCED ENB DIAGNOSTICS  HEADER
// ##########################################
#include "EnhancedENBDiagnostics.fxh"

	float3 RGBtoHSV(float3 c)
	{
		float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
		float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
		float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));

		float d = q.x - min(q.w, q.y);
		float e = 1.0e-10;
		return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
	}

	float3 HSVtoRGB(float3 c)
	{
		float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
		float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
		return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
	}

	float randomNoise(in float3 uvw)
	{
		float3 noise = (frac(sin(dot(uvw ,float3(12.9898,78.233, 42.2442)*2.0)) * 43758.5453));
		return abs(noise.x + noise.y + noise.z) * 0.3333;
	}

	float linStep(float minVal, float maxVal, float t)
	{
		return saturate((t - minVal) / (maxVal - minVal));
	}
// #########################
// END NIGHTEYE  UTILITIES
// #########################

//+++++++++++++++++++++++++++++
//internal parameters, can be modified
//+++++++++++++++++++++++++++++

//float fLetterboxOffset = 8.0;                      // size of screen to be blacken (in %)
float2 fvTexelSize = float2(1.0 / 1920, 1.0 / 1080.0); // Enter you're display resolution here.

//------------------------------------
//prod80 color filter parameters start
//------------------------------------

bool Section_CF <
   string UIName =  "------Color Filter----------";
> = {false};
bool use_colorhuefx <
   string UIName="Enable Color Filter";
   //Enable - Disable effect
> = {true};
bool use_colorsaturation <
   string UIName="Color Filter: Use Orig. Saturation";
   //The above will use original color saturation as an added limiter to the strength of the effect
> = {false};
float hueMid <
   string UIName="Color Filter: Hue Middle";
   //Set the middle Hue value, which is the most intense represented
   string UIWidget="Spinner";
   float UIMin=0.0;
   float UIMax=1.0;
   float UIStep=0.001;
> = {0.5};
float hueRange <
   string UIName="Color Filter: Hue Range";
   //Set the range to which the Hue should extend in either direction
   string UIWidget="Spinner";
   float UIMin=0.0;
   float UIMax=1.0;
   float UIStep=0.001;
> = {0.2};
float satLimit <
   string UIName="Color Filter: Saturation Limit";
   //Limit the resulting color saturation
   string UIWidget="Spinner";
   float UIMin=0.0;
   float UIMax=1.0;
   float UIStep=0.001;
> = {1.0};
float fxcolorMix <
   string UIName="Color Filter: Effect Strenght";
   //Interpolation between the original and the effect
   string UIWidget="Spinner";
   float UIMin=0.0;
   float UIMax=1.0;
   float UIStep=0.001;
> = {1.0};

//------------------------------------
//prod80 color filter parameters end
//------------------------------------

bool LetterboxEnable <
	string UIName = "Letterbox Enable (set resolution in enbeffect.fx)";
> = {false};

float	fLetterboxOffset
<
	string UIName="Letterbox Size";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=100.0;
> = {8.0};

// Interior controls

float	AdaptationMinInterior
<
	string UIName="A: Adaptation Min Interior";
	string UIWidget="Spinner";
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.003};

float	AdaptationMaxInterior
<
	string UIName="A: Adaptation Max Interior";
	string UIWidget="Spinner";
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.004};

float	GammaInterior
<
	string UIName="CC: Gamma Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {1.1};

float	RedFilterInterior
<
	string UIName="CC: Red Filter Interior";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	GreenFilterInterior
<
	string UIName="CC: Green Filter Interior";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	BlueFilterInterior
<
	string UIName="CC: Blue Filter Interior";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatRInterior
<
	string UIName="CC: Desat Red Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatGInterior
<
	string UIName="CC: Desat Green Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.2};

float	DesatBInterior
<
	string UIName="CC: Desat Blue Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.6};

float	IntensityContrastInterior
<
	string UIName="TM: Intensity Contrast Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	SaturationInterior
<
	string UIName="TM: Saturation Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	ToneMappingCurveInterior
<
	string UIName="TM: ToneMapping Curve Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.8};

float	ToneMappingOversaturationInterior
<
	string UIName="TM: ToneMapping Oversaturation Interior";
	string UIWidget="Spinner";
	float UIMin=0.1;
	float UIMax=999.0;
> = {20.0};

float	BrightnessInterior
<
	string UIName="B: Brightness Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {0.15};

//--------------------------------------------------
// Exterior controls
// Day

float	AdaptationMinDay
<
	string UIName="A: Adaptation Min Day";
	string UIWidget="Spinner";
	float UIMin=0.000;
	float UIMax=1.0;
	float UIStep=0.00001;
> = {0.00038};

float	AdaptationMaxDay
<
	string UIName="A: Adaptation Max Day";
	string UIWidget="Spinner";
	float UIStep=0.0001;
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.042};

float	GammaDay
<
	string UIName="CC: Gamma Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {1.38};

float	RedFilterDay
<
	string UIName="CC: Red Filter Day";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	GreenFilterDay
<
	string UIName="CC: Green Filter Day";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	BlueFilterDay
<
	string UIName="CC: Blue Filter Day";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatRDay
<
	string UIName="CC: Desat Red Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatGDay
<
	string UIName="CC: Desat Green Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.1};

float	DesatBDay
<
	string UIName="CC: Desat Blue Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.6};

float	IntensityContrastDay
<
	string UIName="TM: Intensity Contrast Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	SaturationDay
<
	string UIName="TM: Saturation Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.7};

float	ToneMappingCurveDay
<
	string UIName="TM: ToneMapping Curve Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {2.0};

float	ToneMappingOversaturationDay
<
	string UIName="TM: ToneMapping Oversaturation Day";
	string UIWidget="Spinner";
	float UIMin=0.1;
	float UIMax=999.0;
> = {120.0};

float	BrightnessDay
<
	string UIName="B: Brightness Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {0.15};

//--------------------------------------------------
// Night

float	AdaptationMinNight
<
	string UIName="A: Adaptation Min Night";
	string UIWidget="Spinner";
	float UIStep=0.0001;
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.0016};

float	AdaptationMaxNight
<
	string UIName="A: Adaptation Max Night";
	string UIWidget="Spinner";
	float UIStep=0.0001;
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.0026};

float	GammaNight
<
	string UIName="CC: Gamma Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {1.25};

float	RedFilterNight
<
	string UIName="CC: Red Filter Night";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	GreenFilterNight
<
	string UIName="CC: Green Filter Night";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	BlueFilterNight
<
	string UIName="CC: Blue Filter Night";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatRNight
<
	string UIName="CC: Desat Red Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatGNight
<
	string UIName="CC: Desat Green Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.2};

float	DesatBNight
<
	string UIName="CC: Desat Blue Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.8};

float	IntensityContrastNight
<
	string UIName="TM: Intensity Contrast Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	SaturationNight
<
	string UIName="TM: Saturation Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	ToneMappingCurveNight
<
	string UIName="TM: ToneMapping Curve Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {2.0};

float	ToneMappingOversaturationNight
<
	string UIName="TM: ToneMapping Oversaturation Night";
	string UIWidget="Spinner";
	float UIMin=0.1;
	float UIMax=999.0;
> = {12.0};

float	BrightnessNight
<
	string UIName="B: Brightness Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {0.15};

// ##########################
// BEGIN NIGHTEYE  PARAMETERS
// ##########################
	// #### GENERAL PARAMETERS ####
		bool nightEyeEnable <
		    string UIName = "Night Eye Enable";
		> = {true};

	// #### CALIBRATION PARAMETERS ####
		// #### Calibrate PARAMETERS ####
		bool nightEyeCalibrate <
		    string UIName = "Night Eye Calibrate";
		> = {false};

		float	nightEyeDayMult
		<
		    string UIName="Night Eye Day";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		    float UIStep=0.01;
		> = {0.25};

		float	nightEyeDayOffset
		<
		    string UIName="Night Eye Day Offset";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		    float UIStep=0.01;
		> = {-1.0};

		float	nightEyeNightMult
		<
		    string UIName="Night Eye Night";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		    float UIStep=0.01;
		> = {1.34};

		float	nightEyeNightOffset
		<
		    string UIName="Night Eye Night Offset";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		    float UIStep=0.01;
		> = {-1.0};

		float	nightEyeInteriorMult
		<
		    string UIName="Night Eye Interior";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		    float UIStep=0.01;
		> = {1.34};

		float	nightEyeInteriorOffset
		<
		    string UIName="Night Eye Interior Offset";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		    float UIStep=0.01;
		> = {-1.0};

	// #### VIGNETTE PARAMETERS ####
		bool nightEyeVignetteEnable <
		    string UIName = "Night Eye Vignette Enable";
		> = {false};

		float	nightEyeVignetteMinDistance
		<
		    string UIName="Night Eye Vignette Min Distance";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {0.5};

		float	nightEyeVignetteMaxDistance
		<
		    string UIName="Night Eye Vignette Max Distance";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {0.9};

		float	nightEyeVignetteDistancePower
		<
		    string UIName="Night Eye Vignette Distance Power";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {1.5};

		float	nightEyeVignetteAspectRatio
		<
		    string UIName="Night Eye Vignette Aspect Ratio Power";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {1.0};

	// #### COLOR CORRECT PARAMETERS ####
		bool nightEyeCCEnable <
		    string UIName = "Night Eye CC Enable";
		> = {true};

		float	nightEyeGamma
		<
		    string UIName="Night Eye Gamma";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {0.5};

		float	nightEyeHueShift
		<
		    string UIName="Night Eye Hue Shift";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		> = {0.25};

		float	nightEyeHueSpeed
		<
		    string UIName="Night Eye Hue Speed";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		> = {0.0};

		float	nightEyeSaturationMult
		<
		    string UIName="Night Eye Saturation";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {0.0};

		float	nightEyeValueMult
		<
		    string UIName="Night Eye Value";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		> = {0.5};

		float3	nightEyeTint <
		    string UIName="Night Eye Tint";
		    string UIWidget="Color";
		> = {1.0, 1.0, 1.0};

		float	nightEyeVignetteValueMult
		<
		    string UIName="Night Eye Vignette Value Mult";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		> = {0.0};

		float	nightEyeVignetteMaskMult
		<
		    string UIName="Night Eye Vignette Mask Mult";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		> = {1.0};

	// #### BLOOM PARAMETERS ####
		bool nightEyeBloomEnable <
		    string UIName = "Night Eye Bloom Enable";
		> = {true};

		float	nightEyeBloomGamma
		<
		    string UIName="Night Eye Bloom Gamma";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {1.0};

		float	nightEyeBloomHueShift
		<
		    string UIName="Night Eye Bloom Hue Shift";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		> = {0.5};

		float	nightEyeBloomHueSpeed
		<
		    string UIName="Night Eye Bloom Hue Speed";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		> = {0.0};

		float	nightEyeBloomSaturationMult
		<
		    string UIName="Night Eye Bloom Saturation";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {1.0};

		float	nightEyeBloomValueMult
		<
		    string UIName="Night Eye Bloom Value";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		> = {20.0};

		float3	nightEyeBloomTint <
		    string UIName="Night Eye Bloom Tint";
		    string UIWidget="Color";
		> = {1.0, 1.0, 1.0};

		float	nightEyeBloomVignetteMult
		<
		    string UIName="Night Eye Bloom Vignette Mult";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		> = {1.0};

		float	nightEyeBloomVignetteMaskMult
		<
		    string UIName="Night Eye Bloom Vignette Mask Mult";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		> = {1.0};


	// #### NOISE PARAMETERS ####
		bool nightEyeNoiseEnable <
		    string UIName = "Night Eye Noise Enable";
		> = {true};

		float	nightEyeNoiseMult
		<
		    string UIName="Night Eye Noise Mult";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		> = {0.15};

		float3	nightEyeNoiseTint <
		    string UIName="Night Eye Noise Tint";
		    string UIWidget="Color";
		> = {1.0, 1.0, 1.0};

		float	nightEyeNoiseVignetteMult
		<
		    string UIName="Night Eye Noise Vignette Mult";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=100.0;
		> = {1.0};

		float	nightEyeNoiseVignetteMaskMult
		<
		    string UIName="Night Eye Noise Vignette Mask Mult";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		> = {1.0};

	// #### WARP PARAMETERS ####
		bool nightEyeWarpEnable <
		    string UIName = "Night Eye Warp Enable";
		> = {false};

		float	nightEyeWarpMult
		<
		    string UIName="Night Eye Warp Mult";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		> = {25.0};

		float	nightEyeWarpShift
		<
		    string UIName="Night Eye Warp Shift";
		    string UIWidget="Spinner";
		    float UIMin=-100.0;
		    float UIMax=100.0;
		> = {-0.05};

		float	nightEyeWarpMinDistance
		<
		    string UIName="Night Eye Warp Min Distance";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {0.4};

		float	nightEyeWarpMaxDistance
		<
		    string UIName="Night Eye Warp Max Distance";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {1.0};

		float	nightEyeWarpDistancePower
		<
		    string UIName="Night Eye Warp Distance Power";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {1.75};

		float	nightEyeWarpAspectRatio
		<
		    string UIName="Night Eye Warp Aspect Ratio Power";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {1.0};
	// #### Eyes PARAMETERS ####
		bool nightEyeEnableEyes <
		    string UIName = "Night Eye Enable Eyes";
		> = {false};

		float	nightEyeEyesSeparation
		<
		    string UIName="Night Eye Eyes Separation";
		    string UIWidget="Spinner";
		    float UIMin=0.0;
		    float UIMax=10.0;
		> = {0.35};

// ##########################
// END NIGHTEYE  PARAMETERS
// ##########################

//--------------------------------------------------

//parameters for ldr color correction, if enabled
float	ECCGamma
<
	string UIName="CC: Gamma";
	string UIWidget="Spinner";
	float UIMin=0.2;//not zero!!!
	float UIMax=5.0;
> = {1.0};

float	ECCInBlack
<
	string UIName="CC: In black";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.0};

float	ECCInWhite
<
	string UIName="CC: In white";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	ECCOutBlack
<
	string UIName="CC: Out black";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.0};

float	ECCOutWhite
<
	string UIName="CC: Out white";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	ECCBrightness
<
	string UIName="CC: Brightness";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.0};

float	ECCContrastGrayLevel
<
	string UIName="CC: Contrast gray level";
	string UIWidget="Spinner";
	float UIMin=0.01;
	float UIMax=0.99;
> = {0.5};

float	ECCContrast
<
	string UIName="CC: Contrast";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.0};

float	ECCSaturation
<
	string UIName="CC: Saturation";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.0};

float	ECCDesaturateShadows
<
	string UIName="CC: Desaturate shadows";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.0};

float3	ECCColorBalanceShadows <
	string UIName="CC: Color balance shadows";
	string UIWidget="Color";
> = {0.5, 0.5, 0.5};

float3	ECCColorBalanceHighlights <
	string UIName="CC: Color balance highlights";
	string UIWidget="Color";
> = {0.5, 0.5, 0.5};

float3	ECCChannelMixerR <
	string UIName="CC: Channel mixer R";
	string UIWidget="Color";
> = {1.0, 0.0, 0.0};

float3	ECCChannelMixerG <
	string UIName="CC: Channel mixer G";
	string UIWidget="Color";
> = {0.0, 1.0, 0.0};

float3	ECCChannelMixerB <
	string UIName="CC: Channel mixer B";
	string UIWidget="Color";
> = {0.0, 0.0, 1.0};



//+++++++++++++++++++++++++++++
//external parameters, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables (in some versions exists in the config file). Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	Timer;
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	ScreenSize;
//changes in range 0..1, 0 means that night time, 1 - day time
float	ENightDayFactor;
//changes 0 or 1. 0 means that exterior, 1 - interior
float	EInteriorFactor;
//changes in range 0..1, 0 means full quality, 1 lowest dynamic quality (0.33, 0.66 are limits for quality levels)
float	EAdaptiveQualityFactor;
//.x - current weather index, .y - outgoing weather index, .z - weather transition, .w - time of the day in 24 standart hours. Weather index is value from _weatherlist.ini, for example WEATHER002 means index==2, but index==0 means that weather not captured.
float4	WeatherAndTime;
//enb version of bloom applied, ignored if original post processing used
float	EBloomAmount;



texture2D texs0;//color
texture2D texs1;//bloom skyrim
texture2D texs2;//adaptation skyrim
texture2D texs3;//bloom enb
texture2D texs4;//adaptation enb
texture2D texs7;//palette enb

sampler2D _s0 = sampler_state
{
	Texture   = <texs0>;
	MinFilter = POINT;//
	MagFilter = POINT;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s1 = sampler_state
{
	Texture   = <texs1>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s2 = sampler_state
{
	Texture   = <texs2>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s3 = sampler_state
{
	Texture   = <texs3>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s4 = sampler_state
{
	Texture   = <texs4>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s7 = sampler_state
{
	Texture   = <texs7>;
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
	float2 txcoord0 : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord0 : TEXCOORD0;
};

/////////////////////
////Begin prod80 code
/////////////////////			
		
	float grayValue(float3 gv)
{
   return dot( gv, float3(0.2125, 0.7154, 0.0721) );
}

float smootherstep(float edge0, float edge1, float x)
{
   x = clamp((x - edge0)/(edge1 - edge0), 0.0, 1.0);
   return x*x*x*(x*(x*6 - 15) + 10);
}

float Hue(float3 color)
{
   float hue = 0.0f;
   float fmin = min(min(color.r, color.g), color.b);
   float fmax = max(max(color.r, color.g), color.b);
   float delta = fmax - fmin;
   
   if (delta == 0.0)
      hue = 0.0;
   else
   {         
      float deltaR = (((fmax - color.r) / 6.0) + (delta / 2.0)) / delta;
      float deltaG = (((fmax - color.g) / 6.0) + (delta / 2.0)) / delta;
      float deltaB = (((fmax - color.b) / 6.0) + (delta / 2.0)) / delta;

      if (color.r == fmax )
         hue = deltaB - deltaG;
      else if (color.g == fmax)
         hue = (1.0 / 3.0) + deltaR - deltaB;
      else if (color.b == fmax)
         hue = (2.0 / 3.0) + deltaG - deltaR;
   }
      
   if (hue < 0.0)
      hue += 1.0f;
   else if (hue > 1.0)
      hue -= 1.0f;
   return hue;
}
///////////////////
////End prod80 code
///////////////////


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Quad(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	OUT.vpos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.txcoord0.xy=IN.txcoord0.xy;

	return OUT;
}


//skyrim shader specific externals, do not modify
float4	_c1 : register(c1);
float4	_c2 : register(c2);
float4	_c3 : register(c3);
float4	_c4 : register(c4);
float4	_c5 : register(c5);

float4 PS_D6EC7DD1(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 _oC0=0.0; //output

	float4 _c6=float4(0, 0, 0, 0);
	float4 _c7=float4(0.212500006, 0.715399981, 0.0720999986, 1.0);

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float4 r10;
	float4 r11;


	float4 _v0=0.0;

	_v0.xy=IN.txcoord0.xy;

	
	
	// ################################## //
		// BEGIN NIGHT EYE SETUP AND WARPING     //
		// ################################## //
		float2 unwarpedTxCoord = _v0.xy;

		// The _c3.w value is from the game needs to be manipulated as
		// below to get a value from 0 (night eye off) to 1 (night eye on).
		// The Day, Night, and Interior GUI controls can be used to tune this.
		float3 nightEyeDayFactor = clamp(_c3.w + nightEyeDayOffset, 0.0, 1.0) * nightEyeDayMult;
		float3 nightEyeNightFactor = clamp(_c3.w + nightEyeNightOffset, 0.0, 1.0) * nightEyeNightMult;
		float3 nightEyeInteriorFactor = clamp(_c3.w + nightEyeInteriorOffset, 0.0, 1.0) * nightEyeInteriorMult;

		// Interpolate night/day/interior
		float nightEyeT;;
		nightEyeT = nightEyeDayFactor * ENightDayFactor + 
			nightEyeNightFactor * (1.0 - ENightDayFactor);
		nightEyeT = nightEyeInteriorFactor * EInteriorFactor + 
			nightEyeT * (1.0 - EInteriorFactor);
		float aspectRatio = ScreenSize.z;

		float2 warpVector;
		[branch] if(nightEyeEnable && nightEyeWarpEnable) // Warp
		{
			float2 warpedTxCoord = IN.txcoord0.xy;
			float2 center = float2(0.5, 0.5);
			float2 txCorrected = float2((warpedTxCoord.x - center.x) * 
				aspectRatio / nightEyeWarpAspectRatio + center.x, warpedTxCoord.y);
			float dist;
			[branch]if(nightEyeEnableEyes) // Eyes (2 centers)
			{
				float2 leftEyeCenter = float2(center.x - nightEyeEyesSeparation / 2.0, center.y);
				float2 rightEyeCenter = float2(center.x + nightEyeEyesSeparation / 2.0, center.y);
				float leftEyeDist = distance(txCorrected, leftEyeCenter);
				float rightEyeDist = distance(txCorrected, rightEyeCenter);
				float leftEyeDistT = linStep(nightEyeWarpMinDistance, nightEyeWarpMaxDistance, leftEyeDist);
				float rightEyeDistT = linStep(nightEyeWarpMinDistance, nightEyeWarpMaxDistance, rightEyeDist);
				if(leftEyeDist < rightEyeDist){
					dist = leftEyeDist;
					warpVector = (txCorrected - leftEyeCenter) / leftEyeDist;
				}
				else
				{
					dist = rightEyeDist;
					warpVector = (txCorrected - rightEyeCenter) / rightEyeDist;
				}
			}
			else
			{ 
				dist = distance(txCorrected, center);
				warpVector = (txCorrected - center) / dist;
			}

			float distT = linStep(nightEyeWarpMinDistance, nightEyeWarpMaxDistance, dist);
			distT = pow(distT, nightEyeWarpDistancePower);
			warpedTxCoord += nightEyeT * nightEyeWarpMult * -0.05 * 
				(distT + nightEyeWarpShift * 0.1) * warpVector;

			// Mirror and wrap if warped beyond screen border
			warpedTxCoord = fmod(abs(warpedTxCoord), 2.0);
			if(warpedTxCoord.x > 1.0) warpedTxCoord.x = warpedTxCoord.x - 2.0 * (warpedTxCoord.x - 1.0);
			if(warpedTxCoord.y > 1.0) warpedTxCoord.y = warpedTxCoord.y - 2.0 * (warpedTxCoord.y - 1.0);

			_v0.xy = warpedTxCoord.xy;
		}
		// ################################ //
		// END NIGHT EYE SETUP AND WARPING  //
		// ################################ //
		
	


	r1=tex2D(_s0, _v0.xy); //color

	//apply bloom
	float4	xcolorbloom=tex2D(_s3, _v0.xy);

	xcolorbloom.xyz=xcolorbloom-r1;
	xcolorbloom.xyz=max(xcolorbloom, 0.0);
	r1.xyz+=xcolorbloom*EBloomAmount;

	r11=r1; //my bypass
	_oC0.xyz=r1.xyz; //for future use without game color corrections

#ifdef APPLYGAMECOLORCORRECTION
	//apply original
    r0.x=1.0/_c2.y;
    r1=tex2D(_s2, _v0);
    r0.yz=r1.xy * _c1.y;
    r0.w=1.0/r0.y;
    r0.z=r0.w * r0.z;
    r1=tex2D(_s0, _v0);
    r1.xyz=r1 * _c1.y;
    r0.w=dot(_c7.xyz, r1.xyz);
    r1.w=r0.w * r0.z;
    r0.z=r0.z * r0.w + _c7.w;
    r0.z=1.0/r0.z;
    r0.x=r1.w * r0.x + _c7.w;
    r0.x=r0.x * r1.w;
    r0.x=r0.z * r0.x;
    if (r0.w<0) r0.x=_c6.x;
    r0.z=1.0/r0.w;
    r0.z=r0.z * r0.x;
    r0.x=saturate(-r0.x + _c2.x);
//    r2=tex2D(_s3, _v0);//enb bloom
    r2=tex2D(_s1, _v0);//skyrim bloom
    r2.xyz=r2 * _c1.y;
    r2.xyz=r0.x * r2;
    r1.xyz=r1 * r0.z + r2;
    r0.x=dot(r1.xyz, _c7.xyz);
    r1.w=_c7.w;
    r2=lerp(r0.x, r1, _c3.x);
    r1=r0.x * _c4 - r2;
    r1=_c4.w * r1 + r2;
    r1=_c3.w * r1 - r0.y; //khajiit night vision _c3.w
    r0=_c3.z * r1 + r0.y;
    r1=-r0 + _c5;
    _oC0=_c5.w * r1 + r0;

#endif //APPLYGAMECOLORCORRECTION

/*
#ifndef APPLYGAMECOLORCORRECTION
//temporary fix for khajiit night vision, but it also degrade colors.
//	r1=tex2D(_s2, _v0);
//	r0.y=r1.xy * _c1.y;
	r1=_oC0;
	r1.xyz=r1 * _c1.y;
	r0.x=dot(r1.xyz, _c7.xyz);
	r2=lerp(r0.x, r1, _c3.x);
	r1=r0.x * _c4 - r2;
	r1=_c4.w * r1 + r2;
	r1=_c3.w * r1;// - r0.y;
	r0=_c3.z * r1;// + r0.y;
	r1=-r0 + _c5;
	_oC0=_c5.w * r1 + r0;
#endif //!APPLYGAMECOLORCORRECTION
*/

	

	float4 color=_oC0;	

    //adaptation in time
	float4	Adaptation=tex2D(_s4, 0.5);
	float	grayadaptation=max(max(Adaptation.x, Adaptation.y), Adaptation.z);

    float Gamma=lerp(lerp(GammaNight, GammaDay, ENightDayFactor), GammaInterior, EInteriorFactor);
    float RedFilter=lerp(lerp(RedFilterNight, RedFilterDay, ENightDayFactor), RedFilterInterior, EInteriorFactor);
    float GreenFilter=lerp(lerp(GreenFilterNight, GreenFilterDay, ENightDayFactor), GreenFilterInterior, EInteriorFactor);
    float BlueFilter=lerp(lerp(BlueFilterNight, BlueFilterDay, ENightDayFactor), BlueFilterInterior, EInteriorFactor);
	
	float DesatR=lerp(lerp(DesatRNight, DesatRDay, ENightDayFactor), DesatRInterior, EInteriorFactor);
	float DesatG=lerp(lerp(DesatGNight, DesatGDay, ENightDayFactor), DesatGInterior, EInteriorFactor);
	float DesatB=lerp(lerp(DesatBNight, DesatBDay, ENightDayFactor), DesatBInterior, EInteriorFactor);
	
	float AdaptationMin=lerp(lerp(AdaptationMinNight, AdaptationMinDay, ENightDayFactor), AdaptationMinInterior, EInteriorFactor);
	float AdaptationMax=lerp(lerp(AdaptationMaxNight, AdaptationMaxDay, ENightDayFactor), AdaptationMaxInterior, EInteriorFactor);
	
    float Saturation=lerp(lerp(SaturationNight, SaturationDay, ENightDayFactor), SaturationInterior, EInteriorFactor);
	float ToneMappingCurve=lerp(lerp(ToneMappingCurveNight, ToneMappingCurveDay, ENightDayFactor), ToneMappingCurveInterior, EInteriorFactor);
	float ToneMappingOversaturation=lerp(lerp(ToneMappingOversaturationNight, ToneMappingOversaturationDay, ENightDayFactor), ToneMappingOversaturationInterior, EInteriorFactor);
	float IntensityContrast=lerp(lerp(IntensityContrastNight, IntensityContrastDay, ENightDayFactor), IntensityContrastInterior, EInteriorFactor);
	float Brightness=lerp(lerp(BrightnessNight, BrightnessDay, ENightDayFactor), BrightnessInterior, EInteriorFactor);
	
	
	float greyscale = dot(color.xyz, float3(0.3, 0.59, 0.11));
    color.r = lerp(greyscale, color.r, DesatR);
    color.g = lerp(greyscale, color.g, DesatG);
    color.b = lerp(greyscale, color.b, DesatB);	
    	
	color = pow(color, Gamma);
	
	color.r = pow(color.r, RedFilter);
	color.g = pow(color.g, GreenFilter);
	color.b = pow(color.b, BlueFilter);
   
	grayadaptation=max(grayadaptation, 0.0); //0.0
	grayadaptation=min(grayadaptation, 50.0); //50.0
	color.xyz=color.xyz/(grayadaptation*AdaptationMax+AdaptationMin);//*tempF1.x

	color.xyz*=Brightness;
	color.xyz+=0.000001;
	float3 xncol=normalize(color.xyz);
	float3 scl=color.xyz/xncol.xyz;
	scl=pow(scl, IntensityContrast);
	xncol.xyz=pow(xncol.xyz, Saturation);
	color.xyz=scl*xncol.xyz;

	float	lumamax=ToneMappingOversaturation;
	color.xyz=(color.xyz * (1.0 + color.xyz/lumamax))/(color.xyz + ToneMappingCurve);
	
    float Y = dot(color.xyz, float3(0.299, 0.587, 0.114)); //0.299 * R + 0.587 * G + 0.114 * B;
	float U = dot(color.xyz, float3(-0.14713, -0.28886, 0.436)); //-0.14713 * R - 0.28886 * G + 0.436 * B;
	float V = dot(color.xyz, float3(0.615, -0.51499, -0.10001)); //0.615 * R - 0.51499 * G - 0.10001 * B;	
	
	//Y=pow(Y, BrightnessCurve);
	//Y=Y*BrightnessMultiplier;
	//Y=Y/(Y+BrightnessToneMappingCurve);
	//float	desaturatefact=saturate(Y*Y*Y*1.7);
	//U=lerp(U, 0.0, desaturatefact);
	//V=lerp(V, 0.0, desaturatefact);
	//color.xyz=V * float3(1.13983, -0.58060, 0.0) + U * float3(0.0, -0.39465, 2.03211) + Y;
	
	// ADVANCED COLOR FILTER (prod80)

if ( use_colorhuefx == true )
{
   float3 fxcolor = saturate( color.xyz );
   float greyVal = grayValue( fxcolor.xyz );
   float colorHue = Hue( fxcolor.xyz );
   
   float colorSat = 0.0f;
   float minColor = min( min ( fxcolor.x, fxcolor.y ), fxcolor.z );
   float maxColor = max( max ( fxcolor.x, fxcolor.y ), fxcolor.z );
   float colorDelta = maxColor - minColor;
   float colorInt = ( maxColor + minColor ) * 0.5f;
   
   if ( colorDelta != 0.0f )
   {
      if ( colorInt < 0.5f )
         colorSat = colorDelta / ( maxColor + minColor );
      else
         colorSat = colorDelta / ( 2.0f - maxColor - minColor );
   }
   
   //When color intensity not based on original saturation level
   if ( use_colorsaturation == false )
      colorSat = 1.0f;
   
   float hueMin_1 = 0.0f;
   float hueMin_2 = 0.0f;
   float hueMax_1 = 0.0f;
   float hueMax_2 = 0.0f;
   
   if ( hueRange > hueMid )
   {
      hueMin_1 = hueMid - hueRange;
      hueMin_2 = 1.0f + hueMid - hueRange;
      hueMax_1 = hueMid + hueRange;
      hueMax_2 = 1.0f + hueMid;
   
      if ( colorHue >= hueMin_1 && colorHue <= hueMid )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
      else if ( colorHue > hueMid && colorHue <= hueMax_1 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
      else if ( colorHue >= hueMin_2 && colorHue <= hueMax_2 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_2, hueMax_2, colorHue ) * ( colorSat * satLimit ));
      else
         fxcolor.xyz = greyVal.xxx;
   
   }
   else if ( hueMid + hueRange > 1.0f )
   {
      hueMin_1 = hueMid - hueRange;
      hueMin_2 = 0.0f - ( 1.0f - hueMid );
      hueMax_1 = hueMid + hueRange;
      hueMax_2 = hueMid + hueRange - 1.0f;
   
      if ( colorHue >= hueMin_1 && colorHue <= hueMid )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
      else if ( colorHue > hueMid && colorHue <= hueMax_1 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
      else if ( colorHue >= hueMin_2 && colorHue <= hueMax_2 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_2, hueMax_2, colorHue) * ( colorSat * satLimit ));
      else
         fxcolor.xyz = greyVal.xxx;
      
   }
   else
   {
      hueMin_1 = hueMid - hueRange;
      hueMax_1 = hueMid + hueRange;
      
      if ( colorHue >= hueMin_1 && colorHue <= hueMid )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
      else if ( colorHue > hueMid && colorHue <= hueMax_1 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
      else
         fxcolor.xyz = greyVal.xxx;
   
   }
   color.xyz = lerp( color.xyz, fxcolor.xyz, fxcolorMix );
}
		

	//color.xyz=max(color.xyz, 0.0);
	//color.xyz=color.xyz/(color.xyz+newEBrightnessToneMappingCurveV2);


//color.xyz=tex2D(_s0, _v0.xy) + xcolorbloom.xyz*float3(0.7, 0.6, 1.0)*0.5;
//color.xyz=tex2D(_s0, _v0.xy) + xcolorbloom.xyz*float3(0.7, 0.6, 1.0)*0.5;
//color.xyz*=0.7;


	//pallete texture (0.082+ version feature)
#ifdef E_CC_PALETTE   
	color.rgb=saturate(color.rgb);
	float3	brightness=Adaptation.xyz;//tex2D(_s4, 0.5);//adaptation luminance
//	brightness=saturate(brightness);//old version from ldr games
	brightness=(brightness/(brightness+1.0));//new version
	brightness=max(brightness.x, max(brightness.y, brightness.z));//new version
	float3	palette;
	float4	uvsrc=0.0;
	uvsrc.y=brightness.r;
	uvsrc.x=color.r;
	palette.r=tex2Dlod(_s7, uvsrc).r;
	uvsrc.x=color.g;
	uvsrc.y=brightness.g;
	palette.g=tex2Dlod(_s7, uvsrc).g;
	uvsrc.x=color.b;
	uvsrc.y=brightness.b;
	palette.b=tex2Dlod(_s7, uvsrc).b;
	color.rgb=palette.rgb;
#endif //E_CC_PALETTE



#ifdef E_CC_PROCEDURAL
	float	tempgray;
	float4	tempvar;
	float3	tempcolor;
/*
	//these replaced by "levels"
	//+++ gamma
	if (ECCGamma!=1.0)
	color=pow(color, 1.0/ECCGamma);

	//+++ brightness like in photoshop
	color=color+ECCAditiveBrightness;

	//+++ lightness
	tempvar.x=saturate(ELightness);
	tempvar.y=saturate(1.0+ECCLightness);
	color=tempvar.x*(1.0-color) + (tempvar.y*color);
*/
	//+++ levels like in photoshop, including gamma, lightness, additive brightness
	color=max(color-ECCInBlack, 0.0) / max(ECCInWhite-ECCInBlack, 0.0001);
	if (ECCGamma!=1.0) color=pow(color, ECCGamma);
	color=color*(ECCOutWhite-ECCOutBlack) + ECCOutBlack;

	//+++ brightness
	color=color*ECCBrightness;

	//+++ contrast
	color=(color-ECCContrastGrayLevel) * ECCContrast + ECCContrastGrayLevel;

	//+++ saturation
	tempgray=dot(color, 0.3333);
	color=lerp(tempgray, color, ECCSaturation);

	//+++ desaturate shadows
	tempgray=dot(color, 0.3333);
	tempvar.x=saturate(1.0-tempgray);
	tempvar.x*=tempvar.x;
	tempvar.x*=tempvar.x;
	color=lerp(color, tempgray, ECCDesaturateShadows*tempvar.x);

	//+++ color balance
	color=saturate(color);
	tempgray=dot(color, 0.3333);
	float2	shadow_highlight=float2(1.0-tempgray, tempgray);
	shadow_highlight*=shadow_highlight;
	color.rgb+=(ECCColorBalanceHighlights*2.0-1.0)*color * shadow_highlight.x;
	color.rgb+=(ECCColorBalanceShadows*2.0-1.0)*(1.0-color) * shadow_highlight.y;

	//+++ channel mixer
	tempcolor=color;
	color.r=dot(tempcolor, ECCChannelMixerR);
	color.g=dot(tempcolor, ECCChannelMixerG);
	color.b=dot(tempcolor, ECCChannelMixerB);
#endif //E_CC_PROCEDURAL

		// ##############################
	// BEGIN NIGHTEYE  IMPLEMENTATION
	// ##############################
	if(nightEyeEnable)
	{
		float vignette = 0.0;
		if(nightEyeVignetteEnable) //  Add Vignette
		{
			float2 vignetteTxCoord = IN.txcoord0.xy;
			float2 center = float2(0.5, 0.5);
			float2 txCorrected = float2((vignetteTxCoord.x - center.x) * 
				aspectRatio / nightEyeVignetteAspectRatio + center.x, vignetteTxCoord.y);
			float dist;
			[branch]if(nightEyeEnableEyes) // Eyes (2 centers)
			{
				float2 leftEyeCenter = float2(center.x - nightEyeEyesSeparation / 2.0, center.y);
				float2 rightEyeCenter = float2(center.x + nightEyeEyesSeparation / 2.0, center.y);
				float leftEyeDist = distance(txCorrected, leftEyeCenter);
				float rightEyeDist = distance(txCorrected, rightEyeCenter);
				dist = min(leftEyeDist, rightEyeDist);
			}
			else
			{ 
				dist = distance(txCorrected, center);
			}
			float distT = linStep(nightEyeVignetteMinDistance, nightEyeVignetteMaxDistance, dist);
			vignette = pow(distT, nightEyeVignetteDistancePower);
		}

		if(nightEyeCCEnable) // Color Correct
		{
			float3 nightEye = color.xyz;
			nightEye = pow(nightEye, nightEyeGamma);
			nightEye = RGBtoHSV(nightEye);
			nightEye.x += nightEyeHueShift + nightEyeHueSpeed * Timer.x * 1000.0;
			nightEye.y *= nightEyeSaturationMult;
			nightEye.z *= nightEyeValueMult;
			nightEye = HSVtoRGB(nightEye);
			nightEye *= nightEyeTint;
			float mask = vignette;
			if(nightEyeVignetteMaskMult < 0) mask = -1.0 * (1.0 - vignette);
			mask *= nightEyeVignetteMaskMult;
			nightEye *= (1.0 - mask) + (mask * nightEyeVignetteValueMult);
			color.xyz = saturate((nightEye.xyz * nightEyeT) + (color.xyz * (1.0 - nightEyeT)));
			//color.xyz = lerp(color.xyz, nightEye.xyz, t);
		}
		
		if(nightEyeBloomEnable) // Add Bloom
		{
			float3 nightEyeBloom = tex2D(_s3, _v0);
			nightEyeBloom = pow(nightEyeBloom, nightEyeBloomGamma);
			nightEyeBloom = RGBtoHSV(nightEyeBloom);
			nightEyeBloom.x += nightEyeBloomHueShift + nightEyeBloomHueSpeed * Timer.x * 1000.0;
			nightEyeBloom.y *= nightEyeBloomSaturationMult;
			nightEyeBloom.z *= nightEyeBloomValueMult;
			nightEyeBloom = HSVtoRGB(nightEyeBloom);
			nightEyeBloom *= nightEyeBloomTint;
			float mask = vignette;
			if(nightEyeBloomVignetteMaskMult < 0) mask = -1.0 * (1.0 - vignette);
			mask *= nightEyeBloomVignetteMaskMult;
			nightEyeBloom *= (1.0 - mask) + (mask * nightEyeBloomVignetteMult);
			nightEyeBloom *= nightEyeT;
			color.xyz= saturate(color.xyz + nightEyeBloom.xyz);
		}
		
		if(nightEyeNoiseEnable) //  Add Noise
		{
			float3 noiseCoord = float3(_v0.x, _v0.y, Timer.x);
			float3 nightEyeNoise = randomNoise(noiseCoord);
			nightEyeNoise *= nightEyeNoiseMult;
			nightEyeNoise *= nightEyeNoiseTint;
			float mask = vignette;
			if(nightEyeNoiseVignetteMaskMult < 0) mask = -1.0 * (1.0 - vignette);
			mask *= nightEyeNoiseVignetteMaskMult;
			nightEyeNoise *= mask + ((1.0 - mask) * nightEyeNoiseVignetteMult);
			nightEyeNoise *= nightEyeT;
			color.xyz = saturate(color.xyz + nightEyeNoise.xyz);
		}
		if(nightEyeCalibrate) //  Calibrate
		{

			float2 calibrateCoords = IN.txcoord0;
			float4 calibrateText = 0;
			calibrateText += float4(1.0, 1.0, 0.0, 1.0) *
				EED_drawFloatText(
				//ASCII N   i    g    h
				float4(78, 105, 103, 104),  	
				// ACII t    E   y    e
				float4(116, 69, 121, 101),  	
				nightEyeT,
				calibrateCoords,
				float2(0.85, 0),
				1.2,
				6 // precision
			);

			calibrateText += EED_drawFloatText(
				//ASCII N   i    g    h
				float4(78, 105, 103, 104),  	
				// ACII t    D   a    y
				float4(116, 68, 97, 121),  	
				ENightDayFactor,
				calibrateCoords,
				float2(0.85, 0.05),
				1.0,
				6 // precision
			);

			calibrateText += EED_drawFloatText(
				//ASCII I   n    t    e
				float4(73, 110, 116, 101),  	
				// ACII r    i   o    r
				float4(114, 105, 111, 114),  	
				EInteriorFactor,
				calibrateCoords,
				float2(0.85, 0.075),
				1.0,
				6 // precision
			);

			calibrateText += EED_drawCRegistersText(_c1, _c2, _c3, _c4, _c5, 
				calibrateCoords, float2(0.85, 0.125), 1.0, 6);

			color.xyz += calibrateText.xyz;
		}
		
	}
	// ##############################
	// END NIGHTEYE  IMPLEMENTATION
	// ##############################


	_oC0.w=1.0;
	_oC0.xyz=color.xyz;
	
if (LetterboxEnable)
 {
   float offset = fLetterboxOffset * 0.01;
   float2 sspos = fvTexelSize * vPos;
   if (sspos.y <= offset || sspos.y >= (1.0 - offset)) _oC0.rgb = 0.0;
 }

	return _oC0;	
}



//switch between vanilla and mine post processing
technique Shader_D6EC7DD1 <string UIName="ENBSeries";>
{
	pass p0
	{
		VertexShader  = compile vs_3_0 VS_Quad();
		PixelShader  = compile ps_3_0 PS_D6EC7DD1();

		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		ZEnable=FALSE;
		ZWriteEnable=FALSE;
		CullMode=NONE;
		AlphaTestEnable=FALSE;
		AlphaBlendEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}



//original shader of post processing
technique Shader_ORIGINALPOSTPROCESS <string UIName="Vanilla";>
{
	pass p0
	{
		VertexShader  = compile vs_3_0 VS_Quad();
		PixelShader=
	asm
	{
// Parameters:
//   sampler2D Avg;
//   sampler2D Blend;
//   float4 Cinematic;
//   float4 ColorRange;
//   float4 Fade;
//   sampler2D Image;
//   float4 Param;
//   float4 Tint;
// Registers:
//   Name         Reg   Size
//   ------------ ----- ----
//   ColorRange   c1       1
//   Param        c2       1
//   Cinematic    c3       1
//   Tint         c4       1
//   Fade         c5       1
//   Image        s0       1
//   Blend        s1       1
//   Avg          s2       1
//s0 bloom result
//s1 color
//s2 is average color

    ps_3_0
    def c6, 0, 0, 0, 0
    //was c0 originally
    def c7, 0.212500006, 0.715399981, 0.0720999986, 1
    dcl_texcoord v0.xy
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    rcp r0.x, c2.y
    texld r1, v0, s2
    mul r0.yz, r1.xxyw, c1.y
    rcp r0.w, r0.y
    mul r0.z, r0.w, r0.z
    texld r1, v0, s1
    mul r1.xyz, r1, c1.y
    dp3 r0.w, c7, r1
    mul r1.w, r0.w, r0.z
    mad r0.z, r0.z, r0.w, c7.w
    rcp r0.z, r0.z
    mad r0.x, r1.w, r0.x, c7.w
    mul r0.x, r0.x, r1.w
    mul r0.x, r0.z, r0.x
    cmp r0.x, -r0.w, c6.x, r0.x
    rcp r0.z, r0.w
    mul r0.z, r0.z, r0.x
    add_sat r0.x, -r0.x, c2.x
    texld r2, v0, s0
    mul r2.xyz, r2, c1.y
    mul r2.xyz, r0.x, r2
    mad r1.xyz, r1, r0.z, r2
    dp3 r0.x, r1, c7
    mov r1.w, c7.w
    lrp r2, c3.x, r1, r0.x
    mad r1, r0.x, c4, -r2
    mad r1, c4.w, r1, r2
    mad r1, c3.w, r1, -r0.y
    mad r0, c3.z, r1, r0.y
    add r1, -r0, c5
    mad oC0, c5.w, r1, r0
	};
		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		ZEnable=FALSE;
		ZWriteEnable=FALSE;
		CullMode=NONE;
		AlphaTestEnable=FALSE;
		AlphaBlendEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
    }
}

