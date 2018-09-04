in = 25.4;

//%extrusion();

$fn=72;

//translate([25,0,0]) mirror([0,0,1])
//rambo_mount();

//this is for the pi... it has less clearance around its holes, but otherwise identical
mirror([0,0,1]) rambo_mount(nub_rad = 4, length = in/2);

//rotate([0,90,0]) 8mm_mount();

//spring_mount();

rod_rad = 4.25;
screw_rad = 1.8;
wall = 3;

$fn=36;

module 8mm_mount(){
    screw_sep = 15;
    difference(){
        union(){
            //rod mount
            hull() {
                translate([0,0,rod_rad]) rotate([90,0,0]) {
                    cylinder(r=rod_rad+wall, h=in-wall, center=true);
                    cylinder(r=rod_rad+wall/2, h=in, center=true);
                }
                
                translate([0,0,-rod_rad/2]) rotate([0,90,0]) {
                    cylinder(r=rod_rad+wall, h=screw_sep+wall*2.75, center=true);
                }
            }
            
            //screwholes
            hull(){
                for(i=[0,1]) mirror([i,0,0]) translate([screw_sep/2,0,0]){
                    cylinder(r=screw_rad+wall, h=wall*3-1);
                    cylinder(r=screw_rad+wall-.5, h=wall*3);
                }
                for(i=[0,1]) mirror([0,i,0]) translate([0,screw_sep/2,0]){
                    cylinder(r=screw_rad+wall, h=wall);
                }
            }
        }
        
        translate([0,0,-in/2]) rotate([0,90,0]) extrusion(slop = 1);
        
        //screwholes
        for(i=[0,1]) mirror([i,0,0]) translate([screw_sep/2,0,wall*2.75]){
            cylinder(r=screw_rad*2, h=wall*2, $fn=36);
            cylinder(r1=screw_rad-.375, r2=screw_rad-.125, h=in, center=true);
        }
        
        //rod
        translate([0,0,rod_rad+.5]) rotate([90,0,0]) rotate([0,0,180]) cap_cylinder(r=rod_rad, h=in+1, center=true);
        
        //smooth the top and bottom
        for(i=[0,1]) mirror([i,0,0]) translate([50+screw_sep/2+wall*2.75/2,0,0]) cube([100,100,100], center=true);
    }
}


slot_width = in*9/16;

module spring_mount(height=7){
    rotate([90,0,0]) difference(){
        union(){
            intersection(){
                rotate([90,0,0]) hull() {
                    cylinder(r=slot_width/2,h=height/2+in/2);
                    cylinder(r=slot_width*.333,h=height+in/2);
                }
                translate([0,0,-25]) rotate([0,0,-135]) cube([50,50,50]);
                translate([-25,-5,-25]) rotate([0,0,-90]) cube([50,50,50]);
            }
        }
        extrusion(slop = 1);
        rotate([90,0,0]) cylinder(r1=screw_rad-.375, r2=screw_rad-.125, h=height+in/2+.1); 
    }
}

module rambo_mount(angle = 90-35, lift = in*2, length = in*7/8, nub_rad = 6){
    slot_width = in*9/16;
    wall = 4;
    
    screw_rad = 1.25;
    difference(){
        union(){
            //slot tabs
            intersection(){
                union(){
                    translate([in/2,0,0]) cube([in, slot_width, length], center=true);
                    rotate([0,0,90]) translate([in/2,0,0]) cube([in, slot_width, length], center=true);
                }
                rotate([0,0,45]) translate([in/2,0,0]) cube([in, in, length], center=true);
            }
            
            //board rest
            translate([0,lift,0]) rotate([0,0,angle]) translate([0,-in*1/2,0]) cube([wall, length, length], center=true);
            
            //board nub
            translate([0,lift,0]) rotate([0,0,angle]) translate([wall/2,-in*1/2,-length/2+nub_rad-1]) {
                rotate([0,90,0]) cylinder(r=nub_rad, h=wall, center=true);
            }
            
            //join the board rest and the nub
            difference(){
                hull(){
                    translate([0,lift,0]) rotate([0,0,angle]) translate([0,-in*1/2,0]) cube([wall, length, length], center=true);
                    rotate([0,0,45]) translate([in/2,0,0]) cube([in, in, length], center=true);
                }
                hull() extrusion(slop = 1);
            }
        }
        extrusion(slop = .75);
        
        cylinder(r=5, h=50, center=true);
        
        //screwhole
        translate([0,lift,0]) rotate([0,0,angle]) translate([wall,-in*1/2,-length/2+nub_rad-1]) {
            rotate([0,90,0]) cylinder(r=screw_rad, h=wall*5, center=true);
        }
        
        //flatten the bottom
        translate([0,0,-50-length/2]) cube([100,100,100], center=true);
        
        //flatten the back
        translate([50+in*3/4,0,0]) cube([100,100,100], center=true);
    }
}

module extrusion_lug(length = in){
    slot_width = in*9/16;
    difference(){
        union(){
            hull(){
                //slot tab
                intersection(){
                    translate([in/2,0,0]) cube([in*3/4, slot_width, length], center=true);
                    translate([in/2*sqrt(2),0,0]) rotate([0,0,45]) cube([in, in, length], center=true);
                }
            }
        }
        extrusion(slop = .25);
    }
}


module extrusion(length = in*3, slop = .1, $fn=16){
    center_cube = .356*in+slop;
    inner_wall = .087*in+slop;
    slot = .256*in-slop;
    difference(){
        union(){
            //center cube
            cube([center_cube, center_cube, length], center=true);
            
            //four corners
            for(i=[0:90:359]) rotate([0,0,i]) {
                //inner walls
                hull(){
                    translate([in/2-inner_wall/2+slop/2,in/2-inner_wall/2+slop/2,0]) cylinder(r=inner_wall/2, h=length, center=true);
                    cylinder(r=inner_wall/2, h=length, center=true);
                }
                
                //corners
                hull(){
                    translate([in/2-inner_wall/2+slop/2,in/2-inner_wall/2+slop/2,0]) cylinder(r=inner_wall/2, h=length, center=true);
                    translate([in/2-inner_wall/2+slop/2,slot/2+inner_wall/2,0]) cylinder(r=inner_wall/2, h=length, center=true);
                }
                hull(){
                    translate([in/2-inner_wall/2+slop/2,in/2-inner_wall/2+slop/2,0]) cylinder(r=inner_wall/2, h=length, center=true);
                    translate([slot/2+inner_wall/2,in/2-inner_wall/2+slop/2,0]) cylinder(r=inner_wall/2, h=length, center=true);
                }
            }
        }
        
        //center hole
        cylinder(r=.205*in/2, h=length+.1, center=true);
    }
}

//A cylinder with a flat on it - used for printing overhangs, mainly.
//
//When printing an axle, put the flat spot downwards - it'll make the bottom much cleaner.
//When printing an axle hole, put the flat spot upwards - it'll make the ceiling cleaner.
module cap_cylinder(r = 3, h=5, center=true, outside=true, r_slop=0){
    difference(){
        hull(){
            cylinder(r=r-r_slop, h=h, center=center);
        
            if(outside == true){
                intersection(){
                    translate([r/2,0,0]) cube([r,r,h], center=center);
                    cylinder(r=(r-r_slop)/cos(180/4), h=h, center=center, $fn=4);
                }
            }
        }
        
        //this makes it into a D-shaft, basically.
        if(outside == false){
            translate([r,0,0]) cube([r/6,r,h+1], center=center);
        }
    }
}