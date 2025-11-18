// Paramètres de l'éponge de Menger
niveau = 3;          // Niveau de récursion (0 = cube simple)
taille_initiale = 100; // Taille du cube initial
affichage_plein = 0; // 0=éponge, 1=cube plein (pour debug)

// Module principal
module menger_sponge(level, size) {
    if (level <= 0 || affichage_plein) {
        cube(size, center = true);
    } else {
        // Taille des sous-cubes
        new_size = size/3;
        // Distance entre les centres des sous-cubes
        offset = size/3;
        
        // Génération des 20 sous-cubes
        for (x = [-offset, 0, offset],
             y = [-offset, 0, offset],
             z = [-offset, 0, offset]) {
            
            // Condition pour supprimer les cubes centraux
            if (!(abs(x) == 0 && abs(y) == 0 && abs(z) == 0) && // Centre
                !(abs(x) == 0 && abs(y) == 0) && // Colonne centrale Z
                !(abs(x) == 0 && abs(z) == 0) && // Colonne centrale Y
                !(abs(y) == 0 && abs(z) == 0))   // Colonne centrale X
            {
                translate([x, y, z])
                    menger_sponge(level - 1, new_size);
            }
        }
    }
}

// Rendu du modèle
menger_sponge(niveau, taille_initiale);
