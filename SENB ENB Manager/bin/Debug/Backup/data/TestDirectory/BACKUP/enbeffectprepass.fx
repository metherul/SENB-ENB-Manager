//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// visit http://enbdev.com for updates
// Copyright (c) 2007-2013 Boris Vorontsov
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#ifndef E_DOF_EQ
 #ifndef E_DOF_HQ
  #ifndef E_DOF_MQ
   #ifndef E_DOF_LQ
#define E_DOF_MQ
   #endif
  #endif
 #endif
#endif


//+++++++++++++++++++++++++++++
//internal parameters, can be modified
//+++++++++++++++++++++++++++++
float	EBlurSamplingRange=4.0;
float	EApertureScale=4.0;



//+++++++++++++++++++++++++++++
//external parameters, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables (in some versions exists in the config file). Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	ScreenSize;
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	Timer;
//changes in range 0..1, 0 means that night time, 1 - day time
float	ENightDayFactor;
//changes 0 or 1. 0 means that exterior, 1 - interior
float	EInteriorFactor;
//adaptation delta time for focusing
float	FadeFactor;
//fov in degrees
float	FieldOfView;



//textures
texture2D texOriginal;
texture2D texColor;
texture2D texDepth;
texture2D texNoise;
texture2D texPalette;
texture2D texFocus; //computed focusing depth
texture2D texCurr; //4*4 texture for focusing
texture2D texPrev; //4*4 texture for focusing

sampler2D SamplerOriginal = sampler_state
{
	Texture   = <texOriginal>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerColor = sampler_state
{
	Texture   = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerDepth = sampler_state
{
	Texture   = <texDepth>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerNoise = sampler_state
{
	Texture   = <texNoise>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;//NONE;
	AddressU  = Wrap;
	AddressV  = Wrap;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerPalette = sampler_state
{
	Texture   = <texPalette>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

//for focus computation
sampler2D SamplerCurr = sampler_state
{
	Texture   = <texCurr>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

//for focus computation
sampler2D SamplerPrev = sampler_state
{
	Texture   = <texPrev>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};
//for dof only in PostProcess techniques
sampler2D SamplerFocus = sampler_state
{
	Texture   = <texFocus>;
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



////////////////////////////////////////////////////////////////////
//begin focusing code
////////////////////////////////////////////////////////////////////
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Focus(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}



//SRCpass1X=ScreenWidth;
//SRCpass1Y=ScreenHeight;
//DESTpass2X=4;
//DESTpass2Y=4;
float4 PS_ReadFocus(VS_OUTPUT_POST IN) : COLOR
{
	float2 uvsrc=IN.txcoord.xy;

	const float2 offset[4]=
	{
		float2(0.0, 0.3),
		float2(0.0, -0.3),
		float2(0.3, 0.0),
		float2(-0.3, 0.0)
	};

	float res=tex2D(SamplerDepth, uvsrc).x;
	for (int i=0; i<4; i++)
	{
		uvsrc.xy=offset[i];
		uvsrc.xy+=IN.txcoord;
		res+=tex2D(SamplerDepth, uvsrc).x;
	}
	res*=0.2;

	return res;
}



//SRCpass1X=4;
//SRCpass1Y=4;
//DESTpass2X=4;
//DESTpass2Y=4;
float4 PS_WriteFocus(VS_OUTPUT_POST IN) : COLOR
{
	float2 uvsrc=0.0;//IN.txcoord0.xy;

	//const float pixsizex=4.0;
//	uvsrc.xy-=(0.5+0.0625)/4.0;
//	const float step=0.125/4.0;
	float	pos=0.0001;
	float	res=0.0;
	float	curr=0.0;
	float	prev=0.0;
	float	currmax=0.0;
	float	prevmax=0.0;
	for (int ix=0; ix<16; ix++)
	{
		float	tcurr=tex2D(SamplerCurr, (uvsrc.xy*0.25+0.125)).x;//the same for all 4 pixels
		float	tprev=tex2D(SamplerPrev, (uvsrc.xy*0.25+0.125)).x;//the same for all 4 pixels
		currmax=max(currmax, tcurr);
		prevmax=max(prevmax, tprev);
		curr+=tcurr;
		prev+=tprev;
		uvsrc.x+=1.0;
		if (uvsrc.x>4.0)
		{
			uvsrc.x=0.0;
			uvsrc.y+=1.0;
		}
	}
	curr*=0.0625;
	prev*=0.0625;

	res=lerp(prev, curr, saturate(FadeFactor));//time elapsed factor
	res=max(res, 0.0);

	return res;
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
technique ReadFocus
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Focus();
		PixelShader  = compile ps_3_0 PS_ReadFocus();

		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}



technique WriteFocus
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Focus();
		PixelShader  = compile ps_3_0 PS_WriteFocus();

		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
////////////////////////////////////////////////////////////////////
//end focusing code
////////////////////////////////////////////////////////////////////



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_PostProcess(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}



//1 blur
float4 PS_ProcessPass1(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;

	float4 origcolor=tex2D(SamplerColor, coord.xy);

	float2 offset[16]=
	{
	 float2(1.0, 1.0),
	 float2(-1.0, -1.0),
	 float2(-1.0, 1.0),
	 float2(1.0, -1.0),

	 float2(1.0, 0.0),
	 float2(-1.0, 0.0),
	 float2(0.0, 1.0),
	 float2(0.0, -1.0),

	 float2(1.41, 0.0),
	 float2(-1.41, 0.0),
	 float2(0.0, 1.41),
	 float2(0.0, -1.41),

	 float2(1.41, 1.41),
	 float2(-1.41, -1.41),
	 float2(-1.41, 1.41),
	 float2(1.41, -1.41)
	};

	float4 tcol=origcolor;
	float2 invscreensize=ScreenSize.y;
	invscreensize.y*=ScreenSize.w;
	invscreensize*=EBlurSamplingRange;
	for (int i=0; i<16; i++)
	{
		float2 tdir=offset[i].xy;
		coord.xy=IN.txcoord.xy+tdir.xy*invscreensize;
		float4 ct=tex2D(SamplerColor, coord.xy);

		tcol+=ct;
	}
	tcol*=0.05882353;
	res.xyz=tcol.xyz;


	float	scenedepth=tex2D(SamplerDepth, IN.txcoord.xy).x;
//	float	scenefocus=tex2D(SamplerFocus, IN.txcoord.xy+0.125).x;
	float	scenefocus=tex2D(SamplerFocus, 0.6125).x;
	float	position=EApertureScale*abs(scenedepth-scenefocus);
	res.xyz=lerp(origcolor, res.xyz, saturate(position)*pow(tempF2,4));
//res.xyz=origcolor;

/*
	//visualize focusing distance as white
	float	scenedepth=tex2D(SamplerDepth, IN.txcoord.xy).x;
	float	scenefocus=tex2D(SamplerFocus, IN.txcoord.xy+0.125).x;
	res=0.005/abs(scenedepth-scenefocus);
	//if (res>=1.0) res=999999999.0;
	//res=1.0/(1.0-res);
	res=min(res, 32768.0);
	res=max(res, 0.0);
*/

	res.w=1.0;
	return res;
}



float4 PS_ProcessPass2(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;

	float4 origcolor=tex2D(SamplerColor, coord.xy);

	float2 offset[16]=
	{
	 float2(1.0, 1.0),
	 float2(-1.0, -1.0),
	 float2(-1.0, 1.0),
	 float2(1.0, -1.0),

	 float2(1.0, 0.0),
	 float2(-1.0, 0.0),
	 float2(0.0, 1.0),
	 float2(0.0, -1.0),

	 float2(1.41, 0.0),
	 float2(-1.41, 0.0),
	 float2(0.0, 1.41),
	 float2(0.0, -1.41),

	 float2(1.41, 1.41),
	 float2(-1.41, -1.41),
	 float2(-1.41, 1.41),
	 float2(1.41, -1.41)
	};

	float4 tcol=origcolor;
	float2 invscreensize=ScreenSize.y;
	invscreensize.y*=ScreenSize.w;
	invscreensize*=EBlurSamplingRange;
	for (int i=0; i<16; i++)
	{
		float2 tdir=offset[i].xy;
		coord.xy=IN.txcoord.xy+tdir.xy*invscreensize;
		float4 ct=tex2D(SamplerColor, coord.xy);

		tcol+=ct;
	}
	tcol*=0.05882353;
	res.xyz=tcol.xyz;

/*
	//visualize focusing distance as white
	float	scenedepth=tex2D(SamplerDepth, IN.txcoord.xy).x;
	float	scenefocus=tex2D(SamplerFocus, IN.txcoord.xy+0.125).x;
	res=0.005/abs(scenedepth-scenefocus);
	//if (res>=1.0) res=999999999.0;
	//res=1.0/(1.0-res);
	res=min(res, 32768.0);
	res=max(res, 0.0);
*/
	float	scenedepth=tex2D(SamplerDepth, IN.txcoord.xy).x;
//	float	scenefocus=tex2D(SamplerFocus, IN.txcoord.xy+0.125).x;
	float	scenefocus=tex2D(SamplerFocus, 0.6125).x;
	float	position=EApertureScale*abs(scenedepth-scenefocus);
	res.xyz=lerp(origcolor, res.xyz, saturate(position));
//res.xyz=origcolor;

	res.w=1.0;
	return res;
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
technique PostProcess
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass1();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

/*
technique PostProcess2
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass2();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
*/



