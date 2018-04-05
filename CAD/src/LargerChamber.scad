module ceramic() {
    color("Gainsboro") cube([111,111,1.2]); 
}

module netbase() {
    color("SandyBrown") cube([80,90,0.4]); 
}

module cut() {
    color("SandyBrown") cube([40,25,3]); 
}

module net() {
    difference()
    {
        netbase();
        translate([-10,-5,-1]) cut();
        translate([50,-5,-1]) cut();
    }    
}

module gnd() {
    color("DarkKhaki") cube([90,80,6]);     
}

module visible() {
    color("Red") cube([70,70,10]); 
}

module innerFrame() {
    union()
    {        
        translate([15.5,-5,1.2]) net();        
        ceramic();
        translate([10.5,10,-6])gnd();
    }    
}

// object with tolerances
module ceramic1() {    
    color("Gainsboro") cube([112.2,112.2,1.5]); // y trnsl 0.5
}

module netbase1() {    
    color("SandyBrown") cube([81,91,0.5]); // y trnsl 0.5
}


module gnd1() {
    color("DarkKhaki") cube([91,81,6.4]); // y trnsl 0.5
}

module visible1() {
    union(){
        color("Red") cube([70,60,10]);
        translate([-5,-5,7])
        color("Red") cube([80,70,10]);
    }
}

module innerFrame1() {
    union()
    {
        translate([-0.6,-0.5,0]) ceramic1();
        translate([15,-5.5,1.4]) netbase1();        
        translate([10,9.5,-6.2])gnd1();
        translate([20.5,20.5,1])visible1();
    }    
}

module  hole(){
    translate([-10,0,5])
    rotate ([0,90,0])
    color("Red")
    cylinder (130,d=3, $fn=100);
}

module box() {
    translate([-5.6,0,-6])
    color("Red") cube([122.2,122.2,15]); 
}

module objectBox() {
    difference()
    {
        box();
        innerFrame1();
        translate([0,35,0]) hole();
        translate([0,50,0]) hole();
        translate([0,65,0]) hole();
    }
}


objectBox();
innerFrame();

