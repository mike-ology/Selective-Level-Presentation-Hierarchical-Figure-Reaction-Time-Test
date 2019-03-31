# HEADER #

scenario = "GLO/LO 2019";
active_buttons = 5;
response_logging = log_active;
no_logfile = true; # default logfile not created
response_matching = legacy_matching;
default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size = 24;
default_text_color = 255, 255, 255;
default_formatted_text = true;

begin;

$exposure_duration = EXPARAM( "Trial Duration" : 1000 ); 

trial {
	trial_type = specific_response;
	terminator_button = 3;
	trial_duration = forever;
	picture {
		text {
			caption = "Press [Z] if the letter E is present.\nPress [/] if the letter P is present.\nPress nothing is neither are present.";
		}instruct_text_1;	
		x = 0; y = 100;
		text {
			caption = "The letters may appear at the global (large) or local (small) level.";
		}instruct_text_2;
		x = 0; y = 0;
		text {
			caption = "Press [SPACEBAR] to begin.";
		}instruct_text_3;
		x = 0; y = -100;
	}instruct_pic;
}instruct_trial;

trial {
	trial_duration = '$exposure_duration + 1000';
	trial_type = specific_response;
	terminator_button = 1, 2;
	all_responses = false;

	stimulus_event {
		picture {};
		time = 0;
		duration = next_picture;
		response_active = false;
	};

	stimulus_event {
		picture {} mask_pic;
		time = 500;
		duration = next_picture;
		response_active = false;
	};

	stimulus_event {
		picture {} trial_pic;
		time = 1000;
		duration = next_picture;
		response_active = true;
		target_button = 1, 2;
	}response_event;

}main_trial;

trial {
	trial_type = specific_response;
	terminator_button = 3;
	trial_duration = forever;
	picture {
		text {
			caption = "Block finished!";
		}block_message;	
		x = 0; y = 0;
		text {
			caption = "Press [SPACEBAR] to continue.";
		}block_prompt;
		x = 0; y = -100;
	};
}end_block_trial;

picture { 
	text { 
		caption = "FEEDBACK"; 
	} feedback_text;
	x = 0; y = 0;
}feedback_pic;

begin_pcl;

#######################

# Initial Setup

double scale_factor = 1.0;
double x_starting_scale_factor = round( display_device.width() / 1920.0, 1 );
double y_starting_scale_factor = round( display_device.height() / 1080.0, 1 );
double starting_scale_factor;
if x_starting_scale_factor  < y_starting_scale_factor then
	starting_scale_factor = x_starting_scale_factor
else
	starting_scale_factor = y_starting_scale_factor
end;

#######################

# Create "CONTINUE" prompt for use on touchscreens
# Note: The scaling on this button can not be changed so as to match response settings! 

text continue_text = new text;
line_graphic continue_button = new line_graphic;

continue_text.set_font_color( 0, 0, 0 );
continue_text.set_background_color( 0, 255, 0, 128 );
continue_text.set_font_size( 48.0 );
continue_text.set_caption( "CONTINUE", true );

continue_button.set_fill_color( 0, 255, 0, 255 );
continue_button.add_line( (-1920 / 2) * starting_scale_factor, (1080 / 8) * starting_scale_factor, (1920 / 2) * starting_scale_factor, (1080 / 8) * starting_scale_factor );
continue_button.line_to( (1920 / 2) * starting_scale_factor, (-1080 / 8) * starting_scale_factor );
continue_button.line_to( (-1920 / 2) * starting_scale_factor, (-1080 / 8) * starting_scale_factor );
continue_button.close( true );
continue_button.redraw();

# Example coordinates for continue prompt to match response settings
# picture_object.add_part( continue_object, 0, -0.75 * (1080 / 2) * starting_scale_factor );

#######################

# Adjust stimulus dimensions if not using 1920 x 1080 device via subroutine

include "sub_screen_scaling.pcl";
screen_check();

#######################

# Begin creating stimuli for experiment

double xs = 13.0 * scale_factor;
double ys = 11.0 * scale_factor;
double lw = 2.0 * scale_factor;

line_graphic local_E = new line_graphic;
line_graphic local_P = new line_graphic;
line_graphic local_H = new line_graphic;
line_graphic local_U = new line_graphic;
line_graphic local_S = new line_graphic;
line_graphic local_8 = new line_graphic;

local_E.set_line_width( lw );
local_P.set_line_width( lw );
local_H.set_line_width( lw );
local_U.set_line_width( lw );
local_S.set_line_width( lw );
local_8.set_line_width( lw );

local_E.set_line_color( 128, 128, 128, 255 );
local_P.set_line_color( 128, 128, 128, 255 );
local_H.set_line_color( 128, 128, 128, 255 );
local_U.set_line_color( 128, 128, 128, 255 );
local_S.set_line_color( 128, 128, 128, 255 );
local_8.set_line_color( 128, 128, 128, 255 );

local_E.add_line( -1 * xs, 2 * ys, 1 * xs, 2 * ys );
local_E.add_line( -1 * xs, 0 * ys, 1 * xs, 0 * ys );
local_E.add_line( -1 * xs, -2 * ys, 1 * xs, -2 * ys );
local_E.add_line( -1 * xs, 2 * ys, -1 * xs, -2 * ys );

local_P.add_line( -1 * xs, 2 * ys, 1 * xs, 2 * ys );
local_P.add_line( -1 * xs, 0 * ys, 1 * xs, 0 * ys );
local_P.add_line( -1 * xs, 2 * ys, -1 * xs, -2 * ys );
local_P.add_line( 1 * xs, 2 * ys, 1 * xs, 0 * ys );

local_H.add_line( -1 * xs, 0 * ys, 1 * xs, 0 * ys );
local_H.add_line( -1 * xs, 2 * ys, -1 * xs, -2 * ys );
local_H.add_line( 1 * xs, 2 * ys, 1 * xs, -2 * ys );

local_U.add_line( -1 * xs, -2 * ys, 1 * xs, -2 * ys );
local_U.add_line( -1 * xs, 2 * ys, -1 * xs, -2 * ys );
local_U.add_line( 1 * xs, 2 * ys, 1 * xs, -2 * ys );

local_S.add_line( -1 * xs, 2 * ys, 1 * xs, 2 * ys );
local_S.add_line( -1 * xs, 0 * ys, 1 * xs, 0 * ys );
local_S.add_line( -1 * xs, -2 * ys, 1 * xs, -2 * ys );
local_S.add_line( -1 * xs, 2 * ys, -1 * xs, 0 * ys );
local_S.add_line( 1 * xs, 0 * ys, 1 * xs, -2 * ys );

local_8.add_line( -1 * xs, 2 * ys, 1 * xs, 2 * ys );
local_8.add_line( -1 * xs, 0 * ys, 1 * xs, 0 * ys );
local_8.add_line( -1 * xs, -2 * ys, 1 * xs, -2 * ys );
local_8.add_line( -1 * xs, 2 * ys, -1 * xs, -2 * ys );
local_8.add_line( 1 * xs, 2 * ys, 1 * xs, -2 * ys );

local_E.redraw();
local_P.redraw();
local_H.redraw();
local_U.redraw();
local_S.redraw();
local_8.redraw();

array <line_graphic> local_letters [0]; 
local_letters.add( local_E );
local_letters.add( local_P );
local_letters.add( local_H );
local_letters.add( local_U );
local_letters.add( local_S );

### Change instructions for mobiles / touchscreens
if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
	instruct_pic.remove_part( 3 );
	instruct_text_1.set_caption( "Touch the left-half of the screen if the letter E is present.\nTouch the right-half of the screen if the letter P is present.\nTouch nothing is neither are present.", true );
	continue_text.set_caption( "Tap here to begin.", true );
	instruct_pic.add_part( continue_button, 0, -0.75 * (1080 / 2) * starting_scale_factor );
	instruct_pic.add_part( continue_text, 0, -0.75 * (1080 / 2) * starting_scale_factor );
else
end;

###   Define logfile parameters and initialize

string participant;
if logfile.subject() == "" then
	participant = "NULL 999"
else
	participant = logfile.subject();
end;

string local_save = parameter_manager.get_string( "Use Local Save", "NO" );
string local_path = "C:/Presentation Output/";
string filename = "Participant " +  participant + " - SLP.txt";

output_file log = new output_file;

if local_save == "YES" then
	create_directory( local_path );
	log.open_append( local_path + filename ); 
else
	log.open_append( filename ); 
end;

# Logfile Header	
log.print("SLP Hierarchical Figure Task\n");
log.print("Participant ");
log.print( participant );
log.print("\n");
log.print( date_time() );
log.print("\n");
log.print( "Scale factor: " + string( scale_factor ) );
log.print("\n");
log.print( "Exposure time: " + string( 1000 + parameter_manager.get_int( "Trial Duration" ) ) );
log.print("\n\n");

# Logfile Table
log.print("Block\t");
log.print("Trial\t");
log.print("Type\t" ); 
log.print("Level\t"); 
log.print("Chara.\t");
log.print("Resp.\t" );
log.print("RT\t" );
log.print("Crct." );
log.print("\n");

# spacing of local elements
double x_scale = 32.0 * scale_factor;
double y_scale = 50.0 * scale_factor;

# coordinates for 3x5 array
array <int> figure_coords [15][2] = { 
	{-1,  2}, {0,  2}, {1,  2},
	{-1,  1}, {0,  1}, {1,  1},
	{-1,  0}, {0,  0}, {1,  0},
	{-1, -1}, {0, -1}, {1, -1},
	{-1, -2}, {0, -2}, {1, -2}};

# positions displayed for global trials
array <int> local_pos[5][11] = { 
	{ 1, 2, 3, 4, 7, 8, 9, 10, 13, 14, 15 }, #E
	{ 1, 2, 3, 4, 6, 7, 8, 9, 10, 13, 13 }, #P
	{ 1, 3, 4, 6, 7, 8, 9, 10, 12, 13, 15}, #H
	{ 1, 3, 4, 6, 7, 9, 10, 12, 13, 14, 15}, #U
	{ 1, 2, 3, 4, 7, 8, 9, 12, 13, 14, 15 } }; #S

# create mask
loop
	int i = 1
until
	i > 15
begin
	mask_pic.add_part( local_8, figure_coords[i][1] * x_scale, figure_coords[i][2] * y_scale );
	i = i + 1;
end;

# { target/distractor, global/local, stimulus }
array <int> global_targets [2][3] = { { 1, 1, 1 }, { 1, 1, 2 } };
array <int> local_targets [2][3] = { { 1, 2, 1 }, { 1, 2, 2 } };

array <int> global_distractors [3][3] = { { 2, 1, 3 }, { 2, 1, 4 }, { 2, 1, 5 } };
array <int> local_distractors [3][3] = { { 2, 2, 3 }, { 2, 2, 4 }, { 2, 2, 5 } };

array <int> stimulus_set [0][3];

### CHANGE THE LENGTH OF THESE LOOPS TO INFLUENCE THE MAKE-UP OF EACH BLOCK ###

# Each loop will add four target trials
loop int i = 1 until i > parameter_manager.get_int( "Target Trials", 1 ) begin
	stimulus_set.append( global_targets );
	stimulus_set.append( local_targets );
	i = i + 1;
end;

# Each loop will add six distractor trials
loop int i = 1 until i > parameter_manager.get_int( "Distractor Trials", 2 ) begin
	stimulus_set.append( global_distractors );
	stimulus_set.append( local_distractors );
	i = i + 1;
end;

instruct_trial.present();

int max_blocks = parameter_manager.get_int( "Maximum Blocks", 1 );

loop
	int block = 1
until
	block > max_blocks
begin

	### GENERATE AND PRESENT TRIALS

	stimulus_set.shuffle();

	loop
		int i = 1
	until
		i > stimulus_set.count()
	begin

		trial_pic.clear();
		
		if stimulus_set[i][2] == 1 then
			### CREATE LOCAL TRIAL
			array <int> l [15] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
			l.shuffle();
			int j = 1;

			loop
			until 
				j > 10
			begin
				trial_pic.add_part( local_letters[stimulus_set[i][3]], figure_coords[l[j]][1] * x_scale, figure_coords[l[j]][2] * y_scale );
				j = j + 1;
			end;

			loop
			until 
				j > 15
			begin
				trial_pic.add_part( local_8, figure_coords[l[j]][1] * x_scale, figure_coords[l[j]][2] * y_scale );
				j = j + 1;
			end;
			
		elseif stimulus_set[i][2] == 2 then
			### CREATE GLOBAL TRIAL
			loop
				int j = 1
			until
				j > 11
			begin
				trial_pic.add_part( local_8, figure_coords[local_pos[stimulus_set[i][3]][j]][1] * x_scale, figure_coords[local_pos[stimulus_set[i][3]][j]][2] * y_scale );
				j = j + 1;
			end;

		end;
		
		main_trial.present();
		
		stimulus_data last_stimulus = stimulus_manager.last_stimulus_data();
		response_data last_response = response_manager.last_response_data();
		
		int response_time = 0;
		int response_key = 0;
		int is_correct = 99;

		if response_manager.response_count() > 0 then
			response_time = last_stimulus.reaction_time();
			response_key = last_response.button();
		else
			response_time = 0;
		end;
		
		if response_key == stimulus_set[i][3] then
			feedback_text.set_caption( "CORRECT", true );
			is_correct = 1;
			feedback_pic.present();
			wait_interval( 500 );
		elseif response_key == 0 && ( stimulus_set[i][3] == 1 || stimulus_set[i][3] == 2 ) then
			feedback_text.set_caption( "MISS!", true );
			is_correct = 0;
			feedback_pic.present();
			wait_interval( 500 );
		elseif ( response_key == 1 && stimulus_set[i][3] != 1 ) || ( response_key == 2 && stimulus_set[i][3] != 2 )  then
			feedback_text.set_caption( "WRONG!", true );
			is_correct = 0;
			feedback_pic.present();
			wait_interval( 500 );
		else
			is_correct = 1;
		end;

		array <string> type[2] = {"TARGET", "DSTRCT"};
		array <string> level[2] = {"GLOBAL", "LOCAL"};
		array <string> chara[5] = {"E", "P", "H", "U", "S"};

		# Logfile Output
		log.print( block ); log.print("\t");
		log.print( i ); log.print("\t");
		log.print( type[stimulus_set[i][1]] ); log.print("\t");
		log.print( level[stimulus_set[i][2]] ); log.print("\t");
		log.print( chara[stimulus_set[i][3]] ); log.print("\t");
		log.print( response_key ); log.print("\t");
		log.print( response_time ); log.print("\t");
		log.print( is_correct ); log.print("\n");
		
		i = i + 1;
	end;

	if block != max_blocks then
		# not the last block
		end_block_trial.present()
	else
		# skip "End of Block" message
	end;

	block = block + 1;
end;

double time = round ( ( double ( clock.time()) )/60000.00, 2 );
log.print ( "\nTime to completion... " );
log.print ( string( time ) + " minutes" ); 

log.print( "\n" );
log.print( "\n" );
log.print( "===== TASK COMPLETE =====" );
log.close();

#########################################################
# Subroutine to copy logfile back to the default location
# Requires the strings associated with:
#	[1] the local file path
#	[2] the file name to be entered as arguments
#	[3] if save operation is to be performed ("YES"/"NO") 

include "sub_force_local_save.pcl";
sub_save_to_network( local_path, filename, local_save );	

#########################################################

block_message.set_caption( "Thank you! That is the end\nof the experiment!", true );
block_prompt.set_caption( "Press [SPACEBAR] to close the program", true );

### Change instructions for mobiles / touchscreens
if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
	block_prompt.set_caption( "Touch the bottom-half of the screen to finish.", true );
else
end;

end_block_trial.present();
