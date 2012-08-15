h = 7;
r = h/2 / cos(30) + 1;
co = 13;		// carriage offset
mt = 4;		// mount thickness

module jaws() {
  difference() {
    union() {
      intersection () {
        rotate([90, 0, 0]) cylinder(r=5, h = co + mt, center=true, $fn=24);
        translate([-4, 0, 0]) cube([20, 24, h], center=true);
      }
      intersection() {
        translate([10, 0, 0]) cube([26, co + mt, h], center=true);
        translate([10, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])
          cylinder(r1=co, r2=r, h=26, center=true, $fn=6);
      }
    }
    translate([-3.5, 0, 0]) cube([10, 13, 10], center=true);
    translate([1.5, 0, 0]) rotate([0, 0, 30])
      cylinder(r=6.5, h=10, center=true, $fn=6);
    translate([2, 0, 4]) rotate([0, 45, 0])
      rotate([0, 0, 30]) cylinder(r=6.5, h=8, center=true, $fn=6);
    translate([2, 0, -4]) rotate([0, -45, 0])
      rotate([0, 0, 30]) cylinder(r=6.5, h=8, center=true, $fn=6);
    rotate([90, 0, 0]) cylinder(r=1.55, h=40, center=true, $fn=12);
    translate([19, 0, 0]) rotate([0, 90, 0])
      cylinder(r=2.8, h=20, center=true, $fn=12);
  }
}

translate([0, 0, h/2]) jaws();