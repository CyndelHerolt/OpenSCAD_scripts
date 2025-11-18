size = 100;
step = 11;
thickness = 1.5;

// Module pour créer la surface de Boy
module boy_surface() {
    for(u = [0:step:180], v = [0:step:360]) {
        x = size * cos(v) * sin(u);
        y = size * sin(v) * sin(u);
        z = size * cos(u);

        r = sqrt(x*x + y*y + z*z);
        theta = atan2(y,x);
        phi = atan2(z,sqrt(x*x+y*y));

        f = (1/(sqrt(3))) * (sin(phi)*cos(theta) + sin(phi)*sin(theta) + cos(phi));

        translate([x,y,z])
        rotate([0,0,atan2(y,x)])
        cylinder(h=thickness, r=step/0.75, center=true, $fn=4);

        // Ajout du support central
        // Calcul du point central (approximation)
        center = [0, 0, 0]; // Point central approximatif

        // Création d'une branche de support
        color("red") {
            hull() {
                translate([x,y,z])
                    sphere(r=step/3); // Point de connexion sur le disque

                translate(center)
                    sphere(r=step/3); // Point central
            }
        }
    }
}

// Module pour créer la structure de support centrale
module central_support() {
    color("blue") {
        // Sphère centrale
        translate([0, 0, 0])
            sphere(r=step);

        // Branches principales (optionnel)
        for (i = [0:3]) {
            rotate([0, 0, i*90])
                cylinder(h=size/2, r1=step/2, r2=step, center=true, $fn=20);
        }
    }
}

// Affichage
rotate([90,0,0]) {
    boy_surface();
    central_support();
}
