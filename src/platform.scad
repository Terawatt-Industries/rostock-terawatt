use <functions.scad>;

cutout = 12.5;
inset = 6;
parallel_joint_width = 90;

translate([0, 0, 4]) platform();

module platform() {
  difference() {
    union() {
      for (a = [0:120:359]) {
        rotate([0, 0, a]) {
          translate([0, -33, 0]) parallel_joints(parallel_joint_width, cutout, 25, 0);
          // Close little triangle holes.
          translate([0, 31, 0]) cylinder(r=5, h=8, center=true);
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
