module ceramic() {
    color("Gainsboro") cube([108,108,1]); 
}

module netbase() {
    color("SandyBrown") cube([80,90,1]); 
}

module cut() {
    color("SandyBrown") cube([40,15,3]); 
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
    color("DarkKhaki") cube([90,90,6]);     
}

module visible() {
    color("Red") cube([70,70,10]); 
}

module innerFrame() {
    union()
    {        
        translate([14,-5,1]) net();        
        ceramic();
        translate([9,0,-6])gnd();
    }    
}

// object with tolerances
module ceramic1() {    
    color("Gainsboro") cube([109,109,1.2]); // y trnsl 0.5
}

module netbase1() {    
    color("SandyBrown") cube([81,91,1.2]); // y trnsl 0.5
}


module gnd1() {
    color("DarkKhaki") cube([91,91,6.4]); // y trnsl 0.5
}

module visible1() {
    union(){
        color("Red") cube([70,70,10]);
        translate([-5,-5,7])
        color("Red") cube([80,80,10]);
    }
}

module innerFrame1() {
    union()
    {
        translate([-0.5,-0.5,0]) ceramic1();
        translate([13.5,-5.5,1]) netbase1();        
        translate([8.5,-0.5,-6.2])gnd1();
        translate([19,10.5,1])visible1();
    }    
}

module  hole(){
    translate([-10,0,5])
    rotate ([0,90,0])
    color("Red")
    cylinder (130,r=1, $fn=100);
}

module box() {
    translate([-5,0,-6])
    color("Red") cube([118,118,15]); 
}

module objectBox() {
    difference()
    {
        box();
        innerFrame1();
        translate([0,27.5,0]) hole();
        translate([0,45,0]) hole();
        translate([0,62.5,0]) hole();
    }
}


objectBox();
innerFrame();

