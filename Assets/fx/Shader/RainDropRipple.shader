// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RainDropRipple"
{
	Properties
	{
		_Tiling("Tiling", Float) = 1
		_Speed("Speed", Float) = 1
		_Wetness("Wetness", Float) = 0.8
		_RipplesNormal("RipplesNormal", 2D) = "white" {}
		_RippleStrenght("RippleStrenght", Float) = 1
		_Vector0("Vector 0", Vector) = (0,0,0,0)
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

		uniform sampler2D _RipplesNormal;
		uniform float _RippleStrenght;
		uniform float _Tiling;
		uniform float _Speed;
		uniform float2 _Vector0;
		uniform float _Wetness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float RippleTile14 = _Tiling;
			float2 temp_cast_0 = (RippleTile14).xx;
			float2 uv_TexCoord2 = i.uv_texcoord * temp_cast_0;
			float2 appendResult11 = (float2(frac( uv_TexCoord2.x ) , frac( uv_TexCoord2.y )));
			float temp_output_4_0_g1 = 4.0;
			float temp_output_5_0_g1 = 4.0;
			float2 appendResult7_g1 = (float2(temp_output_4_0_g1 , temp_output_5_0_g1));
			float totalFrames39_g1 = ( temp_output_4_0_g1 * temp_output_5_0_g1 );
			float2 appendResult8_g1 = (float2(totalFrames39_g1 , temp_output_5_0_g1));
			float mulTime5 = _Time.y * _Speed;
			float clampResult42_g1 = clamp( 0.0 , 0.0001 , ( totalFrames39_g1 - 1.0 ) );
			float temp_output_35_0_g1 = frac( ( ( mulTime5 + clampResult42_g1 ) / totalFrames39_g1 ) );
			float2 appendResult29_g1 = (float2(temp_output_35_0_g1 , ( 1.0 - temp_output_35_0_g1 )));
			float2 temp_output_15_0_g1 = ( ( appendResult11 / appendResult7_g1 ) + ( floor( ( appendResult8_g1 * appendResult29_g1 ) ) / appendResult7_g1 ) );
			float2 temp_cast_1 = (( RippleTile14 / 0.7 )).xx;
			float2 uv_TexCoord19 = i.uv_texcoord * temp_cast_1 + _Vector0;
			float2 appendResult22 = (float2(frac( uv_TexCoord19.x ) , frac( uv_TexCoord19.y )));
			float temp_output_4_0_g2 = 4.0;
			float temp_output_5_0_g2 = 4.0;
			float2 appendResult7_g2 = (float2(temp_output_4_0_g2 , temp_output_5_0_g2));
			float totalFrames39_g2 = ( temp_output_4_0_g2 * temp_output_5_0_g2 );
			float2 appendResult8_g2 = (float2(totalFrames39_g2 , temp_output_5_0_g2));
			float clampResult42_g2 = clamp( 0.0 , 0.0001 , ( totalFrames39_g2 - 1.0 ) );
			float temp_output_35_0_g2 = frac( ( ( mulTime5 + clampResult42_g2 ) / totalFrames39_g2 ) );
			float2 appendResult29_g2 = (float2(temp_output_35_0_g2 , ( 1.0 - temp_output_35_0_g2 )));
			float2 temp_output_15_0_g2 = ( ( appendResult22 / appendResult7_g2 ) + ( floor( ( appendResult8_g2 * appendResult29_g2 ) ) / appendResult7_g2 ) );
			float3 RippleNormals34 = BlendNormals( UnpackScaleNormal( tex2D( _RipplesNormal, temp_output_15_0_g1 ), _RippleStrenght ) , UnpackScaleNormal( tex2D( _RipplesNormal, temp_output_15_0_g2 ), ( _RippleStrenght + -0.15 ) ) );
			o.Normal = RippleNormals34;
			o.Smoothness = _Wetness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
535.2;266.4;1523;789;3347.482;143.9428;1.498346;True;True
Node;AmplifyShaderEditor.CommentaryNode;15;-1701.633,-275.0969;Float;False;479.08;170.4525;Comment;2;14;3;RippleTile;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1651.633,-225.0969;Float;False;Property;_Tiling;Tiling;0;0;Create;True;0;0;False;0;1;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;40;-3515.123,-76.91982;Float;False;2312.178;778.2666;Comment;37;16;2;10;12;7;5;21;20;22;18;11;1;8;25;23;24;27;26;28;29;4;13;30;31;32;19;33;37;36;17;38;39;34;41;42;45;47;RippleNormals;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;8;-2594.957,247.3574;Float;True;Property;_RipplesNormal;RipplesNormal;3;0;Create;True;0;0;False;0;None;17ae57d8652469e49a436457fc6b6436;True;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-3465.123,47.20573;Float;False;14;RippleTile;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1462.553,-219.2444;Float;False;RippleTile;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;27;-2147.039,316.8226;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector2Node;42;-3432.332,460.2374;Float;False;Property;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;0,0;1.17,0.12;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;41;-3341.217,264.3557;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-3190.76,437.3333;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.49,0.23;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;26;-2138.746,349.9927;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-3135.37,-21.16792;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-2480.24,158.6249;Float;False;Property;_RippleStrenght;RippleStrenght;4;0;Create;True;0;0;False;0;1;0.53;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;30;-2093.138,190.3613;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;20;-2928.746,526.4818;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;28;-2136.673,468.1612;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;24;-2147.039,291.9449;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FractNode;12;-2873.356,67.98031;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-3209.404,192.8984;Float;False;Property;_Speed;Speed;1;0;Create;True;0;0;False;0;1;9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;10;-2872.056,-26.91982;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;21;-2927.446,431.5815;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-3018.955,204.1663;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;23;-2109.707,276.297;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;29;-2126.307,488.8929;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-2801.346,456.2815;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;31;-2086.918,150.9717;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-2744.784,-3.392995;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;45;-2077.901,491.8377;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;32;-2084.845,90.85081;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-2207.24,236.6369;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;25;-2111.795,59.75378;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;1;-2569.749,-2.264951;Float;False;Flipbook;-1;;1;53c2488c220f6564ca6c90721ee16673;2,71,0,68,0;8;51;SAMPLER2D;0.0;False;13;FLOAT2;0,0;False;4;FLOAT;4;False;5;FLOAT;4;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.FunctionNode;18;-2626.708,501.3468;Float;False;Flipbook;-1;;2;53c2488c220f6564ca6c90721ee16673;2,71,0,68,0;8;51;SAMPLER2D;0.0;False;13;FLOAT2;0,0;False;4;FLOAT;4;False;5;FLOAT;4;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.SamplerNode;17;-2011.719,458.9851;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-2005.302,-4.479867;Float;True;Property;_FlipBook;FlipBook;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;38;-1729.694,471.6093;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;36;-1734.511,44.48401;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;39;-1739.328,303.0072;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;37;-1740.934,258.0466;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;33;-1689.557,237.8298;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-1447.745,231.8775;Float;False;RippleNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;-295.819,17.2448;Float;False;34;RippleNormals;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-247.9908,84.44376;Float;False;Property;_Wetness;Wetness;2;0;Create;True;0;0;False;0;0.8;0.78;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;RainDropRipple;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;3;0
WireConnection;27;0;8;0
WireConnection;41;0;16;0
WireConnection;19;0;41;0
WireConnection;19;1;42;0
WireConnection;26;0;27;0
WireConnection;2;0;16;0
WireConnection;30;0;13;0
WireConnection;20;0;19;2
WireConnection;28;0;26;0
WireConnection;24;0;8;0
WireConnection;12;0;2;2
WireConnection;10;0;2;1
WireConnection;21;0;19;1
WireConnection;5;0;7;0
WireConnection;23;0;24;0
WireConnection;29;0;28;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;31;0;30;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;45;0;29;0
WireConnection;32;0;31;0
WireConnection;47;0;13;0
WireConnection;25;0;23;0
WireConnection;1;13;11;0
WireConnection;1;2;5;0
WireConnection;18;13;22;0
WireConnection;18;2;5;0
WireConnection;17;0;45;0
WireConnection;17;1;18;0
WireConnection;17;5;47;0
WireConnection;4;0;25;0
WireConnection;4;1;1;0
WireConnection;4;5;32;0
WireConnection;38;0;17;0
WireConnection;36;0;4;0
WireConnection;39;0;38;0
WireConnection;37;0;36;0
WireConnection;33;0;37;0
WireConnection;33;1;39;0
WireConnection;34;0;33;0
WireConnection;0;1;35;0
WireConnection;0;4;9;0
ASEEND*/
//CHKSM=C4B735D5C64D361A10F33CB706E68F2DE02497DA