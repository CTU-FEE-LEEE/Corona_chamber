
difference () {
    cube ([60,60,15], center=true);
    cube ([40,40,25], center=true);
    translate([0,0,0.38])
        cube([51,60,0.8], center=true);
    translate([0,0,7]) 
        cube([55,55,2], center=true) ;
   
    translate([0,0,2.4]) rotate ([0,90,0]) color(["red"]) cylinder (60,r=1, center=true, $fn=100);
    translate([0,10,2.4]) rotate ([0,90,0]) color(["red"]) cylinder (60,r=1, center=true, $fn=100);
    translate([0,-10,2.4]) rotate ([0,90,0]) color(["red"]) cylinder (60,r=1, center=true, $fn=100);
    };
