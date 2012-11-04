l_height = 100;
l_width = 100;
l_bracket_thickness = 3;
l_bracket_arm_width = 20;
holder_height = 20;
holder_width = 40;
holder_channel_width = 5;		// M5 screw
holder_channel_padding = 5;	// padding on left/right of channel

module l_bracket(h, w, t, aw) {
	linear_extrude(height = t, center = false, convexity = 0, twist = 0)
	difference() {
		square([h, w], center = false);
		translate([aw, aw, 0]) square([h - aw, w - aw], center = false);
	} 
}

module pcb_holder(h, w, cw, cp) {
	// base + rail cutout
	difference() {
		union() {
			cube([h, w, 10]);
			intersection() {
				translate([0, w - 10, 10]) cube([h, 10, 10]);
				translate([0, w, 10]) rotate([0, 90, 0]) cylinder(r=10, h=20, center=false);
			}
		}
		// channel
		translate([h / 2 - cw / 2, cp, -0.01]) cube([cw, w - 2 * cp, 20.02]);
		// channel counersink
		translate([h / 2 - cw * 1.6 / 2, cp, 10.02]) cube([cw * 1.6, w - 2 * cp, 20.02]);
	}
}

translate([0, 0, 0]) l_bracket(l_height, l_width, l_bracket_thickness, l_bracket_arm_width);

translate([l_bracket_arm_width + 5, l_bracket_arm_width + 5, 0]) pcb_holder(holder_height, holder_width, holder_channel_width, holder_channel_padding);

translate([l_bracket_arm_width + holder_height + 15, l_bracket_arm_width + 5, 0]) pcb_holder(holder_height, holder_width, holder_channel_width, holder_channel_padding);