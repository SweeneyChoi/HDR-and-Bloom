#version 430 core
out vec4 color;
in vec2 TexCoords;

uniform sampler2D hdrBuffer;
uniform float exposure;
uniform bool hdr;

void main()
{
	const float gamma = 2.2;
	vec3 hdrColor = texture(hdrBuffer, TexCoords).rgb;

	// reinhardɫ��ӳ��
	//vec3 result = hdrColor / (hdrColor + vec3(1.0));
	// exposure
	vec3 result = vec3(1.0) - exp(-hdrColor * exposure);
	// GammaУ��       
	result = pow(result, vec3(1.0 / gamma));
	color = vec4(result, 1.0f);
}