in = 25.4;

$fn=72;

roller_mount();

slop = .25;

roller_rad = 43/2;
bearing_rad = 22/2-.5;
bearing_inset = in;
bearing_thick = 8;

wall = 2;

module roller_mount(){
    difference(){
        union(){
            cylinder(r=roller_rad+wall, h=wall+.1);
            translate([0,0,wall]) cylinder(r1=roller_rad+wall, r2=roller_rad, h=wall+.1);
            translate([0,0,wall*2]) cylinder(r1=roller_rad, r2=roller_rad-slop, h=wall+.1);
            translate([0,0,wall*3]) cylinder(r1=roller_rad-slop, r2=bearing_rad+wall*3, h=wall*2+.1);
            translate([0,0,wall*5]) cylinder(r1=bearing_rad+wall*3, r2=bearing_rad+wall*2, h=bearing_inset-wall*4);
            
            translate([0,0,bearing_inset]) hull(){
                cylinder(r=roller_rad, h=wall, center=true);
                cylinder(r=roller_rad-slop, h=wall*2, center=true);
            }
        }
        
        //approach the bearing
        translate([0,0,-.1]) cylinder(r1=bearing_rad+wall*2, r2=bearing_rad+wall, h=bearing_inset-bearing_thick+.2);
        //mount the bearing
        translate([0,0,-.1]) cylinder(r=bearing_rad, h=bearing_inset+.1);
        //center through hole
        translate([0,0,-.1]) cylinder(r=bearing_rad-wall, h=bearing_inset+.2+wall);  
    }
}