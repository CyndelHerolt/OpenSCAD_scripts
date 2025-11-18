// Paramètres de la courbe de Lissajous
freq_x = 3;   // Fréquence sur X
freq_y = 2;   // Fréquence sur Y
freq_z = 5;   // Fréquence sur Z
amplitude = 20; // Amplitude globale
phases = [0, 0, 0]; // Déphasages [X, Y, Z]

// Paramètres du tube
diameter = 3;      // Diamètre du tube
$fn = 32;          // Résolution des cercles
steps = 300;       // Nombre de points (plus = plus lisse)
periods = 3;       // Nombre de périodes

// Création du roller
module lissajous_roller() {
    // Calcul des points de la courbe
    function point(t) = [
        amplitude * sin(freq_x * t * 360 + phases[0]),
        amplitude * sin(freq_y * t * 360 + phases[1]),
        amplitude * sin(freq_z * t * 360 + phases[2])
    ];
    
    // Génération des segments tubulaires
    for (t = [0 : 1/steps : periods - 1/steps]) {
        hull() {
            translate(point(t)) sphere(d = diameter);
            translate(point(t + 1/steps)) sphere(d = diameter);
        }
    }
}

// Rendu du modèle
lissajous_roller();
