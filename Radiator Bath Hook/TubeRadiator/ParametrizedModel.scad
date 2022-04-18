Thickness = 4;
TubeRadius = 14;
Depth = 25;

ArcInclinationDegree = 30;
HookInclinationDegree = 45;

LayingFaceHeight = 75;

UseSmoothing = false;

module Arc() {
    intersection(){
        difference() {
            cylinder(h = Depth, r=TubeRadius + Thickness);
            translate([0, 0, -1]){
                cylinder(h = Depth + 2, r=TubeRadius);
            }
        }
        
        translate([-Depth, 0, 0]){
            cube(2*Depth);
        } 
    }
}

module InitialModel() {
    union() {
        Arc();
        
        rotate([0, 0, ArcInclinationDegree]) {
            Arc();
        }
        
        translate([TubeRadius, -LayingFaceHeight, 0]) {
            cube([Thickness, LayingFaceHeight, Depth]);        
        }
        
        translate([TubeRadius, -LayingFaceHeight/1.5, 0]) {
            rotate([0, 0, -HookInclinationDegree]) {
                cube([Thickness, LayingFaceHeight/2.5, Depth]);        
            }
        }
        
    }
    
}

if(UseSmoothing) {
    $fn = 10;
    minkowski() {
        InitialModel();
        sphere(1);
    }
}
else
{
    $fn = 100;
    InitialModel();
}
