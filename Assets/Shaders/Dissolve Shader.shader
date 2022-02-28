Shader "Spine/Dissolve Shader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
        _DissloveTexture("Dissolve Texture", 2D) = "white" {}
        [HideInInspector] _Amount("Amount", Range(0,1)) = 0
    }
    SubShader
    {
        Tags { "IgnoreProjector"="True" "Queue"="Transparent" "RenderType"="Transparent" "PreviewType"="Plane" }
        LOD 100
        Cull Off //Fast way to turn your material double-sided
        Blend One OneMinusSrcAlpha
		ZWrite Off
		Lighting Off

        CGPROGRAM
        // #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
        // #include "UnityCG.cginc"


        

        sampler2D _MainTex;
        fixed4 _Color;

        

        
        ENDCG

        Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			sampler2D _MainTex;

			struct VertexInput {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 vertexColor : COLOR;
			};

			struct VertexOutput {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 vertexColor : COLOR;
			};

            sampler2D _DissloveTexture;
            half _Amount;

			VertexOutput vert (VertexInput v) {
				VertexOutput o;
				o.uv = v.uv;
				o.vertexColor = v.vertexColor;
				o.pos = UnityObjectToClipPos(v.vertex); // Unity 5.6
				return o;
			}

			float4 frag (VertexOutput i) : COLOR {
                half dissolve_value = tex2D(_DissloveTexture, i.uv).r;
                clip(dissolve_value - _Amount);

                // i.Emission = fixed3(1, 1, 1) * step( dissolve_value - _Amount, 0.05f) * _Color;

				float4 rawColor = tex2D(_MainTex,i.uv);
				float finalAlpha = rawColor.a * i.vertexColor.a;
				float3 finalColor = rawColor.rgb * i.vertexColor.rgb;
				return float4(finalColor, finalAlpha);
			}
			ENDCG
		}
    }
}
