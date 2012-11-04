height = 10;
radius = h/2 / cos(30) + 1;
outer_circ = 16.9;		// attachment thickness
mnt_thickness = 4;		// mount thickness
nose_length = 26;		// adjust length of nose, not exact
hole_radius = 2.8;

module jaws(h, r, co, mt, nl, hr) {
  difference() {
    union() {
      intersection () {
        translate([-8, 0, 0]) rotate([90, 0, 0]) cylinder(r = co / 2 - mt / 2 + 5, h = co + mt + 80, center=true, $fn=24);
        translate([-4, 0, 0]) cube([40, 24, h], center=true);
      }
      intersection() {
        translate([5, 0, 0]) cube([nl, co + mt, h], center=true);
        translate([nl / 2, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])
          cylinder(r1=co, r2=r, h=nl, center=true, $fn=6);
      }
    } 
    translate([-11.5, 0, 0]) cube([h + 7, co, h + 3], center=true);
    translate([-3.5, 0, 0]) rotate([0, 0, 30])
      cylinder(r=co / 2 - 0.1, h=10, center=true, $fn=6);
    translate([0, 0, 8]) rotate([0, 45, 0])
      rotate([0, 0, 30]) cylinder(r=co / 2 - 0.1, h = co, center=true, $fn=6);
    translate([0, 0, -8]) rotate([0, -45, 0])
      rotate([0, 0, 30]) cylinder(r=co / 2 - 0.1, h = co, center=true, $fn=6);
    translate([-10, 0, 0]) rotate([90, 0, 0]) cylinder(r=1.55, h=40, center=true, $fn=12);
    translate([21, 0, 0]) rotate([0, 90, 0])
      cylinder(r=hr, h=20, center=true, $fn=12); 
  }
}

translate([0, 0, height / 2]) jaws(height, radius, outer_circ, mnt_thickness, nose_length, hole_radius);