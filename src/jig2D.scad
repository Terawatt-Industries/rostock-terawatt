// FIXME for 230mm arms we need to shorten this, I think 130/cos(30) = 150
radius = 175; // pretty close to 150/cos(30)
radius2 = radius/cos(30);
radius3 = radius2/cos(30)/2;
radius4 = radius3*0.37;
h=4;

module jig() {
  difference() {
    union() {
      difference() {
	intersection() {
	  rotate([0, 0, 30])
	    circle(r=radius3, center=true, $fn=3);
	  square([radius, 300], center=true);
	}
	intersection() {
	  rotate([0, 0, 30]) translate([0, 0, 1])
	    circle(r=radius3*0.93, center=true, $fn=3);
	  square([radius*0.95, 300], center=true);
	}
	for (a = [0:120:360]) {
	  intersection() {
	    rotate([0, 0, a+30]) translate([radius3*0.44, 0, 0])
	      circle(r=radius4, center=true, $fn=3);
	    square([radius*0.88, 300], center=true);
	  }
	}
	rotate([0, 0, -30])
	  circle(r=radius4, center=true, $fn=3);
      }
      translate([0, -25.5]) rotate([0, 0, 45])
	square([12, 12], center=true);
      translate([-30, radius3/2-8, 0])
	circle(r=8, center=true, $fn=12);
      translate([30, radius3/2-8, 0])
	circle(r=8, center=true, $fn=12);
      translate([0, -radius3, 0])
	circle(r=8, center=true, $fn=12);
      translate([0, 8-radius3, 0])
	square([16, 16], center=true);
    }
    translate([-30, radius3/2-8, 0])
      # circle(r=2.2, center=true, $fn=12);
    translate([30, radius3/2-8, 0])
      # circle(r=2.2, center=true, $fn=12);
    translate([0, -radius3, 0])
      # circle(r=2.2, center=true, $fn=12);
  }
}

translate([0, 0, h/2]) jig();
