// shader example for Processing
// uniform - variables set in Processing sketch using shader.set()
// varying - variables set by Processing itself

// image to process
uniform sampler2D texture;
// mouse position normalized
uniform int count;
uniform vec2 inp;
uniform float r;
uniform float times;
uniform vec2 resolution;
// vertex color
varying vec4 vertColor;
// vertex position
varying vec4 vertTexCoord;

#define TWO_PI (6.28318530718)

void main() {	
  float mx = max(resolution.x, resolution.y);
// vec4 col = texture2D(texture,vertTexCoord.xy); // take color from texture
 vec2 uv = gl_FragCoord.xy / mx;
 vec3 color=vec3(0);
 for (int n = 0; n < count; ++n) {
		color = max(color, smoothstep(
			r,
			0.02,
			distance(uv, inp.xy / mx)));
 }

   vec2 tc0 = vertTexCoord.st ;
  vec2 tc1 = vertTexCoord.st ;
  vec2 tc2 = vertTexCoord.st ;
  vec2 tc3 = vertTexCoord.st ;
  vec2 tc4 = vertTexCoord.st ;
  vec2 tc5 = vertTexCoord.st ;
  vec2 tc6 = vertTexCoord.st ;
  vec2 tc7 = vertTexCoord.st ;
  vec2 tc8 = vertTexCoord.st ;

  vec4 col0 = texture2D(texture, tc0);
  vec4 col1 = texture2D(texture, tc1);
  vec4 col2 = texture2D(texture, tc2);
  vec4 col3 = texture2D(texture, tc3);
  vec4 col4 = texture2D(texture, tc4);
  vec4 col5 = texture2D(texture, tc5);
  vec4 col6 = texture2D(texture, tc6);
  vec4 col7 = texture2D(texture, tc7);
  vec4 col8 = texture2D(texture, tc8);

  vec4 sum = (1.0* col0 + 2.0 * col1 + 1.0 * col2 +  
              2.0 * col3 + 4.0 * col4 + 2.0 * col4 +
              1.0 * col5 + 2.0 * col6 + 1.0 * col7) / 16.0;            
  vec4 tr = vec4(vec3(sum.rgb), 1.) * vertColor;
  gl_FragColor=vec4(-(vec3(1.)-color)+tr.xyz,1.);
 // set color from texture from current position + offest. Wrapped.
}