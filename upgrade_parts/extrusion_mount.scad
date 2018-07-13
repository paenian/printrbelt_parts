in = 25.4;

%extrusion();

extrusion_mount();

module extrusion_mount(length = in){
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