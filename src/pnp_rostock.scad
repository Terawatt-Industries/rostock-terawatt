use <belt.scad>;
use <bearing.scad>;
use <nema.scad>;
use <motor_end.scad>;
use <idler_end.scad>;
use <carriage.scad>;
use <platform.scad>;
use <rod.scad>;
use <plywood.scad>;
use <pnp_penholder.scad>;
use <pnp_pcbholder.scad>;

aluminum = [0.9, 0.9, 0.9];
steel = [0.8, 0.8, 0.9];

tower_radius = 175;
joint_radius = 108;
motor_radius = 175;
carriage_z = 300;
rod_length = 230;
z0 = 128;

module smooth_rod(z) {
	color(steel) cylinder(r=4, h=762);
	translate([0, 0, z]) lm8uu();
}

module tower(z) {
	translate([0, tower_radius, 0]) {
		translate([0, 0, 30]) rotate([0, 0, 180]) motor_end();
		translate([30, 0, 0]) smooth_rod(z0 + z - 14);
		translate([-30, 0, 0]) smooth_rod(z0 + z - 14);
		translate([0, 0, z0 + z - 14]) rotate([0, 180, 0]) carriage();
	}
	translate([0, motor_radius, 0]) {
		translate([0, 0, 30]) nema17(47);
		// Ball bearings for timing belt
		translate([7, 0, 750]) bearing(8, 22, 7);
		// Timing belt
		translate([-12, 0, 390]) rotate([0, 90, 0]) timing_belt(720);
		translate([12, 0, 390]) rotate([0, 90, 0]) timing_belt(720);
	}
}

module rod_pair(x, y, rotate_z, elevation, azimuth) {
	translate([x, y, z0 + 114]) {
		rotate([0, 0, rotate_z]) translate([25, 97, 0])
			rotate([0, 0, azimuth]) rotate([elevation, 0, 0])
			rotate([-azimuth, 0, 90]) rotate([90, 0, 0]) rod(rod_length);
		rotate([0, 0, rotate_z]) translate([-25, 97, 0])
			rotate([0, 0, azimuth]) rotate([elevation, 0, 0])
			rotate([-azimuth, 0, 90]) rotate([90, 0, 0]) rod(rod_length);
	}
}

translate([0, 0, -160]) {
	for (a = [0:120:359]) rotate([0, 0, a]) {
		tower(200);
		rod_pair(0, 0, a, elevation = 55, azimuth = -5);
	}

	translate([0, 0, 165]) rotate([0, 0, 60]) platform(13, 6, 90);
	translate([0, 0, 170]) rotate([0, 0, 180]) penholder();
	color([0.9, 0.1, 0]) translate([0, -40, 210]) motor_mount_cap();

	translate([0, 20, 60]) plywood(true);

	color([0, 0, 0.9]) {
		translate([100, -50, 65]) rotate([0, 0, 90]) l_bracket(100, 100, 3, 20);
		translate([10, 125, 65]) rotate([0, 0, 180]) pcb_holder(20, 40, 5, 5);
		translate([-75, 35, 65]) rotate([0, 0, -90]) pcb_holder(20, 40, 5, 5);
	}

	// heatbed
	color([0, 0.9, 0]) translate([25, 25, 65 + 5])
		cube([100, 100, 2], center=true);
}
