// Pick and place reelfeeder
// CC-BY-SA Erik de Bruijn
PI=3.14159265;

// tape
tape_w = 8.0;
tape_thickness = 0.9;
tape_pitch = 4.0;
tape_pad_w = 3.0;
tape_pad_h = 2.0;

// feeder gear = laser cut from 1 mm POM is most durable.
gear_num_spokes = 20;
gear_spike_w = 1.2; 
gear_spike_l = 1.0;
gear_thickness = 1;
gear_hole_dia = 2.85-0.2-0.05;//laser kerf = 0.2
gear_y_adjust = 1.8;

// feeder guide
guide_l = 38;
guide_spacing1 = 0.0;//-0.05; // negative if you want to file away material to tight tolerances
guide_spacing2 = 1.1;

// lever
level_knee_angle = 124;
lever_spring_angle = 126;
lever_hole_dia = gear_hole_dia+0.20;
lever_l = 15;
lever_w = 5;
lever_thickness = 3+tape_w;
lever_hub_dia = 6;
lever_pawl_thickness=gear_thickness+1;
lever_spring_width = 7;
lever_spring_thickness = 1.1;

// reel
reel_diameter = 88;

gear_dia = gear_num_spokes*tape_pitch/PI;
gear_x = 1+gear_thickness/2;
gear_y = gear_dia/2+tape_pitch/2+gear_y_adjust;
gear_z = -gear_dia/2+0.2;

$fn=25;

//rotate([0,0,sin($t*360)*40+20])
feeder_assembly(3);
//scale([-1,1,1]) 
//{
//rotate(90,[-1,0,0]) tape_guide();
//feeder_gear();
//projection(cut = true) translate([0,0,2]) rotate([0,90,0]) 
// feeder_gear();
//rotate(90,[0,1,0]) lever();
//}

module feeder_assembly(num_feeders)
{
  for(i=[0:num_feeders-1])
  {
    translate([i*15,0,0])
    {
     translate([0,-8-($t*2000 % 200)/200*tape_pitch,0])
     tape(16);
     feeder_gear();
     tape_guide();
     color([0.0,0.1,0.8,1.0] )
     lever();
     lever_stop();
    }
  }
}

module lever_stop()
{
  translate([tape_w,guide_l-20,-1.5]) cube([5,18,1.0]);
}

module lever()
{
  translate([gear_thickness+0.2,0,0])
  {
    difference()
    {
      union() {
        // upper arm
        translate([gear_x+gear_thickness,gear_y,gear_z]) rotate([($t*2000 % 200)/200*20,0,0]) 
        {
          translate([-2/2+tape_w,-lever_w/2,0]) cube([lever_thickness-tape_w,lever_w,gear_dia/2+lever_l]);
          translate([-2/2+tape_w-4,-lever_w/2,gear_dia/2+lever_l-5]) cube([lever_thickness-tape_w+4,lever_w,5]);
        }

        // lower arm
        translate([gear_x+gear_thickness,gear_y,gear_z]) 
        rotate([level_knee_angle+($t*2000 % 200)/200*20,0,0])
        {
          translate([-2/2,-3/2,0]) cube([lever_thickness,3,gear_dia/2+3]);
          // ratchet pawl
          intersection()
          {
          translate([-gear_thickness-5,0,gear_dia/2]) rotate([15,0,0]) translate([0,-5,0]) cube([10,8,4]);
          difference()
          {
            translate([-gear_thickness-1.1,3,2]) rotate ([0,90,0]) cylinder(r=gear_dia/2+1.5,h=lever_pawl_thickness);
            translate([-gear_thickness-1.11,3,2]) rotate ([0,90,0]) cylinder(r=gear_dia/2,h=lever_pawl_thickness*2);
            
          }
          }
          // spring
          rotate([lever_spring_angle+79,0,0]) 
            translate([lever_thickness-lever_spring_width-1,-lever_spring_thickness/2+2,0]) {
            cube([lever_spring_width,lever_spring_thickness*1.5,8]);
		translate([0,0,8]) rotate([-39,0,0])
		{
		 cube([lever_spring_width,lever_spring_thickness,8]);

            translate([0,0,8]) rotate([-35,0,0]) 
		{
		cube([lever_spring_width,lever_spring_thickness,5]);
		translate([-3,0.5,7]) rotate(90,[0,1,0]) 
		  difference()
		  {
		    cylinder(r=4.5/2,h=10);
		    translate([0,0,-1])cylinder(r=2.70/2,h=12);
		  }
		}
		}
          }
        }

        // hub
        translate([gear_x,gear_y,gear_z])
          rotate([0,90,0]) cylinder(r=lever_hub_dia/2,h=lever_thickness);
      }
      union() {
      // hub
      translate([gear_x-1,gear_y,gear_z])
        rotate([0,90,0]) cylinder(r=lever_hole_dia/2,h=lever_thickness+2);
      }

    }
  }
}

module tape_guide()
{
  union()
  {
    difference()
    {
      tape_guide_fork();
      // tapered tape input
      translate([0,guide_l-9,tape_thickness-4]) rotate([0,0,8]) cube([tape_w-2,8,tape_thickness+10]);
      translate([2,guide_l-9,tape_thickness-4]) rotate([0,0,-8]) cube([tape_w-2,8,tape_thickness+10]);
      // cutout for side spring (output side)
      translate([tape_w-1,-2.0,-3]) cube([2,10,7]);
            
    }
    difference()
    {
      union()
      {
        //cover
        translate([-2,15,tape_thickness+0.6]) cube([tape_w+4,guide_l-26.8,1]);
        // top tape taper
        translate([-2,guide_l-12,tape_thickness+0.6]) rotate([5,0,0]) cube([tape_w+1,10,1]);
        // bottom taper
        translate([-2,guide_l-10,-1.5]) rotate([-5,0,0]) cube([tape_w+1,7.9,1]);
      }
      // cutout for side spring (input side)
      translate([tape_w-1,guide_l-12.0,-6]) cube([2,10,10]);
    }
    // top 'spring'
    translate([-1.3+tape_w/2,8,tape_thickness-0.4]) rotate([7,0,0]) cube([tape_w-4,8,1]);
    // side spring (output side)
    intersection() {
      translate([tape_w-0.7,0,-1.5]) cube([2.8,7,4]);
      translate([tape_w-0.7,0,-1.5]) rotate([0,0,-15]) cube([4,7,4]);
    }
    translate([tape_w-0.7,-2.0,-1.5]) cube([2,2,4]);

    // side spring (input side)
    intersection() {
      translate([tape_w-0.7,guide_l-9,-1.5]) cube([2.8,7,4]);
      translate([tape_w-0.7,guide_l-9,-1.5]) rotate([0,0,15]) translate([1.7,0,0]) cube([4,7,4]);
    }
    translate([tape_w-0.7,-2.0,-1.5]) cube([2,2,4]);
    
    // bottom bolt mount
      translate([-0.01,guide_l-9,-gear_dia-1.5]) difference() 
      {
        cube([7,7,2.3]);
        translate([4.5,3.5,-3]) cylinder(r=3.1/2,h=10);
        translate([6.0,3.5,-3]) cylinder(r=3.1/2,h=10);
      }
    }
}

module tape_guide_fork()
{
  difference()
  {
  translate([-2,-2,-1.5]) 
   union () {
     // flat part
     cube([tape_w+4.5,guide_l,4]);
     // gear holder
     translate([0,0,-gear_dia]) cube([2.8,guide_l,gear_dia]);
     // gear holder 2
     //translate([4+gear_thickness,0,-12]) cube([3.0,guide_l,gear_dia]);
   }

  // tape
  cube([tape_w,num_pads*tape_pitch,tape_h+0.5]);
  translate([-guide_spacing1/2,-5,-0.1]) cube([tape_w+guide_spacing2,80,10]);

  // gear cutout
  translate([gear_x,gear_y,-gear_dia/2+0.5]) 
    rotate([0,90,0]) 
      cylinder(r=gear_dia/2+2,h=gear_thickness+2);

  // top mounting holes/slots
  translate([-10,0,-4])
  {
    rotate([0,90,0]) cylinder(r=3.1/2,h=30);
    translate([10,-3.2/2,0]) cube([13.1,3.1,3.1],center=true);
  }
  translate([-10,guide_l-4.5,-4])
  {
    rotate([0,90,0]) cylinder(r=3.1/2,h=30);
    translate([10,3.2/2,0])  cube([13.1,3.1,3.1],center=true);    
  }
  // middle mounting holes
  translate([-10,0,-14])
  {
    rotate([0,90,0]) cylinder(r=3.1/2,h=30);
    translate([10,-3.2/2,0]) cube([13.1,3.1,3.1],center=true);
  }
  translate([-10,guide_l-4.5,-14])
  {
    rotate([0,90,0]) cylinder(r=3.1/2,h=30);
    translate([10,3.2/2,0])  cube([13.1,3.1,3.1],center=true);    
  }
  // lower mounting holes
  translate([-10,0,-gear_dia+3])
  {
    rotate([0,90,0]) cylinder(r=3.1/2,h=30);
    translate([10,-3.2/2,0]) cube([13.1,3.1,3.1],center=true);
  }
  translate([-10,guide_l-4.5,-gear_dia+3])
  {
    rotate([0,90,0]) cylinder(r=3.1/2,h=30);
    translate([10,3.2/2,0])  cube([13.1,3.1,3.1],center=true);    
  }

  // hole for axle
  translate([gear_x-5,gear_y,gear_z])
    rotate([0,90,0]) cylinder(r=2.75/2,h=10);
  }
}

module feeder_gear()
{
  // circumference = 2*PI*r
  // r = circumference/2/PI
echo (gear_dia);
color([0.1,0.1,0.1,0.9])
    translate([gear_x,gear_y,gear_z])
    {
rotate([360/gear_num_spokes*($t*2000 % 200)/200,0,0])
    rotate([0,90,0]) 
    difference()
    {
      union()
      {
        cylinder(r=gear_dia/2,h=1);
      for(i=[0:gear_num_spokes])
      {
        rotate([360/gear_num_spokes*i+90,-90,0])
          translate([0,0,-0.5*gear_spike_w])
            intersection()
            {
              translate([0,0,-1.7]) rotate([7,0,0]) 
                cube([gear_thickness,gear_dia/2+gear_spike_l,gear_spike_w*2]);
              translate([0,0,-1.4]) 
                rotate([12,0,0]) 
                  cube([gear_thickness,gear_dia/2+gear_spike_l,gear_spike_w*2]);
            }
        }//for
        } // union
        translate([0,0,-5]) cylinder(r=gear_hole_dia/2,h=10);
        for(j=[0:2])
        rotate([0,0,360/3*j]) translate([0,7,-5]) cylinder(r=gear_hole_dia/2+1,h=10);
      }// diff
    }// translate
}

module tape(num_pads)
{
 difference() {
   color([0.1,0.1,0.1,0.2])
   cube([tape_w,num_pads*tape_pitch,1.43]);
   for(i=[0:num_pads-1])
   {
     translate([2,tape_pitch*i,-1]) cylinder(h=3,r=1.67/2,$fn=20);
     translate([3.5,tape_pitch*(i+0.25),0.2]) cube([tape_pad_w,tape_pad_h,2]);

   }
 }
}