parallel_joints(80, 13, 25, 0, true, 26);

module parallel_joints(width, cutout, offset, reinforced, bridge, length) {
  middle = 2*offset - width/2;
  difference() {
	// cutouts
    union() {
      intersection() {
        cube([width, 20, 8], center=true);
        rotate([0, 90, 0]) cylinder(r=5, h=width, center=true);
      }
		// bridge
      intersection() {
        translate([0, 18, 4]) rotate([45, 0, 0])
          cube([width, reinforced, reinforced], center=true);
        if (bridge) 
          translate([0, 0, 20]) cube([width, 35, 40], center=true);
      }
		// base behind cutouts
      translate([0, length / 2.5, 0]) cube([width, length, 8], center=true);
    }
	// screwhole
    rotate([0, 90, 0]) cylinder(r=1.55, h=width + 1, center=true, $fn=12);

    for (x = [-offset, offset]) {
      translate([x, 10.5, 0])
        cylinder(r=cutout / 1.7, h=100, center=true, $fn=24);
      translate([x, cutout / 1.7, 0])
        cube([cutout / 0.85, 5, 100], center=true);
      translate([x, 1.5, 0])
        cube([cutout, 15, 100], center=true);
      translate([x, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])
        cylinder(r=3.3, h=17, center=true, $fn=6);
    }
    translate([0, 2, 0]) cylinder(r=middle, h=100, center=true);
    translate([0, -8, 0]) cube([2*middle, 20, 100], center=true);
  }
}
