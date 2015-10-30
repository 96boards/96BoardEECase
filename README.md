#96BoardEECase.scad
##Overview  

This is a quick case designed in OpenScad for 96Boards EE standard.  There
are lots of options most are generally set by true or false.  It can output
a case for the normal size EE board.  If you want an extended board it might
be better to purchase an off the shelf case for the microATX MotherBoard
Specification Version 1.2.  This is VERY early days for this case since I
don't have a board I can test in it, so it may take some adjusting yet.


It currently supports adding a UART board within the case.  And it allows
you to expose the low or high speed connectors.

You may need to adjust the EE_spec_tolerance variable depending on your 3D
printer.  This design was tested on an M3D micro printer and it generally
fits the boards pretty well.  

The only thing you need to download is the 96BoardEECase.scad file, the
.stl files are 3D print file examples of what the cases could look like.  
Or if the sample cases are exactly what you need you can download them 
directly.

One of the cool things about the 96Boards CE project is that all of the
boards us the same pins for the Low Speed Expansion Connector so you can
plug any expansion board into any 96Board.  We can add the expansion boards
here and make up custom case for that combination.

There are a BUNCH of true/false variables that can be selected and a couple
of numeric variables too, Extracted from the code:

// Square edge case or rounded edge case?
rounded_case = true;
// Only the retangle of the case rounded (sides) or all angles (top, bottom,
// sides)  
only_retangle_rounded = false;

// How thick do you want your case walls(in mm)// Square edge case or
// rounded edge case?
rounded_case = true;
// Only the retangle of the case rounded (sides) or all angles (top, bottom,
// sides)  
only_retangle_rounded = false;

// How thick do you want your case walls(in mm)  Be careful if you are
// setting rounded_case true, too thin of walls will leave holes Don't go to
// thick (much over 2.5) or you will have problems plugging in cables, so
// really the range is about 2.00mm - 2.50mm at least for me.
case_wall_thickness = 2.5;

// Extended board or reqular true/false question, there are no extended
// boards at this time (Oct 2015) but when there are we are ready.
96Boards_CE_extended_version = false;

// Do you hvave a UART board and want room to install it in the case?
96Board_UART_Board_Installed = true;

// The UART board has a reset button, if you want to be able to press it
// true
expose_UART_Board_Button = true;

// expose the low/high speed connectors or not true/false question
expose_low_speed_connector = true;
expose_high_speed_connector = false;

// The dragonboard 410c has 4 DIP switches on the bottom, true will make a
// hole so you can reach them without opening the case.
expose_DragonBoardDipSwitch = true;

// Do I want screw holes through the case? true/false question
screw_holes = true;

// Do I want nut holes on the bottom 
screw_terminator = true;

// For exporting .stl models, this will cut the model in 1/2 at the board
// top level.  The board will fit into the bottom of the case cleanly and
// the top will sit on it
slice = true;

// top of the box or bottom 
slice_top = true;

// How round do you want holes  the higer it set to the longer it takes to
// render, at 50 it takes 2-3 minutes to render the model
smoothness = 50; //10-100

// For development only. Do you want to see the full case, the full diff
// model or the bare board model can help when adding new case type
// Set true for final case, false shows you the board and screw layout
case = true;
96BoardBlock = false;

##Install the source code  
So to install 96BoardCECase.scad you need to do the following:

 Make sure you have the latest copy of OpenScad installed
**$ git clone https://github.com/96Boards/96BoardCECase.git**  
**$ $cd 96BoardCECase
 Start OpenSCAD and open the file 96BoardCECase.scad in the editor 

The code so far has been tested with a flat case,  a curved rectangular 
case and a overall curved case.

##License

This 96BoardCECase.scad is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; version 2.0 of the
License.

This library is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public 
License along with this library; if not, write to the Free Software 
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
