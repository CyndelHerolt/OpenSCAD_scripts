// ==========================================
// --- VARIABLES DE CONFIGURATION ---
// ==========================================

$fn = 100;

// Dimensions globales
main_height = 150;
decalage_trou = 15; // Décalage de 15mm sur l'axe X pour le 2ème sas

sas_dimensions = [75, 65, 5];
sas_hole_d = 42;

// --- POSITIONS DES MODULES (X, Y, Z) ---
// Modifiez ces valeurs pour déplacer les éléments

pos_tube = [0, 0, 0];

pos_sas_bas = [0, 0, -3];

pos_poussoir = [-90, 0, -5];
pos_tige = [-90, 0, -5]; // Généralement aligné avec le poussoir

pos_piece_demo = [100, 0, 0];


// ==========================================
// --- DEFINITION DES MODULES ---
// ==========================================

/**
 * Crée le tube principal pour les pièces.
 * @param height Hauteur du tube.
 * @param outer_d Diamètre extérieur.
 * @param inner_d Diamètre intérieur.
 */
module tube(height = 150, outer_d = 47, inner_d = 42) {
    difference() {
        cylinder(h = height, d = outer_d);
        translate([0, 0, -1])
        cylinder(h = height + 2, d = inner_d);
    }
    
    difference() {
        translate([-25,0,71])
        rotate([0,0,90])
        cube([70, 5, height-3], center=true);
        
        translate([-30, 0, 5])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
      
      // trous pour fixation
      translate([-30, -30, 30])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
      translate([-30, -30, 40])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
        
      translate([-30, 30, 30])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
      translate([-30, 30, 40])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
                
      translate([-30, 30, 110])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
      translate([-30, 30, 120])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
                        
      translate([-30, -30, 110])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
      translate([-30, -30, 120])
        rotate([0, 90, 0])
        cylinder(h=30, d=4, center=true); 
                
    }
    
    difference() {
        // La plaque rectangulaire
        translate([10,0,0])
            cube(sas_dimensions - [5, 5, 0], center = true);

        // Le trou cylindrique
        translate([0,0,-5])
            cylinder(h = 15, d = sas_hole_d);
    }
}

/**
 * Partie trouée pour le sas
 * @param cube_pos Position du centre de la plaque rectangulaire (relative au module).
 * @param hole_pos Position du centre du trou cylindrique (relative au module).
 * @param sas_hole_d Diamètre du trou cylindrique.
 * @param wall Si vrai, ajoute un mur latéral.
 */
module sas_piece(cube_pos, hole_pos, wall = false) {
    color("orange") {
        difference() {
            // La plaque rectangulaire
            translate(cube_pos)
                cube(sas_dimensions, center = true);

            // Le trou cylindrique
            translate(hole_pos)
                cylinder(h = 15, d = sas_hole_d);
        }
        
        difference() {
    // 1. On groupe tous les murs pour en faire UN SEUL objet positif
    union() {
        // mur fond
        translate([45, 0, -5])
            cube([5, 55, 15], center = true);
            
        // mur coté 1
        translate([10, -30, -5])
        rotate([0,0,90])
            cube([5, 75, 15], center = true);
            
        // mur coté 2
        translate([10, 30, -5])
        rotate([0,0,90])
            cube([5, 75, 15], center = true);
    }

    // 2. On soustrait la planche à l'ensemble des murs
    translate([10,0,3])
        cube(sas_dimensions - [5, 5, 0], center = true);
        
 // 3. On soustrait de quoi laisser passer la plaque du fond
    translate([-25,-30,2])
        rotate([0,0,90])
        cube([6, 6, 3], center=true);  
        // 3. On soustrait de quoi laisser passer la plaque du fond
    translate([-25,30,2])
        rotate([0,0,90])
        cube([6, 6, 3], center=true);   
}

    }
}

/**
 * Poussoir
 * Note: Le paramètre offset a été retiré pour utiliser translate() lors de l'appel.
 */
module poussoir() {
    // Position relative du cylindre par rapport à la base du poussoir
    local_cyl_offset = [15, 0, 0]; 
    local_cyl2_offset = [-25, 0, 10];

    color("red") { 
        difference() {
            // Base du poussoir
            cube([80, 50, 3], center = true);
                
            translate(local_cyl2_offset + [-3, 0, 0])
            rotate([0, 90, 0])
            cylinder(h=30, d=7, center=true);

            // Cylindre du poussoir
            translate(local_cyl_offset)
            cylinder(h = 10, d = 43, center = true);
        }
        
        difference() {
            translate([-38, 0, 7.5])
            cube([10, 50, 18], center=true);
            
            translate([-35, 0, 10])
            rotate([0, 90, 0])
            cylinder(h=20, d=4, center=true);
        }
    }
}

/**
 * Tige
 */
module tige() {
    local_cyl2_offset = [-35, 0, 10];

    color("yellow") {
        translate(local_cyl2_offset)
        rotate([0, 90, 0])
        cylinder(h=50, d=3, center=true);
    }
}

/**
 * Pièce de démo
 */
module piece() {
    color("green") {
        // Le translate hardcodé a été retiré
        cylinder(h=4, d=40);
    }
}


// ==========================================
// --- APPELS DES MODULES (RENDU) ---
// ==========================================

// 1. Création du tube principal
translate(pos_tube)
    tube(height = main_height);

// 3. Création du 2ème sas (Bas)
translate(pos_sas_bas)
    sas_piece(
        cube_pos = [10, 0, -10],
        hole_pos = [decalage_trou, 0, -15]
    );

// 4. Création du poussoir
translate(pos_poussoir)
    poussoir();

// 5. Création de la tige
translate(pos_tige)
    tige();

// 6. Création de la pièce de démo
translate(pos_piece_demo)
    piece();
