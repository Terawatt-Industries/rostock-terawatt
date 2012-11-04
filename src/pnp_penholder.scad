offset = 44;
wall = 3.5;

diameter1 = 16.1;	// pen bottom hole
diameter2 = 15;	// motor mount
diameter3 = 16.1;	// 610zz diameter
pen_mount_height = 45;
motor_mount_base_height = 20;
motor_mount_height = 5;
motor_mount_base_width = 38;
motor_mount_base_length = 40;

module penholder() {
  difference() {
    union() {
		// main arm
      translate([0, offset / 2, 6])
        cube([2 * wall + 2, offset, 20], center=true);
		// counterweight arm
      translate([0, -offset / 2, 20])
        cube([2 * wall + 2, offset / 2, 10], center=true);
      translate([0, -offset / 2 - offset / 4, 20])
        cube([20, 30, 10], center=true);
		// arm support material
		union() {
		difference() {
			translate([-10, -offset - 4, -4])
			cube([20, offset + 5, 19.9], center=false);
			for (a = [-2, 1, 4, 7, 10, 13, 16, 19]) {
				translate([0, -offset / 2, a])
					cube([20 + 1, offset + 6, 2], center=true);
			}
		}
		for (y = [-diameter3, -offset / 2, -offset / 1.5, -offset / 1.2, -offset, -offset - 4]) {
			translate([-10, y, -4]) cube([20, 2, 19.9], center=false);
		}
		}
		// pen holder shell
      translate([0, 0, 18.5 - pen_mount_height / 2])
        cylinder(r1=diameter1/2 + wall, r2=diameter1 + wall, h = pen_mount_height, center = false);
		// motor mount
      translate([0, offset, -4])
        cylinder(r=diameter2/2 + wall, r2=diameter2 + 2 * wall, h = motor_mount_base_height, center = false);
      translate([0, offset, motor_mount_base_height - 4])
		cube([motor_mount_base_width, motor_mount_base_length, motor_mount_height], center=true);
		// feet
      intersection() {
        union() {
          cylinder(r=29, h=8, center=true);
          translate([0, 0, 9])
            cylinder(r1=25, r2=3, h=14, center=true);
        }
        union() {
          rotate([0, 0, 30]) cube([100, 10, 100], center=true);
          rotate([0, 0, -30]) cube([100, 10, 100], center=true);
        }
      }
    }
	// pen holder hole
    translate([0, 0, 0]) {
      cylinder(r1 = diameter1/2, r2=diameter1 / 2, h=100, center=true, $fn=24);
      translate([0, 10, 0]) cube([2, 20, 100], center=true);
    }
	// 610zz cutout
    translate([0, 0, 60]) {
      cylinder(r1 = diameter3 / 2, r2=diameter3 / 2, h=100, center=true, $fn=24);
      translate([0, 10, 0]) cube([2, 20, 100], center=true);
    }
	// hole under motor
    translate([0, offset, 0]) {
      cylinder(r=diameter2/2, r2=diameter2 / 2, h=100, center=true, $fn=24);
      translate([0, -10, 0]) cube([2, 20, 100], center=true);
    }
	// platform M4 mount holes
    for (a = [-30, 30, -150, 150]) {
      rotate([0, 0, a]) {
        translate([25, 0, 0]) {
          cylinder(r=2.2, h=10, center=true, $fn=12);
          translate([3, 0, 0]) cube([6, 1, 10], center=true);
        }
      }
    }
	// counterweight M8
      translate([0, -offset / 2 - offset / 4 - 8, 6])
          cylinder(r=4.1, h=50, center=true, $fn=12);
	// counterweight M5
      translate([0, -offset / 2 - offset / 4 + 8, 6])
          cylinder(r=2.6, h=50, center=true, $fn=12);
	// counterweight M3
      translate([0, -offset / 2 - offset / 4, 6])
          cylinder(r=1.6, h=50, center=true, $fn=12);
  }
}

module motor_mount_cap() {
	difference() {
		union() {
			translate([0, 0, 14.2]) cube([motor_mount_base_width, motor_mount_base_length, 5], center = true);
			// corner screw hole support
			for (a = [45, 135, 225, 315]) {
			rotate([0, 0, a]) {
			translate([-motor_mount_base_width / 2 * 1.414, 0, 0])
rotate([0, 0, 45])
			intersection() {
				translate([5, -5, 0]) cube([10, 10, 28], center = true);
				translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(r=10.1, h=50, center=true, $fn=24);
			}
			}
			}
		}
		translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(r=10.1, h=50, center=true, $fn=24);
	}
}

translate([0, 0, 4]) penholder();
color([0.9, 0.1, 0]) translate([0, offset, motor_mount_base_height + 16]) motor_mount_cap();

use <platform.scad>;
% translate([0, 0, -4]) platform(13, 10, 80);

use <nema11.scad>;
% translate([0, offset, motor_mount_base_height + motor_mount_height + 37]) rotate([90, 0, 0]) nema11(28.2);

// vacuum pen
% translate([0, 0, 25]) cylinder(r=4, h=100, center=true, $fn=24);

use <pulley.scad>;
% translate([0, 0, motor_mount_base_height + motor_mount_height + 35]) rotate([0, 0, 0]) pulley(10, 23, 10, 3, 2, 7, 3);

use <bearing.scad>;
% translate([0, 0, pen_mount_height + 4]) rotate([90, 0, 0]) bearing(8, 22, 7); // 608 skateboard ball bearing.
