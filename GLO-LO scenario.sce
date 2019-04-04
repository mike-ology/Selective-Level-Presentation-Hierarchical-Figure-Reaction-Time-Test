# HEADER #

scenario = "GLO/LO 2019";
active_buttons = 5;
response_logging = log_active;
no_logfile = true; # default logfile not created
response_matching = legacy_matching;
default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size = 36;
default_text_color = 255, 255, 255;
default_formatted_text = true;

begin;

$exposure_duration = EXPARAM( "Trial Duration" : 1000 ); 

array { 
	bitmap { filename = "example_global_E.jpg"; preload = false; } bitmap_global_E;
	bitmap { filename = "example_global_P.jpg"; preload = false; } bitmap_global_P;
	bitmap { filename = "example_global_H.jpg"; preload = false; } bitmap_global_H;
	bitmap { filename = "example_global_U.jpg"; preload = false; } bitmap_global_U;
	bitmap { filename = "example_global_S.jpg"; preload = false; } bitmap_global_S;

	bitmap { filename = "example_local_E.jpg"; preload = false; } bitmap_local_E;
	bitmap { filename = "example_local_P.jpg"; preload = false; } bitmap_local_P;
	bitmap { filename = "example_local_H.jpg"; preload = false; } bitmap_local_H;
	bitmap { filename = "example_local_U.jpg"; preload = false; } bitmap_local_U;
	bitmap { filename = "example_local_S.jpg"; preload = false; } bitmap_local_S;
} bitmap_examples;

trial {
	trial_type = specific_response;
	terminator_button = 1, 2;
	all_responses = false;
	trial_duration = forever;
	stimulus_event {
		picture {
		}instruct_pic;
		response_active = true;
	}instruct_event;
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

picture { 
	text { 
		caption = "FEEDBACK"; 
	} feedback_text;
	x = 0; y = 0;
}feedback_pic;

text { caption = "PLACEHOLDER"; } block_message;

trial {
	trial_type = specific_response;
	terminator_button = 1, 2, 3, 4, 5;
	trial_duration = forever;
	picture {} prompt_pic;
}prompt_trial;

begin_pcl;

#######################

# Initial Setup

double scale_factor = 1.0;
double starting_scale_factor = 1.0;

include "sub_generate_prompt.pcl";

include "sub_screen_scaling.pcl";
screen_check();

#######################

# Adjust stimulus dimensions if not using 1920 x 1080 device via subroutine

#include "sub_screen_scaling.pcl";
#screen_check();

#######################

# Begin creating stimuli for experiment

double xs = 13.0 * scale_factor;
double ys = 11.0 * scale_factor;
double lw = 2.0 * scale_factor;

double bitmap_height = bitmap_global_E.height() * scale_factor;
double bitmap_width = bitmap_global_E.width() * scale_factor;

loop
	int i = 1
until
	i > bitmap_examples.count()
begin	
	bitmap_examples[i].set_load_size( 0, 0, scale_factor );
	bitmap_examples[i].load();
	i = i + 1;
end;

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

### Create instructions

picture instruct1 = new picture;
picture instruct2 = new picture;
picture instruct3 = new picture;
picture instruct4 = new picture;
picture instruct5 = new picture;

array <picture> instruct_array [0];
instruct_array.add( instruct1 );
instruct_array.add( instruct2 );
instruct_array.add( instruct3 );
instruct_array.add( instruct4 );

loop
	int instruct_screen = 1;
until
	instruct_screen > 4
begin
	
	if instruct_screen == 1 then
		create_new_prompt(1);
		prompt_message.set_caption( "In this task, you will view various images of letters.\n You will need to respond to certain letters\n and ignore others.", true );
		if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
			mid_button_text.set_caption( "Press here to continue", true );
			prompt_trial.set_terminator_buttons ( { 3, 4, 5 } );
		else
			mid_button_text.set_caption( "Press [/] to continue", true );
			prompt_trial.set_terminator_button ( 2 );
		end;
		
	elseif instruct_screen == 2 then
		create_new_prompt(2);
		prompt_pic.add_part( bitmap_global_E, -300 * scale_factor, 300 * scale_factor );
		prompt_pic.add_part( bitmap_global_P, -100 * scale_factor, 300 * scale_factor );
		prompt_pic.add_part( bitmap_local_E, 100 * scale_factor, 300 * scale_factor );
		prompt_pic.add_part( bitmap_local_P, 300 * scale_factor, 300 * scale_factor );
		
		if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
			prompt_message.set_caption( "You will need to look for the letter E and P (see examples above).\nThey can appear at either the smaller (local level) or larger (global) level.\n\nTap anywhere on the left-side of the screen if the letter E is present.\nTap anywhere on the right-side of the screen if the letter P is present.", true );
			left_button_text.set_caption( "BACK", true );
			right_button_text.set_caption( "NEXT", true );
			prompt_trial.set_terminator_buttons ( { 4, 5 } );
		else
			prompt_message.set_caption( "You will need to look for the letter E and P (see examples above).\nThey can appear at either the smaller (local level) or larger (global) level.\n\nPress the [Z] key if the letter E is present.\nPress the [/] key if the letter P is present.", true );
			left_button_text.set_caption( "BACK [Z]", true );
			right_button_text.set_caption( "NEXT [/]", true );
			prompt_trial.set_terminator_buttons (  { 1, 2 } );
		end;

	elseif instruct_screen == 3 then
		create_new_prompt(2);
		prompt_pic.add_part( bitmap_global_H, -500 * scale_factor, 300 * scale_factor );
		prompt_pic.add_part( bitmap_global_U, -300 * scale_factor, 300 * scale_factor );
		prompt_pic.add_part( bitmap_global_S, -100 * scale_factor, 300 * scale_factor );
		prompt_pic.add_part( bitmap_local_H, 100 * scale_factor, 300 * scale_factor );
		prompt_pic.add_part( bitmap_local_U, 300 * scale_factor, 300 * scale_factor );
		prompt_pic.add_part( bitmap_local_S, 500 * scale_factor, 300 * scale_factor );
		if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
			prompt_message.set_caption( "Other letters will also appear (see examples above).\n\nDo NOT tap anywhere if these appear.\nOnly respond if an E or P is present.", true );
			left_button_text.set_caption( "BACK", true );
			right_button_text.set_caption( "NEXT", true );
			prompt_trial.set_terminator_buttons ( { 4, 5 } );
		else
			prompt_message.set_caption( "Other letters will also appear (see examples above).\n\nDo NOT press anything if these appear.\nOnly respond if an E or P is present.", true );
			left_button_text.set_caption( "BACK [Z]", true );
			right_button_text.set_caption( "NEXT [/]", true );
			prompt_trial.set_terminator_buttons (  { 1, 2 } );
		end;

	elseif instruct_screen == 4 then
		create_new_prompt(2);
		if parameter_manager.get_string( "Practice Trials", "YES" ) == "YES" then
			prompt_message.set_caption( "Try to make your responses (when required) as quickly as possible.\n\nThere will be opportunities for short breaks though-out the task\n\nAre you read to start some practice trials?", true );
		else
			prompt_message.set_caption( "Try to make your responses (when required) as quickly as possible.\n\nThere will be opportunities for short breaks though-out the task\n\nAre you read to begin?", true );
		end;
		
		if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
			left_button_text.set_caption( "BACK", true );
			right_button_text.set_caption( "READY!", true );
			prompt_trial.set_terminator_buttons ( { 4, 5 } );
		else
			left_button_text.set_caption( "BACK [Z]", true );
			right_button_text.set_caption( "READY! [/]", true );
			prompt_trial.set_terminator_buttons (  { 1, 2 } );
		end;

	end;

	prompt_trial.present();

	int response_key = response_manager.last_response();
	
	if instruct_screen == 1 && ( response_key == 3 || response_key == 4 || response_key == 5 ) then
		instruct_screen = instruct_screen + 1
	elseif response_key == 2 || response_key == 5 then
		instruct_screen = instruct_screen + 1;
	elseif response_key == 1 || response_key == 4 then
		instruct_screen = instruct_screen - 1;
		if instruct_screen == 0 then instruct_screen = 1 else end;
		
	else
	end;

end;


###   Define logfile parameters and initialize

string participant;
int logfile_inc = 1;

if logfile.subject() == "" then
	participant = "NULL 999"
else
	participant = logfile.subject();
end;

string local_path; 
string filename;
string use_local_save;
output_file log = new output_file;

loop
	bool log_success
until
	log_success == true
begin

	use_local_save = parameter_manager.get_string( "Use Local Save", "NO" );
	local_path = "C:/Presentation Output/SLP Hierarchical Figures/";
	filename = "SLP - Participant " +  participant + "_" + string( logfile_inc ) + ".txt";

	if use_local_save == "YES" then
		create_directory( local_path );
		if file_exists( local_path + filename ) then
			# do nothing
		else
			log.open( local_path + filename );
			break
		end;

	else
		if file_exists( logfile_directory + filename ) then
			# do nothing
		else
			log.open( filename );
			break
		end;
	end;
	
	logfile_inc = logfile_inc + 1;

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
log.print( "Exposure time: " + string( parameter_manager.get_int( "Trial Duration" ) ) );
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

#instruct_trial.present();

int max_blocks = parameter_manager.get_int( "Maximum Blocks", 1 );
string is_practice_on = parameter_manager.get_string( "Practice Trials", "NO" );

loop
	int block = 1
until
	block > max_blocks
begin

	### GENERATE AND PRESENT TRIALS

	stimulus_set.shuffle();

	loop
		int i = 1;
		int max_i;
		if is_practice_on == "YES" then
			max_i = 10;
			block = 0;
		else
			max_i = stimulus_set.count()
		end;
	until
		i > max_i
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

		response_manager.set_button_active( 3, false );
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
		if parameter_manager.get_string( "Log Practice Trials", "YES" ) == "YES" then
			log.print( block ); log.print("\t");
			log.print( i ); log.print("\t");
			log.print( type[stimulus_set[i][1]] ); log.print("\t");
			log.print( level[stimulus_set[i][2]] ); log.print("\t");
			log.print( chara[stimulus_set[i][3]] ); log.print("\t");
			log.print( response_key ); log.print("\t");
			log.print( response_time ); log.print("\t");
			log.print( is_correct ); log.print("\n");
		else
		end;
		
		i = i + 1;

	end;

	response_manager.set_button_active( 3, true );

	if block == 0 then
		
		create_new_prompt( 2 );
		prompt_message.set_caption( "Practice Over!\n\nAre you ready to begin the main trials,\nor do you want to complete another practice block?", true );
		if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
			left_button_text.set_caption( "Practice more...", true );
			right_button_text.set_caption( "Ready!", true );
			prompt_trial.set_terminator_buttons( { 4, 5 } );
		else
			left_button_text.set_caption( "Practice more... [Z]", true );
			right_button_text.set_caption( "Ready! [/]", true );
			prompt_trial.set_terminator_buttons( { 1, 2 } );
		end;
	
		prompt_trial.present();
		
		if response_manager.last_response() == 1 || response_manager.last_response() == 4 then
			# go to start of loop without increasing block counter to 1 (keep at 0)
			continue;
		elseif response_manager.last_response() == 2 || response_manager.last_response() == 5 then
			# disable practice flag
			is_practice_on = "OFF";
		end;
		
	elseif block != max_blocks then
		create_new_prompt( 1 );
		prompt_message.set_caption( "End of block!\n\nContinue when you are ready", true );
		# not the last block
		if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
			mid_button_text.set_caption( "NEXT BLOCK", true );
			prompt_trial.set_terminator_buttons( { 3, 4, 5 } );
		else
			mid_button_text.set_caption( "NEXT BLOCK [SPACEBAR]", true );
			prompt_trial.set_terminator_button( 3 );
		end;

		prompt_trial.present()
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
#	[2] the file name
#	[3] if save operation is to be performed ("YES"/"NO") 

include "sub_force_local_save.pcl";
sub_save_to_network( local_path, filename, use_local_save );	

#########################################################

create_new_prompt( 1 );

prompt_message.set_caption( "End of experiment!\n\nThank you!\n\nPlease notify the experimenter.", true );

if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
	mid_button_text.set_caption( "CLOSE PROGRAM", true );
	prompt_trial.set_terminator_buttons( { 3, 4, 5 } );
else
	mid_button_text.set_caption( "CLOSE PROGRAM [SPACEBAR]", true );
	prompt_trial.set_terminator_button( 3 );
end;

prompt_trial.present();

