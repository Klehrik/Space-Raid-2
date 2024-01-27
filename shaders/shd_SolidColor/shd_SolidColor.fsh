// Solid Color

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float color[3];

void main()
{
    gl_FragColor = vec4(color[0], color[1], color[2], texture2D(gm_BaseTexture, v_vTexcoord).a);
}