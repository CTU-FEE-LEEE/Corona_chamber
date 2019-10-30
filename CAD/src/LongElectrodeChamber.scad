cdXtol = 1.2; //ceramic dimension X tolerance
cdYtol = 0.6; //ceramic dimension Y tolerance
cdZtol = 0.3; //ceramic dimension Z tolerance
cdX = 51+cdXtol; //ceramic dimension X
cdY = 51+cdYtol; //ceramic dimension Y
cdZ = 1.2+cdZtol; //ceramic dimension Z

ndXtol = 1.2; //net base dimension X tolerance
ndYtol = 0.6; //net base dimension Y tolerance
ndZtol = 0.3; //net base dimension Z tolerance
ndX = 36+ndXtol; //net base dimension X
ndY = 40+ndYtol; //net base dimension Y
ndZ = 0.4+ndZtol; //net base dimension Z

gdXtol = 0;// ground dimension Z tolerance
gdZ = 6+gdXtol; //ground dimension Z

uct = 10; //upper chamber thickness
sct = 10; //side chamber thickness

pdZ = 2; //plexi dimension Z

module ceramic() {
    color("Gainsboro") cube([cdX,cdY,cdZ], center=true); 
}

module netbase() {
    translate([0,0,cdZ/2+ndZ/2])
    color("SandyBrown") cube([ndX,ndY,ndZ], center=true); 
}

module gnd() {
    translate([0,0,-cdZ/2-gdZ/2])
    color("DarkKhaki") cube([(cdX+ndX)/2,(cdY+ndY)/2,gdZ], center=true);     
}

module visible() {
    translate([0,0,cdZ/2+ndZ+uct/2])
    color("Red") cube([ndX*0.8,ndY*0.8,uct], center=true); 
}

module plexi() {
    translate([0,0,cdZ/2+ndZ+uct-pdZ/2])
    color("Red") cube([ndX,ndY,pdZ], center=true); 
}
module box() {
    translate([0,sct/2,-cdZ/2-gdZ+(cdZ+ndZ+gdZ+uct)/2])
    color("Green") cube([cdX+2*sct,cdY+sct,cdZ+ndZ+gdZ+uct], center=true); 
}

module prism(l, w, h){
       rotate([90,0,90])translate([-l/2,-w/2,-h/2]) polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [3*l/8,0,h], [5*l/8,0,h],
    [5*l/8,w,h], [3*l/8,w,h]],
               faces=[[0,1,2,3], [4,7,6,5], [0,3,7,4], [2,6,7,3], [1,5,6,2], [0,4,5,1]] 
               );
}

module prismCut() {    
    union(){
        translate([(cdX+2*sct-ndY*0.8)/8+ndX*0.4,0,cdZ/2+ndZ+(uct-pdZ)/2])
        prism(ndY*0.64,(uct-pdZ)/2,(cdX+2*sct-ndY*0.8)/4);
        
        mirror([1,0,0])
        translate([(cdX+2*sct-ndY*0.8)/8+ndX*0.4,0,cdZ/2+ndZ+(uct-pdZ)/2])
        prism(ndY*0.64,(uct-pdZ)/2,(cdX+2*sct-ndY*0.8)/4);
        
        translate([0,0,cdZ/2+ndZ+(uct-pdZ)/2])
        rotate([0,90,0])
        cylinder(  cdX+2*sct, d=(uct-pdZ)/2, center=true, $fn=20);
        }
    
}

module holes() {
    translate([0,ndY*0.8/4,cdZ/2+ndZ+(uct-pdZ)/2])
    rotate([0,90,0])
    cylinder(  cdX+2*sct, d=(uct-pdZ)/2, center=true, $fn=20);
    
    translate([0,0,cdZ/2+ndZ+(uct-pdZ)/2])
    rotate([0,90,0])
    cylinder(  cdX+2*sct, d=(uct-pdZ)/2, center=true, $fn=20);
    
    translate([0,-ndY*0.8/4,cdZ/2+ndZ+(uct-pdZ)/2])
    rotate([0,90,0])
    cylinder(  cdX+2*sct, d=(uct-pdZ)/2, center=true, $fn=20);
    
}
module frame() {
    difference(){
        box();
        ceramic();        
        netbase();
        translate([0,-ndY,0]) netbase();
        gnd();
        visible();
        plexi();
        //uncomment one of those
        prismCut();
        //holes();        
        }    
    }

frame();
    

//ceramic();
//netbase();
//gnd();
//visible();
//box();
