$fn = 100;

Depth = 37;
TopWidth = 8;
BottomWidth = 45;
Thickness = 5;
Height = 22;

Radius = Height + Thickness;

// Felt pad to reduce friction.
UseFeltPad = true;
FPWidth = 8;
FPHeight = 1;

// Screw settings. You can also try to use other methods to mount hooks. However screws are recommended as they can handle more weright, than, for example doule-sided tape.
UseScrew = true;
SThreadsHeight = 16;
SThreadRadius = 3;
SHeadHeight = 2;
SHeadRadius = 6;

// Add smoothStep to your model.
UseSmooth = false;
SmoothRadius = 2;

module InitialModel()
{
    difference()
    {
        union()
        {
            // Rounded side creation.
            intersection()
            {
                translate([0, 0, -Thickness]){ cube(Depth + 2 * Thickness); }

                difference()
                {
                    cylinder(h = Depth, r = Radius);
                    translate([0,0,-Thickness])
                    {
                        cylinder(h = (Depth + 2 * Thickness), r = (Radius - Thickness));
                    }
                }
            }

            // Bottom Part
            translate([(Radius - BottomWidth), -Thickness, 0])
            { 
                cube([BottomWidth, Thickness, Depth]); 
            }
            
            // Top Part  
            translate([-TopWidth, (Radius - Thickness), 0])
            { 
                cube([TopWidth, Thickness, Depth]); 
            }   
        }
                 
        if(UseFeltPad)
        {
            translate([-TopWidth - 1, Radius - Thickness - 1, -1]){
                cube([FPWidth + 1, FPHeight + 1, Depth + 2]);
            }
        }
    }
}

module SmoothStep() 
{   
    difference()
    {      
        translate([SmoothRadius - TopWidth , Radius - SmoothRadius, 0])
        {
            difference()
            {
                cylinder(h = Depth, r = SmoothRadius*2);
                
                translate([0, 0, -Thickness])
                {
                    cylinder(h = Depth*2, r = SmoothRadius);
                }
            }     
        }
        
        //InitialModel();
    }
}

module ScrewHoles()
{
    translate([0, 0, -1])
    {
        cylinder(h = ((2 * Height) - (2 * Thickness)), r = SThreadRadius);
    }
         
    translate([0, 0, Thickness - SHeadHeight])
    {
        cylinder(h = ((2 * Height) - (2 * Thickness)), r = SHeadRadius);
    } 
}

difference()
{
        
    translate([0, Depth/2, Thickness])
    {   
        rotate([90,0,0])
        {
            InitialModel();
            //SmoothStep();
        }
    }
    
    if(UseScrew) { ScrewHoles(); }

}