in = 25.4;

$fn=72;

//mirror([0,0,1]) roller_mount();
roller_gear_mount();

slop = .25;

roller_rad = 43/2-.2;
//bearing_rad = 22/2+.125;  //8mm shaft
bearing_rad = 26/2+.15;    //10mm shaft
bearing_inset = in*2;
bearing_thick = 7;

wall = 2;

module roller_gear_mount(){
    roller_mount();
}

module roller_mount(){
    difference(){
        union(){
            cylinder(r=roller_rad+wall, h=wall+.1);
            translate([0,0,wall]) cylinder(r1=roller_rad+wall, r2=roller_rad, h=wall+.1);
            translate([0,0,wall*2]) cylinder(r1=roller_rad, r2=roller_rad-slop*2, h=wall*2+.1);
            translate([0,0,wall*4]) cylinder(r1=roller_rad-slop*2, r2=bearing_rad+wall*3, h=wall*2+.1);
            translate([0,0,wall*6]) cylinder(r1=bearing_rad+wall*3, r2=bearing_rad+wall*2, h=bearing_inset-wall*5);
            
            translate([0,0,bearing_inset-wall]) hull(){
                cylinder(r=roller_rad, h=wall*2, center=true);
                cylinder(r=roller_rad-slop*4, h=wall*4, center=true);
            }
        }
        
        //approach the bearing
        translate([0,0,-.1]) cylinder(r1=bearing_rad+wall*2, r2=bearing_rad+wall, h=bearing_inset-bearing_thick+.2);
        //mount the bearing
        translate([0,0,-.1]) cylinder(r2=bearing_rad, r1=bearing_rad+slop/2, h=bearing_inset+.1);
        //center through hole
        translate([0,0,-.1]) cylinder(r=bearing_rad-wall, h=bearing_inset+.2+wall);  
    }
}