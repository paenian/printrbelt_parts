in = 25.4;

$fn=72;

roller_mount();

roller_rad = 43/2-.5;
bearing_rad = 22/2-.25;
bearing_inset = in*2;

wall = 2;

module roller_mount(){
    difference(){
        union(){
            cylinder(r=roller_rad+wall, h=wall+.1);
            translate([0,0,wall]) cylinder(r1=roller_rad+wall, r2=roller_rad, h=wall+.1);
            cylinder(r=roller_rad, h=bearing_inset+wall*3);
        }
    }
}