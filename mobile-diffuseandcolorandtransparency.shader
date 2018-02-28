// Simplified Diffuse Color shader. Based on the Mobile Diffuse Shader.
// - fully supports only 1 directional light. Other lights can affect it, but it will be per-vertex/SH.
// + added color in addition to a diffuse texture, which are multiplied together for easy scripting.
Shader "Mobile/Diffuse And Color And Transparency" 
{
    Properties 
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}    //Texture, set to none to ignore or something to tint per-pixel
        _Color("Color", Color) = (1,1,1,1)            //Color, set to white to ignore or something else to tint
        _Diffuseness("Diffuseness", Range(0,1)) = 1 //Controls Diffuse(1) vs Flat(0)
    }
    
    SubShader 
    {
        Tags 
        { 
            "Queue"="Transparent" //render after opaque geometry
            "RenderType"="Transparency" //lighting stuff
        }
        
        //Implied by fade, don't need
        //Blend SrcAlpha OneMinusSrcAlpha
        
        CGPROGRAM
            #pragma surface surf Lambert noforwardadd alpha:fade 
            sampler2D _MainTex;
            fixed4 _Color;
            fixed _Diffuseness;
            struct Input 
            {
                float2 uv_MainTex;
            };
            void surf (Input IN, inout SurfaceOutput o) 
            {
                fixed4 c = _Color * tex2D(_MainTex, IN.uv_MainTex);
                o.Albedo = lerp(fixed3(0,0,0), c.rgb, _Diffuseness);
                o.Emission = lerp(fixed3(0,0,0), c.rgb, 1.0-_Diffuseness);
                o.Alpha = c.a;
            }           
        ENDCG
    }
    
    //No fallback.
}
