# HEADER #

scenario = "GLO/LO 2019";
active_buttons = 3;
response_logging = log_active;
no_logfile = true; # default logfile not created
response_matching = legacy_matching;
default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size = 24;
default_text_color = 255, 255, 255;
default_formatted_text = true;

begin;

trial {
	trial_type = specific_response;
	terminator_button = 3;
	trial_duration = forever;
	picture {
		text {
			caption = "Press [Z] if the letter E is present.\nPress [/] if the letter P is present.\nPress nothing is neither are present.";
		};	
		x = 0; y = 100;
		text {
			caption = "The letters may appear at the global (large) or local (small) level.";
		};
		x = 0; y = 0;
		text {
			caption = "Press [SPACEBAR] to begin.";
		};
		x = 0; y = -100;
	};
}instruct_trial;

$xs = 13; # local character scaling
$ys = 11; # local character scaling
$lw = 2;  # line width

line_graphic {
	#coordinates = x1, y1, x2, y2
	coordinates = '-1 * $xs', '2 * $ys', '1 * $xs', '2 * $ys';
	coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
	coordinates = '-1 * $xs', '-2 * $ys', '1 * $xs', '-2 * $ys';
	coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
	coordinates = '1 * $xs', '2 * $ys', '1 * $xs', '-2 * $ys';
	line_width = $lw;
	line_color = 128, 128, 128;
}local_8;

array {
	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '2 * $ys', '1 * $xs', '2 * $ys';
		coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
		coordinates = '-1 * $xs', '-2 * $ys', '1 * $xs', '-2 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
		line_width = $lw;
		line_color = 128, 128, 128;
	}local_E;

	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '2 * $ys', '1 * $xs', '2 * $ys';
		coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
		coordinates = '1 * $xs', '2 * $ys', '1 * $xs', '0 * $ys';
		line_width = $lw;
		line_color = 128, 128, 128;
	}local_P;

	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
		coordinates = '1 * $xs', '2 * $ys', '1 * $xs', '-2 * $ys';
		line_width = $lw;
		line_color = 128, 128, 128;
	}local_H;

	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '-2 * $ys', '1 * $xs', '-2 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
		coordinates = '1 * $xs', '2 * $ys', '1 * $xs', '-2 * $ys';
		line_width = $lw;
		line_color = 128, 128, 128;
	}local_U;

	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '2 * $ys', '1 * $xs', '2 * $ys';
		coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
		coordinates = '-1 * $xs', '-2 * $ys', '1 * $xs', '-2 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '0 * $ys';
		coordinates = '1 * $xs', '0 * $ys', '1 * $xs', '-2 * $ys';
		line_width = $lw;
		line_color = 128, 128, 128;
	}local_S;
}local_letters;

trial {
	trial_duration = 2000;
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

begin_pcl;

###   Create logfile and headers

string participant = parameter_manager.get_string( "Participant", "999" );
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
log.print( "Exposure time: " + "PLACEHOLDER" );
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
int x_scale = 32;
int y_scale = 50;

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

loop
	int block = 1
until
	block > 1
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

	block = block + 1;
end;

###################################################################################
if local_save == "YES" then

	log.close();

	input_file local_input = new input_file();
	local_input.open( local_path + filename );

	output_file final_output = new output_file();
	final_output.open_append( filename );

	loop
	until
		local_input.end_of_file() == true
	begin
		final_output.print_line( local_input.get_line() );
	end;
	
else
end;
###################################################################################
