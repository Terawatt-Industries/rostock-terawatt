use <functions.scad>;

cutout = 13;
inset = 6;
parallel_joint_width = 90;

translate([0, 0, 4]) platform(cutout, inset, parallel_joint_width);

module platform(c, i, pjw) {
  difference() {
    union() {
      for (a = [0:120:359]) {
        rotate([0, 0, a]) {
          translate([0, -55, 0]) parallel_joints(pjw, c, 25, 0, 1, 35);
          // open triangle holes.
          translate([0, 21, 0]) cylinder(r=5, h=8, center=true);
          // Holder for adjustable bottom endstops.
          translate([0, 45, 0]) cylinder(r=5, h=8, center=true);
        }
      }
      cylinder(r=30, h=8, center=true);
    }
    cylinder(r=20, h=20, center=true);
    for (a = [0:60:359]) {
      rotate([0, 0, a]) {
        translate([0, -25, 0])
          cylinder(r=2.2, h=9, center=true, $fn=12);
        // Screw holes for adjustable bottom endstops.
        translate([0, 45, 0])
          cylinder(r=1.5, h=9, center=true, $fn=12);
      }
    }
  }
}
