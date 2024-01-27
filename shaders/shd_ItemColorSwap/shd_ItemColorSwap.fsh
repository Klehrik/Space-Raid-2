// Item Color Swap

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float source[3];
uniform float source2[3];
uniform float dest[3];
uniform float dest2[3];

void main()
{
	vec3 c = texture2D(gm_BaseTexture, v_vTexcoord).rgb;
	
	if (c == vec3(source[0], source[1], source[2])) c = vec3(dest[0], dest[1], dest[2]);
	if (c == vec3(source2[0], source2[1], source2[2])) c = vec3(dest2[0], dest2[1], dest2[2]);
	
    gl_FragColor = vec4(c, texture2D(gm_BaseTexture, v_vTexcoord).a);
}