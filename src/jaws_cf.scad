// these jaws should be printed individually for carbon fiber
h = 10;
r = h/2 / cos(30) + 1;
co = 16.9;		// attachment thickness
mt = 4;		// mount thickness

module jaws() {
  difference() {
    union() {
      intersection () {
        rotate([90, 0, 0]) cylinder(r = co / 2 - mt / 2, h = co + mt, center=true, $fn=24);
        translate([-4, 0, 0]) cube([20, 24, h], center=true);
      }
      intersection() {
        translate([10, 0, 0]) cube([26, co + mt, h], center=true);
        translate([10, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])
          cylinder(r1=co, r2=r, h=26, center=true, $fn=6);
      }
    } 
    translate([-4.5, 0, 0]) cube([h + 3, co, h + 3], center=true);
    translate([-1.5, 0, 0]) rotate([0, 0, 30])
      cylinder(r=co / 2 - 0.1, h=10, center=true, $fn=6);
    translate([0, 0, 4]) rotate([0, 45, 0])
      rotate([0, 0, 30]) cylinder(r=co / 2 - 0.1, h = co, center=true, $fn=6);
    translate([0, 0, -4]) rotate([0, -45, 0])
      rotate([0, 0, 30]) cylinder(r=co / 2 - 0.1, h = co, center=true, $fn=6);
    rotate([90, 0, 0]) cylinder(r=1.55, h=40, center=true, $fn=12);
    translate([21, 0, 0]) rotate([0, 90, 0])
      cylinder(r=4, h=20, center=true, $fn=12); 
  }
}

translate([0, 0, h/2]) jaws();