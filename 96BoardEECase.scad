/*
 *      96BoardsEECase.scad
 *
 *      Copyright (c) 2015 David Mandala <david.mandala@linaro.org
 *
 ***********************************************************************
 *
 * This scad file is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2 of the
 * License.
 * 
 * This OpenSCAD file is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***********************************************************************
 *
 * Note with smoothness > 20 - 100 it can take quite some time to render (F6) 
 * this is totally normal, about 2.5 minutes when smoothness == 50.  
 * It's not broken, just the quality takes time to realize
 *
 * OK, this is fun, the layout origion on this board is lower right corner,
 * which differes from the origion of the CE spec which is lower left corner
 * what is most inconvient is that the origion of OpenScad is lower left
 * corner so will have to invert all measurements on the X access
 * 
 */
use <MCAD/boxes.scad>

// Square edge case or rounded edge case?
rounded_case = true;
// Only the retangle of the case rounded (sides) or all angles (top, bottom, sides)  
only_retangle_rounded = true;

// How thick do you want your case walls(in mm)
// Be careful if you are setting rounded_case true, too thin of walls will leave holes
// Don't go to thick (much over 2.5) or you will have problems plugging in cables
case_wall_thickness = 2.5;

// Do you hvave a UART board and want room to install it in the case?
96Board_UART_Board_Installed = true;

// The UART board has a reset button, if you want to be able to press it true
expose_UART_Board_Button = true;

// expose the low/high speed connectors or not true/false question
expose_low_speed_connector = true;

// Do I want screw holes through the case? true/false question
screw_holes = true;
// Do I only want screw holes on the top of the case and no nuts on the botton, can thread screws into the standoffs --- Need to add code for this
screw_holes_top_only = false;
// Do I want nut holes on the bottom 
screw_terminator = true;

// For exporting .stl models, this will cut the model in 1/2 at the board top level.
// The board will fit into the bottom of the case cleanly and the top will sit on it
slice = false;
// top of the box or bottom 
slice_top = true;

// How round do you want holes  the higer it set to the longer it takes to render
smoothness = 50; //10-100

// For development only do you want to see the full case, the full diff model or the bare board model can help when adding new case type
// Set true for final case, false shows you the board and screw layout
case = true;
96BoardBlock = true;

// UART Board dimensions
uart_board_width = 41.00;
uart_board_length = 14.00;

uart_board_total_thickness = 12.00;
uart_board_top_surface = 14.2;

// Component dimensions
usb_host_length = 14.24;
usb_host_width = 14.25;
usb_host_thickness = 14; //Double stack USB connector

Ethernet_length = 14.24;
Ethernet_width = 14.25;
Ethernet_thickness = 14;

usb_otg_length = 8;
usb_otg_width = 5.68;
usb_otg_thickness = 2.65;

DC_pwr_length = 8.00;
DC_pwr_width = 12.50;
DC_pwr_thickness = 6;

// length and width flipped as comparied to the CE .scad file, orentation is
// differnet.
low_speed_connector_width = 44.00;
low_speed_connector_length = 7.0;
low_speed_connector_thickness = 4.6;

// Safe cutout distance.  Things that cut holes must extand past the edge it's cutting
cutout = .5;

// All board measurements and offsets set by 96Boards CE specification
// Do not change.
// All measurements are from lower left corner by microSD area.
board_width_reg = 120.00;
EE_spec_tolerance = 0.30;
board_length = 160.00;

// Have to invert all X coordinates
X_invert_value = board_length;


// Some of the USB connectors take up too much room so add extra room if needed
// The first version of the HiKey the USB connectors were 7.46 high
board_top_clearence_extra_tolerance = .46;   

board_front_edge = 0;
board_thickness = 1.6;
board_top_clearence = 20;
board_bottom_clearence = 6;
board_top_surface = board_bottom_clearence + board_thickness;
total_thickness = board_thickness + board_top_clearence + board_top_clearence_extra_tolerance + board_bottom_clearence;

// How wide is the board, normal or extended
bd_width = board_width_reg ;
// How tall is the board, normal or extended for the UART board?
bd_total_thickness = total_thickness;
bd_top_clearence = board_top_clearence+board_top_clearence_extra_tolerance+EE_spec_tolerance;
bd_bottom_clearence = board_bottom_clearence+EE_spec_tolerance;
board_back_edge = bd_width - 1;
// Sometimes the front edge connectors extend out beyond the board and have edges that catch on the bottom case.
// So we will sink the connector models this much into the case, and make them this much taller so we have a larger hole
// for the connectors allowing for any manufacturing tolerance issues.
front_connector_tolerance_z_drop = .4;

usb_host1_offset = X_invert_value - 130.00;
usb_otg2_offset = X_invert_value - 15.00;
Ethernet_offset = X_invert_value - 108.00;
DC_pwr_offset = X_invert_value - 13.00;
uart_board_connector_offset = X_invert_value - 4.00;


low_speed_board_clearance = 7;
low_speed_connector_center_offset = X_invert_value - 4.00;
low_speed_connector_pin_1_offset = 75.00;
low_speed_connector_left_offset = 77.00;

// uart lengths and widths flipped compared to CE scad file, orentation 
// is differnet.
uart_board_connector_width = 8;
uart_board_connector_length = 5.68;
uart_board_connector_thickness = 2.65;
uart_board_button_x_offset = uart_board_connector_offset - (uart_board_length/2)-2 ;
uart_board_button_center_y_offset = low_speed_connector_left_offset-low_speed_connector_width+5;
uart_board_button_width = 3.5;
uart_board_button_length = 3.5;

// All X offsets need to be inverted
mount_hole_1_x = X_invert_value-156.00;
mount_hole_1_y = 4.00;
mount_hole_2_x = X_invert_value-156.00;
mount_hole_2_y = 116.00;
mount_hole_3_x = X_invert_value-4.00;
mount_hole_3_y = 4.00;
mount_hole_4_x = X_invert_value-4.00;
mount_hole_4_y = 116.00;
// mezzanine board installed mounting holes
mount_hole_5_x = X_invert_value - 4.00;
mount_hole_5_y = 81.00;
mount_hole_6_x = X_invert_value - 35.50;
mount_hole_6_y = 4.00;
mount_hole_7_x = X_invert_value - 35.50;
mount_hole_7_y = 81.00;

// Need this to be oversized as holes are undsized
hole_size = 2.8;
hole_keepout = 5.0;

// Nuts and Screws to close the case
screw_head = 3.38;
screw_taper = true;
screw_taper_height = 1;
//screw_terminator for a nut how many sides
nut_type = 6;
// How tall is the nut
nut_hight = 1.65;
// from edge to edge
nut_size = 4.00;

// Modules
module slice_top(){
    translate([-1 * (cutout/2),-1 * (cutout/2),case_wall_thickness+board_top_surface-.001])
    cube([board_length+EE_spec_tolerance+(case_wall_thickness*2)+cutout, bd_width+EE_spec_tolerance+(case_wall_thickness*2)+cutout,case_wall_thickness+bd_top_clearence+cutout]);
}
module slice_bottom(){
    translate([-1 * (cutout/2),-1 * (cutout/2),-1 * cutout])
    // Something is slightly wrong here, had to add .001 to the size of the cube to cut everything as needed.  Rounding error?
    // Should not need the extra .001
    cube([board_length+EE_spec_tolerance+(case_wall_thickness*2)+cutout, bd_width+EE_spec_tolerance+(case_wall_thickness*2)+cutout,case_wall_thickness+board_top_surface+cutout+.001]);
}

module 96BoardStandoffMounts(){
    mount_cylinder(mount_hole_1_x+(EE_spec_tolerance/2),mount_hole_1_y+(EE_spec_tolerance/2),0, hole_keepout, false);
    mount_cylinder(mount_hole_2_x+(EE_spec_tolerance/2),mount_hole_2_y+(EE_spec_tolerance/2),0, hole_keepout, false);
    mount_cylinder(mount_hole_3_x+(EE_spec_tolerance/2),mount_hole_3_y+(EE_spec_tolerance/2),0, hole_keepout, false);
    mount_cylinder(mount_hole_4_x+(EE_spec_tolerance/2),mount_hole_4_y+(EE_spec_tolerance/2),0, hole_keepout, false);
//    if (96Board_UART_Board_Installed == true){
//        mount_cylinder(mount_hole_5_x+(EE_spec_tolerance/2),mount_hole_5_y+(EE_spec_tolerance/2),0, hole_keepout, false);
//        mount_cylinder(mount_hole_6_x+(EE_spec_tolerance/2),mount_hole_6_y+(EE_spec_tolerance/2),0, hole_keepout, false);
//    }
}
// The way this works is we stick out what we want to diff away
module face_penetration(face ,x_location, length, width , thickness, y_location, z_location, center){
    // Since this makes a model to diff from the external case have to add extra length to fully penatrate
    // the case
    // if y_location is 0 or exactly the full board width we are sticking things out the sides
    // 0 based so take 1 from bd_width
    if (face == "FR" || face == "BA" || face == "RI" || face == "LE" || face == "TO" || face == "BO"){
        if (face == "FR") {
            translate([(x_location+(EE_spec_tolerance/2))-(length/2),y_location == 0? -1*(y_location+(EE_spec_tolerance/2)+case_wall_thickness+cutout):((y_location+(EE_spec_tolerance/2))-width)+case_wall_thickness,z_location-front_connector_tolerance_z_drop])
            cube([length+EE_spec_tolerance,width+case_wall_thickness+cutout,thickness+front_connector_tolerance_z_drop],center );
        } else if (face == "BA" ){
            translate([(x_location+(EE_spec_tolerance/2))-(length/2),y_location == 0? -1*(y_location+(EE_spec_tolerance/2)+case_wall_thickness+cutout):((y_location+(EE_spec_tolerance/2))-width)+case_wall_thickness,z_location])
            cube([length+EE_spec_tolerance,width+case_wall_thickness+cutout,thickness],center );
        } else if (face == "RI"){
            translate([x_location+(EE_spec_tolerance/2),y_location+(EE_spec_tolerance/2),z_location])
            cube([length+EE_spec_tolerance+case_wall_thickness+cutout,width+EE_spec_tolerance,thickness],center );
        } else if (face == "LE") {  
            translate([x_location+(EE_spec_tolerance/2),y_location+(EE_spec_tolerance/2),z_location])
            cube([length+EE_spec_tolerance+case_wall_thickness+cutout,width+EE_spec_tolerance,thickness],center );
        } else if (face == "TO") {
            translate([x_location+(EE_spec_tolerance/2)-(case_wall_thickness+cutout),y_location+(EE_spec_tolerance/2),z_location])
            cube([length+EE_spec_tolerance,width+EE_spec_tolerance,thickness+case_wall_thickness+cutout],center );
        } else { // face == "BO" 
            translate([x_location+(EE_spec_tolerance/2),y_location+(EE_spec_tolerance/2),z_location])
            cube([length+EE_spec_tolerance,width,thickness+case_wall_thickness+cutout],center );
        }
    }
}
module 96BoardMountHoles(penetration){
    z_loc = (penetration == true)?-1*(case_wall_thickness+(EE_spec_tolerance/2)+(board_top_clearence_extra_tolerance/2)+cutout+.01):0;

    96BoardMountHole(mount_hole_1_x+(EE_spec_tolerance/2),mount_hole_1_y+(EE_spec_tolerance/2),z_loc, hole_size, penetration);
    96BoardMountHole(mount_hole_2_x+(EE_spec_tolerance/2),mount_hole_2_y+(EE_spec_tolerance/2),z_loc, hole_size, penetration);
    96BoardMountHole(mount_hole_3_x+(EE_spec_tolerance/2),mount_hole_3_y+(EE_spec_tolerance/2),z_loc, hole_size, penetration);
    96BoardMountHole(mount_hole_4_x+(EE_spec_tolerance/2),mount_hole_4_y+(EE_spec_tolerance/2),z_loc, hole_size, penetration);
//    if (96Board_UART_Board_Installed == true){
//        96BoardMountHole(mount_hole_5_x+(EE_spec_tolerance/2),mount_hole_5_y+(EE_spec_tolerance/2),z_loc, hole_size, penetration);
//        96BoardMountHole(mount_hole_6_x+(EE_spec_tolerance/2),mount_hole_6_y+(EE_spec_tolerance/2),z_loc, hole_size, penetration);
//        96BoardMountHole(mount_hole_7_x+(EE_spec_tolerance/2),mount_hole_7_y+(EE_spec_tolerance/2),z_loc, hole_size, penetration);
//    }
}
module 96BoardMountHole(x_location, y_location, z_location, size, penetration ){
    
    mount_cylinder(x_location, y_location, z_location, size, penetration);
}

module mount_cylinder(x_location, y_location, z_location, size, penetration){
    // Since this makes a model to diff from the external case have to add extra length to fully penatrate
    // the case
    union() {
        color("green")
        translate([x_location, y_location, z_location])
        cylinder(penetration != true?bd_total_thickness+EE_spec_tolerance+board_top_clearence_extra_tolerance:bd_total_thickness+EE_spec_tolerance+board_top_clearence_extra_tolerance+(case_wall_thickness*2)+cutout, d = size, false, $fn=smoothness);
        if (screw_terminator == true && penetration == true){
            color("Indigo")
            translate([x_location,y_location,z_location])
            cylinder(nut_hight, r=nut_size/2, $fn=nut_type);    // nut
            color("green")
            translate([x_location,y_location,z_location-cutout])
            cylinder(cutout, r=nut_size/2, $fn=nut_type);  // nut
        }
        if (screw_taper == true && penetration == true) {
            color("Indigo")
            translate([x_location,y_location,((bd_total_thickness+case_wall_thickness+EE_spec_tolerance+board_top_clearence_extra_tolerance)-screw_taper_height)])
            cylinder(screw_taper_height, r1=(size/2), r2=(size/2)+1.5, $fn=smoothness);  // screw taper
            color("red")
            translate([x_location,y_location,bd_total_thickness+case_wall_thickness+EE_spec_tolerance+board_top_clearence_extra_tolerance])
            cylinder(cutout, r1=(size/2)+1.5, r2=(size/2)+1.5, $fn=smoothness);
    
        }
    }
}
module 96BoardOuterCase(){
    if (rounded_case != true){
        translate(0,0,0);
        cube([board_length+EE_spec_tolerance+(case_wall_thickness*2),bd_width+EE_spec_tolerance+(case_wall_thickness*2),bd_total_thickness+EE_spec_tolerance+board_top_clearence_extra_tolerance+(case_wall_thickness*2)],false);
    } else {
        translate([(board_length+EE_spec_tolerance+(case_wall_thickness*2))/2,((bd_width+EE_spec_tolerance+(case_wall_thickness*2))/2),((bd_total_thickness+(case_wall_thickness*2))/2)])
        roundedBox([board_length+EE_spec_tolerance+(case_wall_thickness*2), bd_width+EE_spec_tolerance+(case_wall_thickness*2), bd_total_thickness+EE_spec_tolerance+board_top_clearence_extra_tolerance+(case_wall_thickness*2)], 5, only_retangle_rounded, $fn=smoothness);
    }
} 
module 96BoardBlock(penetration){
    96BoardBare(penetration);
    // Total footprint space consumed by 96Board
    difference() {
        cube([board_length+EE_spec_tolerance,bd_width+EE_spec_tolerance,bd_total_thickness+EE_spec_tolerance+board_top_clearence_extra_tolerance],false);
        96BoardStandoffMounts();
    };     
}

module 96BoardBare(penetration){
    // 96CE Board with connectors on it that stick out far enough to subtract from a case black
    union() {
        color( "orange" )
        translate([0,0,board_bottom_clearence])
        cube([board_length+EE_spec_tolerance,bd_width+EE_spec_tolerance,board_thickness],false);
        translate([0,0,0]){
            
            // USB_Host_Connectors
            color( "DarkTurquoise" )
            face_penetration("FR", usb_host1_offset, usb_host_length, usb_host_width, 
            usb_host_thickness, board_front_edge,board_top_surface, false);

            // Ethernet_Connectors
            color( "MediumBlue" )
            face_penetration("FR", Ethernet_offset, Ethernet_length, Ethernet_width, 
            Ethernet_thickness, board_front_edge,board_top_surface, false);

            // USB_OTG_Connector
            color( "cyan" )
            face_penetration("FR", usb_otg2_offset, usb_otg_length, usb_otg_width, 
            usb_otg_thickness, board_front_edge, board_top_surface, false);

            // DC_pwr_Connector
            color( "lightgreen" )
            face_penetration("BA", DC_pwr_offset, DC_pwr_length, DC_pwr_width, 
            DC_pwr_thickness, board_back_edge, board_top_surface, false);
            
            //Low_Speed_Connector
            if (expose_low_speed_connector == true ){
                color("MediumOrchid")
                face_penetration("TO", low_speed_connector_center_offset-(low_speed_connector_length/2), low_speed_connector_length, low_speed_connector_width, 
                bd_top_clearence, low_speed_connector_left_offset-low_speed_connector_width, board_top_surface, false);
            }
// uart_board_connector_width = 8;
//uart_board_connector_length = 5.68;
//uart_board_connector_thickness = 2.65;
//           
            //UART_Board_Connector
            if (96Board_UART_Board_Installed == true){
                color( "DarkOliveGreen" )
                face_penetration("RI", uart_board_connector_offset, uart_board_connector_length, uart_board_connector_width,
                uart_board_connector_thickness, low_speed_connector_pin_1_offset-uart_board_connector_width-1.5, uart_board_top_surface, false);
            }
            
            // UART_Board_Button
            if (expose_UART_Board_Button == true && 96Board_UART_Board_Installed == true){
                color("DodgerBlue")
                translate([uart_board_button_x_offset, uart_board_button_center_y_offset, uart_board_top_surface])
                cylinder((bd_total_thickness+case_wall_thickness+cutout)-uart_board_top_surface, d=hole_size, $fn=smoothness);
            }
           96BoardMountHoles(penetration);
        }
    }
}

module 96BoardCase(penetration){
    difference() {
        96BoardOuterCase();
        translate( [case_wall_thickness,case_wall_thickness,case_wall_thickness])
        96BoardBlock(penetration);
        if (slice == true ){
            if (slice_top == true ){
                slice_top();
            } else {
                slice_bottom();
            }
        }
    }
}

if (case == true ){
    96BoardCase(screw_holes);
} else {
    if (96BoardBlock != true){
        96BoardBare(screw_holes);
    } else {
        96BoardBlock(screw_holes);
    }
}

