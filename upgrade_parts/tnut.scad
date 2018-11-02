width = 14; //11 for 20mm, 14 for 25mm
slot_width = 6;
depth = 7; //5.5 for 20mm, 7 for 25mm
slot_depth = 2;
screw_size = 3;
nut_size = 6.2;
nut_depth = 3;

repeat_x = 2;
repeat_y = 3;

// ratio for converting diameter to apothem
da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;
da12 = 1 / cos(180 / 12) / 2;

%square(100, center = true);
for(x = [-(repeat_x - 1) / 2:(repeat_x - 1) / 2]) for(y = [-(repeat_y - 1) / 2:(repeat_y - 1) / 2]) translate([x * (width + 3), y * (depth + 2), slot_width / 2]) render() 
difference() {
	linear_extrude(height = slot_width, center = true, convexity = 5) difference() {
		square([width * 1.5, depth], center = true);
	}
	rotate([0, -30, 0]) {
		linear_extrude(height = slot_width * 5, center = true, convexity = 5) difference() {
			for(side = [0, 1]) mirror([side, 0, 0]) cut();
		}
		rotate([-90, 0, 0]) difference() {
			rotate(90) rotate_extrude(convexity = 5, $fn = 36) cut();
			for(side = [0, 1]) for(a = [0, 1]) rotate(side * 180 + a * 30) translate([0, 0, -50]) cube(100);
		}
	}
	rotate([90, 0, 0]) cylinder(r = screw_size * da6, h = 100, center = true, $fn = 6);
	rotate([90, 0, 0]) translate([0, 0, depth / 2 - nut_depth]) cylinder(r = nut_size / 2, h = 100, $fn = 6);
}

module cut() {
	translate([width, -1]) square([width, depth + 2], center = true);
	translate([slot_width / 2, depth / 2 - slot_depth]) square([width, depth]);
	translate([slot_width / 2, -depth / 2]) rotate(-45) square([width, depth]);
}