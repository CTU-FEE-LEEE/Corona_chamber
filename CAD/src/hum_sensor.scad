module sensor() {
    color("SandyBrown")
    cube([40,16,10], center = true);
}


module cavity() {
    color("SandyBrown")
    cube([40+10,16+20,10+5], center = true);
}

module shell() {
    color("SandyBrown")
    cube([40+10+20,16+20+12,10+5+12], center = true);
}

module pipe() {
    color("red")
    rotate([0,90,0])
    cylinder(h = 70, d = 5, center = true, $fn=30);
}

module boxDiff() {
    difference(){
        shell();
        cavity();
    }
}

module boxUni() {
    union(){
        boxDiff();
        translate([-1,-13,0]) cube([1,10,15], center = true);
        translate([-1,13,0]) cube([1,10,15], center = true);

    }
}

module botBox() {
    difference(){
        boxUni();
        translate([0,0,50/2]) cube([80,80,50], center = true);
    }
}

module topBox() {
    difference(){
        boxUni();
        translate([0,0,-50/2]) cube([80,80,50], center = true);
    }
}

module seal(d) {    
    union(){
        translate([0,(16+20+6)/2,0]) cube([(40+20)+d,d,d], center = true);
        translate([0,-(16+20+6)/2,0]) cube([(40+20)+d,d,d], center = true);
        translate([(40+20)/2,0,0]) cube([d,(16+20+6),d], center = true);
        translate([-(40+20)/2,0,0]) cube([d,(16+20+6),d], center = true);
        
    }
}

module botBoxSeal() {
    difference(){
        botBox();
        seal(2);
        translate([-20,0,0]) pipe(); //in
        translate([40,15,0]) pipe(); // out
        translate([20,0,0]) pipe(); // cable
        
    }
}

module topBoxSeal() {
    difference(){
        union(){
            topBox();
            seal(1.5);
            
        }
        translate([-20,0,0]) pipe(); //in
        translate([40,15,0]) pipe(); // out
        translate([20,0,0]) pipe(); // cable
    }
}
botBoxSeal();
topBoxSeal();


