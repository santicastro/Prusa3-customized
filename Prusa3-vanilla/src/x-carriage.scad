// PRUSA iteration3
// X carriage
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <bearing.scad>
include <../../configuration.scad>

module x_carriage_base(){
 // Small bearing holder
 translate([-33/2,0,0]) rotate([0,0,90]) horizontal_bearing_base(1);
 // Long bearing holder
 translate([-33/2,45,0]) rotate([0,0,90]) horizontal_bearing_base(2);
 // Base plate
 translate([-33,-11.5,0]) cube([33,68,7]);
 // Belt holder base
 translate([-33,20,0]) cube([33,16,17]);
}

module x_carriage_beltcut(){
 // Cut in the middle for belt
 translate([-2.25-16.5,19,7]) cube([4.5,13,15]);
 // Cut clearing space for the belt
 translate([-38,5,7]) cube([40,13,15]);
 // Belt slit
 translate([-66,21.5+10,6]) cube([67,1,15]);
 // Smooth entrance
 translate([-66,21.5+10,14]) rotate([45,0,0]) cube([67,15,15]);
 // Teeth cuts
 holder_tooth_width = belt_tooth_distance - belt_tooth_width;
 teeth_count = ((33-4.5)/2 - holder_tooth_width)/belt_tooth_distance;
 teeth_count_module = teeth_count % 1;
 position_tweak = belt_tooth_distance*(teeth_count_module)/2;
 loop_count = teeth_count-teeth_count_module+1;
 
 translate([-16.5, 21.5+8, 6])
 {
 holder_teeth(belt_tooth_distance, belt_tooth_width, position_tweak, loop_count);
 mirror([1, 0, 0]) holder_teeth(belt_tooth_distance, belt_tooth_width, position_tweak, loop_count);
 }
}

module holder_teeth(belt_tooth_distance, belt_tooth_width, position_tweak, loop_count) {
 cube([2-belt_tooth_width+position_tweak+belt_tooth_width, 3, 15]);
 for ( i = [0 : loop_count-1] ){
  translate([2-belt_tooth_width+position_tweak+i*belt_tooth_distance, 0, 0]) cube([belt_tooth_width, 3, 15]);
 }
 translate([2-belt_tooth_width+position_tweak+loop_count*belt_tooth_distance, 0, 0]) cube([belt_tooth_distance, 3, 15]);
}

module x_carriage_holes(){
 // Small bearing holder holes cutter
 translate([-33/2,0,0]) rotate([0,0,90]) horizontal_bearing_holes(1);
 // Long bearing holder holes cutter
 translate([-33/2,45,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Extruder mounting holes
  translate([-16.5+12,24,-1])cylinder(r=1.7, h=20, $fn=8);
  translate([-16.5+12,24,10])cylinder(r=3.1, h=20, $fn=6); 
  translate([-16.5-12,24,-1])cylinder(r=1.7, h=20, $fn=8);
  translate([-16.5-12,24,10])cylinder(r=3.1, h=20, $fn=6); 	
}

module x_carriage_fancy(){
 // Top right corner
 translate([13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom right corner
 translate([0,5,0]) translate([0,-11.5,-1]) rotate([0,0,-45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom ĺeft corner
 translate([-33,5,0]) translate([0,-11.5,-1]) rotate([0,0,-135]) translate([0,-15,0]) cube([30,30,20]);
 // Top left corner
 translate([-33-13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,135]) translate([0,-15,0]) cube([30,30,20]);	
}

// Final part
module x_carriage(){
 difference(){
  x_carriage_base();
  x_carriage_beltcut();
  x_carriage_holes();
  x_carriage_fancy();
 }
}

x_carriage();