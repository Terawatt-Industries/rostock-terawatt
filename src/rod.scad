use <jaws.scad>;

l = 210;
h = 10;
// jaws params
r = h/2 / cos(30);
outer_circ = 16.9;		// attachment thickness
mnt_thickness = 4;		// mount thickness
nose_length = 26;		// adjust length of nose, not exact
hole_radius = 4;

// Wipe nozzle after long travel moves.
module collar() {
  difference() {
    cube([6, 20, h], center=true);
    cube([2, 16, h+1], center=true);
    rotate([0, 90, 0]) rotate([0, 0, 30])
      cylinder(r=r + 1.75, h=7, center=true, $fn=6);
  }
}

// Small hollow cube.
module cubicle() {
  difference() {
    cube([12, 12, h], center=true);
    cube([8, 8, h+1], center=true);
  }
}

// Nozzle wipers.
module wipers() {
  translate([l/2 + 4.9, 0, 0]) cubicle();
  translate([-l/2 - 4.9, 0, 0]) cubicle();
  translate([l/2 - 25, 0, 0]) collar();
  translate([-l/2 + 30, 0, 0]) collar();
}

// Rod with two Y shaped rod ends.
module rod() {
  union() {
    translate([-l/2, 0, 0]) jaws(10, r, outer_circ, mnt_thickness, nose_length, hole_radius);
    translate([l/2, 0, 0]) rotate([0, 0, 180]) jaws(10, r, outer_circ, mnt_thickness, nose_length, hole_radius);
    rotate([0, 90, 0]) rotate([0, 0, 30])
      cylinder(r=r, h=l-25, center=true, $fn=6);
  }
}

rotate([0, 0, 45]) rod();

// If your nozzle doesn't ooze at all, you can comment the next line out.
rotate([0, 0, 45]) wipers();

// Print platform.
bed = 8*25.4; // 8x8 inches.
//% translate([0, 0, -h/2-1]) cube([bed, bed, 2], center=true);
