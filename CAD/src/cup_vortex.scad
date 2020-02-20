innerD = 16;
innerH = 10;

inputSecD = 26;
inputSecH = 10;

hemSecD = 30;
hemSecH = 5;

outerD = 39;
outerH = innerH+inputSecH+hemSecH;


holeTol = 0.3;
holeD = 3 + holeTol;


module hole() {
    cylinder(outerH, d=holeD, center=false , $fn=20);    
}

module holeVert() {
    translate([(inputSecD/2)-(holeD/2),0,0])
        hole();
}

module holeHoris() {
    translate([0,-(inputSecD/2)+(holeD/2),outerH-hemSecH-inputSecH/2])
        rotate ([0,-90,0])
            hole(); 
}

module holeTilt() {
    translate([0,-(inputSecD/2)+(holeD/2),outerH-hemSecH-inputSecH/2])
        rotate ([0,-90,0])
            rotate ([0,-60,0])
                hole(); 
}

module sealing() {
    translate([0, 0, outerH-(hemSecH/2)])
    rotate_extrude(convexity = 10, $fn = 100)
    translate([14.4, 0, 0])
    circle(r = 1.5, $fn = 24);
}

module body() {
    difference(){
        cylinder(outerH, d=outerD, center=false , $fn=100);
        translate([0,0,innerH+inputSecH])
            cylinder(hemSecH, d=hemSecD, center=false , $fn=90);
        translate([0,0,innerH])
            cylinder(inputSecH, d=inputSecD, center=false , $fn=80);
        translate([0,0,0])
            cylinder(innerH, d=innerD, center=false , $fn=60);
    }
}

module bodyWithVertHoles(number) {
    difference(){
        body();
        sealing();
        for (i=[0:360/number:360]) rotate(i) holeVert();
    }    
}

module bodyWithHorisHoles(number) {
    difference(){
        body();
        sealing();
        for (i=[0:360/number:360]) rotate(i) holeHoris();
    }    
}

module bodyWithTiltedHoles(number) {
    difference(){
        body();
        sealing();
        for (i=[0:360/number:360]) rotate(i) holeTilt();
    }    
}

//bodyWithVertHoles(4);
bodyWithHorisHoles(4);
//bodyWithTiltedHoles(4);


