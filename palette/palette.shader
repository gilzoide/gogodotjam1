shader_type canvas_item;

uniform vec4 foreground: hint_color = vec4(1, 1, 1, 1);
uniform vec4 background: hint_color = vec4(0, 0, 0, 1);

void fragment() {
	vec4 color = textureLod(TEXTURE, UV, 0);
	float luminance = dot(color.rgb, vec3(0.3, 0.59, 0.11));
	vec4 final = mix(background, foreground, luminance);
	COLOR = vec4(final.rgb, final.a * color.a);
}