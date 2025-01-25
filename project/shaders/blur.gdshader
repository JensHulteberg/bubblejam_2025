/*
	Glitch Effect Shader by Yui Kinomoto @arlez80

	MIT License
*/

shader_type canvas_item;

uniform bool glitchy = false;

uniform sampler2D offset_image;
uniform float strength = 1.0;
uniform float lod: hint_range(0.0, 5) = 0.0;

uniform float shake_power = 0.03;

uniform float shake_rate : hint_range( 0.0, 1.0 ) = 0.2;

uniform float shake_speed = 5.0;

uniform float shake_block_size = 30.5;

uniform float shake_color_rate : hint_range( 0.0, 1.0 ) = 0.01;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float random( float seed )
{
	return fract( 543.2543 * sin( dot( vec2( seed, seed ), vec2( 3525.46, -54.3415 ) ) ) );
}

vec4 glitch(vec2 screen_uv)
{
	float enable_shift = float(
		random( trunc( TIME * shake_speed ) )
	<	shake_rate
	);

	vec2 fixed_uv = screen_uv;
	fixed_uv.x += (
		random(
			( trunc( screen_uv.y * shake_block_size ) / shake_block_size )
		+	TIME
		) - 0.5
	) * shake_power * enable_shift;

	vec4 pixel_color = textureLod( SCREEN_TEXTURE, fixed_uv, lod );
	pixel_color.r = mix(
		pixel_color.r
	,	textureLod( SCREEN_TEXTURE, fixed_uv + vec2( shake_color_rate, 0.0 ), lod ).r
	,	enable_shift
	);
	pixel_color.b = mix(
		pixel_color.b
	,	textureLod( SCREEN_TEXTURE, fixed_uv + vec2( -shake_color_rate, 0.0 ), lod ).b
	,	enable_shift
	);

	return pixel_color;
}

vec4 chrom_abb(vec2 screen_uv)
{
	vec4 output = texture(SCREEN_TEXTURE, screen_uv);

	float shift = (strength * texture(offset_image, screen_uv).r / 100.0);

	output.r = textureLod(SCREEN_TEXTURE, vec2(screen_uv.x + shift, screen_uv.y), lod).r;
	output.g = textureLod(SCREEN_TEXTURE, screen_uv, lod).g;
	output.b = textureLod(SCREEN_TEXTURE, vec2(screen_uv.x - shift, screen_uv.y), lod).b;

	return output;
}

void fragment( )
{
	if (glitchy)
	{
	COLOR = glitch(SCREEN_UV);
	}
	else
	{
		COLOR = chrom_abb(SCREEN_UV);
	}
}
