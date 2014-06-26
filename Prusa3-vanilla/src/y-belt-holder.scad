// PRUSA iteration3
// Y belt holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <../../configuration.scad>

module belt_holder_base(){
 translate([-33-8.5,0,-1]) cube([33,15,16]); 
 translate([-33-8.5,11,-1]) cube([33,15,16]);
 translate([-50,22,-1]) cube([50,4,16]);	
}

module belt_holder_beltcut(){
 // Belt slit
 translate([-66,-0.5+10,belt_tooth_distance]) cube([67,1,15]);
 // Smooth insert cutout
 translate([-66,-0.5+10,12]) rotate([45,0,0]) cube([67,15,15]);
 
 holder_tooth_width = belt_tooth_distance - belt_tooth_width;
 teeth_count = ((33-4)/2 - holder_tooth_width)/belt_tooth_distance;
 teeth_count_module = teeth_count % 1;
 position_tweak = belt_tooth_distance*(teeth_count_module)/2;
 loop_count = teeth_count-teeth_count_module+1;
 // Individual teeth
 translate([-25, -0.5+8, 3])
 {
 holder_teeth(belt_tooth_distance, belt_tooth_width, position_tweak, loop_count);
 mirror([1, 0, 0]) holder_teeth(belt_tooth_distance, belt_tooth_width, position_tweak, loop_count);
 }
 // Middle opening
 translate([-2-25,-1,3]) cube([4,11,15]);	
}

module holder_teeth(belt_tooth_distance, belt_tooth_width, position_tweak, loop_count) {
 cube([2-belt_tooth_width+position_tweak+belt_tooth_width, 3, 15]);
 for ( i = [0 : loop_count-1] ){
  translate([2-belt_tooth_width+position_tweak+i*belt_tooth_distance, 0, 0]) cube([belt_tooth_width, 3, 15]);
 }
 translate([2-belt_tooth_width+position_tweak+loop_count*belt_tooth_distance, 0, 0]) cube([belt_tooth_distance, 3, 15]);
}

module belt_holder_holes(){
 translate([-4.5,0,7.5]) rotate([-90,0,0]) cylinder(h=30, r=1.7, $fn=10);
 translate([-45.5,0,7.5]) rotate([-90,0,0]) cylinder(h=30, r=1.7, $fn=10);
}

// Final part
module belt_holder(){
 difference(){
  belt_holder_base();
  belt_holder_beltcut();
  belt_holder_holes();
 }
}

belt_holder();