// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CutoutMasks/Cutout"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		[MaterialToggle] Invert("Invert", float) = 0
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[MaterialToggle] Flip ("Direct3D & Anti-Aliasing?", Float) = 0
	}
	SubShader
	{

		Tags
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent" 
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
		}

		Pass
		{
			Cull Off
			Lighting Off
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile _ INVERT_ON
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ FLIP_ON

			#include "UnityCG.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				half4 color : COLOR;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float2 pos : TEXCOORD1;
				float4 vertex : SV_POSITION;
				half4 color : COLOR;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				#if defined(PIXELSNAP_ON)
				o.vertex = UnityPixelSnap (o.vertex);
				#endif

				o.uv = v.uv;
				o.pos = ((o.vertex.xy / o.vertex.w) + 1) * 0.5;
				o.color = v.color;
				
				return o;
			}
			
			sampler2D _MainTex;
			uniform sampler2D _CutoutMaskTexture;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv) * i.color;

				#if defined(FLIP_ON)
        				i.pos.y = 1-i.pos.y;
				#endif

				#if defined(INVERT_ON)
					col.a = col.a * tex2D(_CutoutMaskTexture, i.pos).a;
				#else
					col.a = col.a * (1 - tex2D(_CutoutMaskTexture, i.pos).a);
				#endif

				return col;
			}
			ENDCG
		}
	}
Fallback "Transparent/VertexLit"
}
