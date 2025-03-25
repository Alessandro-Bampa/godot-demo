shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

//uniform -> esponi una variabile in gdscript nell'ispector dello shader (material)
uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0; //crea un range da 0.0 a 1.0 con step di 0.1

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 current_color = texture(TEXTURE, UV); //restituisce il colore originale del pixel
	float current_a = texture(TEXTURE, UV).a; //restituisce il valore alpha (opacita) del pixel
	//COLOR = vec4(UV.x,1,1,1); //cambia il colore di ogni pixel dello sprite
	//mixa due valori, in questo caso 2 vect4; il valore finale di 1.0 determina che vedremo solo i pixel del secondo vect. 
	// se avessimo 0.5 vedremmo il 50% del primo che è quello originale e 50% del secondo che imposta i pixel a bianco mantenendo l'opacità originale (current_a)
	//  vec4(vec3(1), current_a) significa che il vec4 viene creato con i primi 3 parametri a 1 tramite un vec3 e il valore di opacità con una variabile (current_a)
	//vec4 target_color = mix(texture(TEXTURE, UV), vec4(vec3(1), current_a), 1.0); 
	vec4 target_color = mix(texture(TEXTURE, UV), vec4(color, current_a), progress); 
	COLOR = target_color;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
