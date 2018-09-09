use <herringbone_gears.scad>
in = 25.4;

$fn=72;

//mirror([0,0,1]) roller_mount();
//rotate([180,0,0]) roller_gear_mount();
rotate([180,0,0]) motor_gear();


slop = .25;

roller_rad = 43/2-.2;
//bearing_rad = 22/2+.125;  //8mm shaft
bearing_rad = 26/2+.15;    //10mm shaft
bearing_inset = in*2;
bearing_thick = 7;

wall = 2;

small_teeth = 13;
motor_shaft_rad = 5/2+.2;
big_teeth = 43;
gear_thick = 13;
distance_between_axles = 40;
circular_pitch = 360*distance_between_axles/(small_teeth+big_teeth);

module motor_gear(){
    //rotate([180,0,0]) translate([distance_between_axles+1,0,-gear_thick]) rotate([0,0,0]) chamfered_herring_gear(height=gear_thick, number_of_teeth=small_teeth, circular_pitch=circular_pitch);
    
    translate([distance_between_axles+1,0,0]) gear1(gear1_teeth = small_teeth, circular_pitch=circular_pitch, gear_height=gear_thick);
}


module roller_gear_mount(){
    lift = 20;
    %motor_gear();
    radius = gear_radius(big_teeth, circular_pitch);
    outer_radius = gear_outer_radius(big_teeth, circular_pitch);
    
    gear_chamfer_radius = (outer_radius - radius) / tan(45);
    
    difference(){
        union(){
            translate([0,0,gear_thick-.05]) cylinder(r1=radius, r2=roller_rad+wall, h=lift-gear_thick+.1);
            
            translate([0,0,lift]) roller_mount();
            chamfered_herring_gear(height=gear_thick, number_of_teeth=big_teeth, circular_pitch=circular_pitch, teeth_twist=-1);
        }
        
        //hollow out a path upwards
        translate([0,0,-.1]) cylinder(r1=bearing_rad+wall*4, r2=bearing_rad+wall*2, h=lift+1);
    }
        
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