len = 16;
width = 11;
height = 11;
r = height / 2 - (height * 0.1);

module stumpy(l = 4, h = 8) {
  rotate([0, 90, 0]) rotate([0, 0, 30]) intersection() {
    cylinder(r = h / 2, h = l, center=true, $fn=6);
    sphere(r = l * cos(30), $fn=24);
  }
}

module middle() {
  difference() {
    union() {
      translate([-len / 4, 0, 0]) stumpy(len / 2, height);
      translate([len / 4, 0, 0]) stumpy(len / 2, height);
      rotate([0, 0, 90]) stumpy(width, height);
    }
	// thru holes
    rotate([90, 0, 0]) cylinder(r=1.5, h=30, center=true, $fn=12);
    rotate([0, 90, 0]) cylinder(r=1.5, h=30, center=true, $fn=12);
  }
}

translate([0, 0, h/2]) middle();
