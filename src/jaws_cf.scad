use <jaws.scad>;

height = 10;
radius = h/2 / cos(30) + 1;
outer_circ = 16.9;		// attachment thickness
mnt_thickness = 4;		// mount thickness
nose_length = 26;		// adjust length of nose, not exact
hole_radius = 4;

translate([0, 0, height / 2]) jaws(height, radius, outer_circ, mnt_thickness, nose_length, hole_radius);