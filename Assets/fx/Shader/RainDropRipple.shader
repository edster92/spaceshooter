// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RainDropRipple"
{
	Properties
	{
		_Diffuse("Diffuse", 2D) = "white" {}
		_Tint("Tint", Color) = (1,1,1,0)
		_Diffuseintense("Diffuse intense", Float) = 1
		_MFIntense("MFIntense", Float) = 1
		_Tiling("Tiling", Float) = 1
		_Speed("Speed", Float) = 1
		_Wetness("Wetness", Float) = 0.8
		_RipplesNormal("RipplesNormal", 2D) = "white" {}
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_SpeedRippleMask("SpeedRippleMask", Float) = 1
		_NormalMap("NormalMap", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_MaskStrenght("MaskStrenght", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _RipplesNormal;
		uniform float _MaskStrenght;
		uniform float _SpeedRippleMask;
		uniform float _Tiling;
		uniform float _Speed;
		uniform float _MFIntense;
		uniform float2 _Vector0;
		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform float4 _Tint;
		uniform float _Diffuseintense;
		uniform float _Wetness;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float temp_output_61_0 = ( _Time.y * _SpeedRippleMask );
			float RippleTile14 = _Tiling;
			float2 panner53 = ( temp_output_61_0 * float2( 0.57,0.47 ) + ( i.uv_texcoord * RippleTile14 ));
			float simplePerlin2D48 = snoise( panner53 );
			float2 panner70 = ( temp_output_61_0 * float2( -0.57,-0.47 ) + ( i.uv_texcoord * RippleTile14 ));
			float simplePerlin2D71 = snoise( panner70 );
			float RippleMAsk62 = ( _MaskStrenght * ( simplePerlin2D48 * simplePerlin2D71 ) );
			float2 temp_cast_0 = (RippleTile14).xx;
			float2 uv_TexCoord2 = i.uv_texcoord * temp_cast_0;
			float2 appendResult11 = (float2(frac( uv_TexCoord2.x ) , frac( uv_TexCoord2.y )));
			float temp_output_4_0_g5 = 4.0;
			float temp_output_5_0_g5 = 4.0;
			float2 appendResult7_g5 = (float2(temp_output_4_0_g5 , temp_output_5_0_g5));
			float totalFrames39_g5 = ( temp_output_4_0_g5 * temp_output_5_0_g5 );
			float2 appendResult8_g5 = (float2(totalFrames39_g5 , temp_output_5_0_g5));
			float mulTime5 = _Time.y * _Speed;
			float clampResult42_g5 = clamp( 0.0 , 0.0001 , ( totalFrames39_g5 - 1.0 ) );
			float temp_output_35_0_g5 = frac( ( ( mulTime5 + clampResult42_g5 ) / totalFrames39_g5 ) );
			float2 appendResult29_g5 = (float2(temp_output_35_0_g5 , ( 1.0 - temp_output_35_0_g5 )));
			float2 temp_output_15_0_g5 = ( ( appendResult11 / appendResult7_g5 ) + ( floor( ( appendResult8_g5 * appendResult29_g5 ) ) / appendResult7_g5 ) );
			float3 break6_g11 = UnpackScaleNormal( tex2D( _RipplesNormal, temp_output_15_0_g5 ), RippleMAsk62 );
			float2 appendResult1_g11 = (float2(break6_g11.x , break6_g11.y));
			float3 appendResult4_g11 = (float3(( appendResult1_g11 * _MFIntense ) , break6_g11.z));
			float2 temp_cast_1 = (( RippleTile14 / 0.7 )).xx;
			float2 uv_TexCoord19 = i.uv_texcoord * temp_cast_1 + _Vector0;
			float2 appendResult22 = (float2(frac( uv_TexCoord19.x ) , frac( uv_TexCoord19.y )));
			float temp_output_4_0_g4 = 4.0;
			float temp_output_5_0_g4 = 4.0;
			float2 appendResult7_g4 = (float2(temp_output_4_0_g4 , temp_output_5_0_g4));
			float totalFrames39_g4 = ( temp_output_4_0_g4 * temp_output_5_0_g4 );
			float2 appendResult8_g4 = (float2(totalFrames39_g4 , temp_output_5_0_g4));
			float clampResult42_g4 = clamp( 0.0 , 0.0001 , ( totalFrames39_g4 - 1.0 ) );
			float temp_output_35_0_g4 = frac( ( ( mulTime5 + clampResult42_g4 ) / totalFrames39_g4 ) );
			float2 appendResult29_g4 = (float2(temp_output_35_0_g4 , ( 1.0 - temp_output_35_0_g4 )));
			float2 temp_output_15_0_g4 = ( ( appendResult22 / appendResult7_g4 ) + ( floor( ( appendResult8_g4 * appendResult29_g4 ) ) / appendResult7_g4 ) );
			float3 RippleNormals34 = BlendNormals( appendResult4_g11 , UnpackScaleNormal( tex2D( _RipplesNormal, temp_output_15_0_g4 ), RippleMAsk62 ) );
			o.Normal = BlendNormals( UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) ) , RippleNormals34 );
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 Abedo85 = ( ( tex2D( _Diffuse, uv_Diffuse ) * _Tint ) * _Diffuseintense );
			o.Albedo = Abedo85.rgb;
			o.Smoothness = _Wetness;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			o.Occlusion = tex2D( _TextureSample1, uv_TextureSample1 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
1930;29;1622;1004;2233.763;762.892;2.067651;True;True
Node;AmplifyShaderEditor.CommentaryNode;15;-1701.633,-275.0969;Float;False;479.08;170.4525;Comment;2;14;3;RippleTile;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1651.633,-212.5195;Float;False;Property;_Tiling;Tiling;5;0;Create;True;0;0;False;0;1;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1462.553,-219.2444;Float;False;RippleTile;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;63;-2680.664,-1759.66;Float;False;1575.454;699.7885;Ripple Mask;17;78;62;77;75;48;71;70;53;56;61;72;55;59;74;73;58;60;Ripple Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-2616.224,-1588.422;Float;False;14;RippleTile;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;74;-2621.54,-1288.328;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;55;-2602.811,-1709.66;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;73;-2634.953,-1163.496;Float;False;14;RippleTile;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;59;-2587.364,-1500.886;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-2630.664,-1412.552;Float;False;Property;_SpeedRippleMask;SpeedRippleMask;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-2373.808,-1644.078;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-2422.005,-1486.977;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-2390.741,-1190.404;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;53;-2236.912,-1625.592;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.57,0.47;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;70;-2234.635,-1337.685;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.57,-0.47;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;40;-3515.123,-76.91982;Float;False;2629.521;787.6002;Comment;62;34;33;99;39;38;4;17;66;1;25;65;18;45;49;23;68;11;29;67;22;12;50;10;24;2;51;21;20;28;64;52;19;26;41;42;5;27;7;16;8;104;105;106;107;108;109;110;111;112;113;114;115;116;117;118;119;120;121;122;123;124;125;RippleNormals;1,1,1,1;0;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;71;-2037.301,-1344.318;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;48;-2039.578,-1632.225;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-1743.812,-1444.281;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-1808.305,-1543.211;Float;False;Property;_MaskStrenght;MaskStrenght;13;0;Create;True;0;0;False;0;1;0.587;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-3465.123,47.20573;Float;False;14;RippleTile;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-3209.404,192.8984;Float;False;Property;_Speed;Speed;6;0;Create;True;0;0;False;0;1;9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-3018.955,204.1663;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;118;-3240.189,70.21213;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-1477.191,-1466.525;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-1322.436,-1473.248;Float;False;RippleMAsk;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;117;-3234.952,38.79354;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;52;-2781.707,230.5871;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;8;-2594.957,247.3574;Float;True;Property;_RipplesNormal;RipplesNormal;8;0;Create;True;0;0;False;0;None;17ae57d8652469e49a436457fc6b6436;True;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;125;-3301.718,91.15792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;51;-2747.717,219.2568;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;-2316.257,190.2429;Float;False;62;RippleMAsk;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-3135.37,-21.16792;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;50;-2753.381,128.6146;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;119;-3308.262,133.0494;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;10;-2877.292,-26.91982;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;24;-2147.039,291.9449;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;68;-2068.257,212.2429;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;12;-2873.356,67.98031;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;49;-2719.39,125.782;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;124;-3405.137,147.4496;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;66;-2058.257,195.2429;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;23;-2109.707,276.297;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-2744.784,-3.392995;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1;-2569.749,-2.264951;Float;False;Flipbook;-1;;5;53c2488c220f6564ca6c90721ee16673;2,71,0,68,0;8;51;SAMPLER2D;0.0;False;13;FLOAT2;0,0;False;4;FLOAT;4;False;5;FLOAT;4;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.WireNode;25;-2111.795,59.75378;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;123;-2059.373,85.92187;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;120;-3407.754,165.7771;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;121;-3412.991,279.6695;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-2005.302,-4.479867;Float;True;Property;_FlipBook;FlipBook;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;42;-3432.332,460.2374;Float;False;Property;_Vector0;Vector 0;9;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;41;-3341.217,264.3557;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;27;-2147.039,316.8226;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;113;-2778.075,253.4872;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;109;-1730.788,37.48434;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-3190.76,437.3333;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.49,0.23;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;111;-1734.715,164.4678;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;114;-2776.764,280.9786;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;26;-2138.746,349.9927;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;67;-2059.257,228.2429;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;20;-2928.746,526.4818;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;21;-2927.446,431.5815;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;112;-1784.461,181.4863;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;115;-2774.146,591.2371;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;28;-2136.673,468.1612;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;29;-2126.307,488.8929;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-2801.346,456.2815;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;65;-2060.257,246.2429;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;116;-2776.764,616.1104;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;110;-1789.698,224.6869;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;18;-2626.708,501.3468;Float;False;Flipbook;-1;;4;53c2488c220f6564ca6c90721ee16673;2,71,0,68,0;8;51;SAMPLER2D;0.0;False;13;FLOAT2;0,0;False;4;FLOAT;4;False;5;FLOAT;4;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.WireNode;45;-2077.901,491.8377;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;122;-2065.918,532.3282;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;99;-1726.215,212.8031;Float;False;NormalIntense;3;;11;30562070d452005448884f54efb60ac5;0;1;5;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;105;-1451.949,254.7963;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;17;-2011.719,458.9851;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;106;-1457.185,278.3604;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;38;-1729.694,471.6093;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;39;-1729.995,390.7434;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;107;-1592.022,286.2149;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;104;-1709.842,372.6161;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;108;-1598.568,332.0338;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;100;-2213.133,-872.0831;Float;False;1019.418;530.9945;Comment;6;80;82;81;83;84;85;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.BlendNormalsNode;33;-1545.819,321.8326;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;82;-2076.084,-628.0886;Float;False;Property;_Tint;Tint;1;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;80;-2163.133,-822.0831;Float;True;Property;_Diffuse;Diffuse;0;0;Create;True;0;0;False;0;None;6b2910686f14f5844bf4707db2d5e2ba;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-1318.942,317.7471;Float;False;RippleNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;126;-742.9573,-140.5911;Float;True;Property;_NormalMap;NormalMap;11;0;Create;True;0;0;False;0;None;e58d0d54d1a307d49b6895e5a64c5b04;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;35;-666.9791,140.599;Float;False;34;RippleNormals;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2059.084,-456.0888;Float;False;Property;_Diffuseintense;Diffuse intense;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-1792.085,-713.0886;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;142;-693.3624,293.6775;Float;True;Property;_TextureSample1;Texture Sample 1;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;134;-394.8939,-82.00256;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-1613.085,-623.0886;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;137;-380.8939,151.9974;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;144;-194.5176,329.3689;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;135;-368.8939,82.99744;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;-1436.717,-627.3485;Float;False;Abedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;136;-377.8939,15.99744;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;143;-93.20261,300.4219;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendNormalsNode;133;-295.8939,16.99744;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-260.9908,115.4438;Float;False;Property;_Wetness;Wetness;7;0;Create;True;0;0;False;0;0.8;0.77;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;89;-274.1996,-61.30411;Float;False;85;Abedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;RainDropRipple;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;3;0
WireConnection;56;0;55;0
WireConnection;56;1;58;0
WireConnection;61;0;59;0
WireConnection;61;1;60;0
WireConnection;72;0;74;0
WireConnection;72;1;73;0
WireConnection;53;0;56;0
WireConnection;53;1;61;0
WireConnection;70;0;72;0
WireConnection;70;1;61;0
WireConnection;71;0;70;0
WireConnection;48;0;53;0
WireConnection;75;0;48;0
WireConnection;75;1;71;0
WireConnection;5;0;7;0
WireConnection;118;0;16;0
WireConnection;77;0;78;0
WireConnection;77;1;75;0
WireConnection;62;0;77;0
WireConnection;117;0;118;0
WireConnection;52;0;5;0
WireConnection;125;0;16;0
WireConnection;51;0;52;0
WireConnection;2;0;117;0
WireConnection;50;0;51;0
WireConnection;119;0;125;0
WireConnection;10;0;2;1
WireConnection;24;0;8;0
WireConnection;68;0;64;0
WireConnection;12;0;2;2
WireConnection;49;0;50;0
WireConnection;124;0;119;0
WireConnection;66;0;68;0
WireConnection;23;0;24;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;1;13;11;0
WireConnection;1;2;49;0
WireConnection;25;0;23;0
WireConnection;123;0;66;0
WireConnection;120;0;124;0
WireConnection;121;0;120;0
WireConnection;4;0;25;0
WireConnection;4;1;1;0
WireConnection;4;5;123;0
WireConnection;41;0;121;0
WireConnection;27;0;8;0
WireConnection;113;0;5;0
WireConnection;109;0;4;0
WireConnection;19;0;41;0
WireConnection;19;1;42;0
WireConnection;111;0;109;0
WireConnection;114;0;113;0
WireConnection;26;0;27;0
WireConnection;67;0;64;0
WireConnection;20;0;19;2
WireConnection;21;0;19;1
WireConnection;112;0;111;0
WireConnection;115;0;114;0
WireConnection;28;0;26;0
WireConnection;29;0;28;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;65;0;67;0
WireConnection;116;0;115;0
WireConnection;110;0;112;0
WireConnection;18;13;22;0
WireConnection;18;2;116;0
WireConnection;45;0;29;0
WireConnection;122;0;65;0
WireConnection;99;5;110;0
WireConnection;105;0;99;0
WireConnection;17;0;45;0
WireConnection;17;1;18;0
WireConnection;17;5;122;0
WireConnection;106;0;105;0
WireConnection;38;0;17;0
WireConnection;39;0;38;0
WireConnection;107;0;106;0
WireConnection;104;0;39;0
WireConnection;108;0;107;0
WireConnection;33;0;108;0
WireConnection;33;1;104;0
WireConnection;34;0;33;0
WireConnection;83;0;80;0
WireConnection;83;1;82;0
WireConnection;134;0;126;0
WireConnection;84;0;83;0
WireConnection;84;1;81;0
WireConnection;137;0;35;0
WireConnection;144;0;142;0
WireConnection;135;0;137;0
WireConnection;85;0;84;0
WireConnection;136;0;134;0
WireConnection;143;0;144;0
WireConnection;133;0;136;0
WireConnection;133;1;135;0
WireConnection;0;0;89;0
WireConnection;0;1;133;0
WireConnection;0;4;9;0
WireConnection;0;5;143;0
ASEEND*/
//CHKSM=72C95B541895C3CBBB2D109B1CEE2CA5D5B7BBD7