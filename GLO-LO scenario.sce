# HEADER #

scenario = "GLO/LO 2019";
active_buttons = 2;
response_logging = log_active;
no_logfile = false; # default logfile not created
response_matching = legacy_matching;
default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size = 24;
default_text_color = 0, 0, 0;
default_formatted_text = true;

begin;

$xs = 30; # local character scaling
$ys = 20; # local character scaling

line_graphic {
	#coordinates = x1, y1, x2, y2
	coordinates = '-1 * $xs', '2 * $ys', '1 * $xs', '2 * $ys';
	coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
	coordinates = '-1 * $xs', '-2 * $ys', '1 * $xs', '-2 * $ys';
	coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
	coordinates = '1 * $xs', '2 * $ys', '1 * $xs', '-2 * $ys';
	line_width = 2;
	line_color = 128, 128, 128;
}local_8;

array {
	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '2 * $ys', '1 * $xs', '2 * $ys';
		coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
		coordinates = '-1 * $xs', '-2 * $ys', '1 * $xs', '-2 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
		line_width = 2;
		line_color = 128, 128, 128;
	}local_E;

	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '2 * $ys', '1 * $xs', '2 * $ys';
		coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
		coordinates = '1 * $xs', '2 * $ys', '1 * $xs', '0 * $ys';
		line_width = 2;
		line_color = 128, 128, 128;
	}local_P;

	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
		coordinates = '1 * $xs', '2 * $ys', '1 * $xs', '-2 * $ys';
		line_width = 2;
		line_color = 128, 128, 128;
	}local_H;

	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '-2 * $ys', '1 * $xs', '-2 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '-2 * $ys';
		coordinates = '1 * $xs', '2 * $ys', '1 * $xs', '-2 * $ys';
		line_width = 2;
		line_color = 128, 128, 128;
	}local_U;

	line_graphic {
		#coordinates = x1, y1, x2, y2
		coordinates = '-1 * $xs', '2 * $ys', '1 * $xs', '2 * $ys';
		coordinates = '-1 * $xs', '0 * $ys', '1 * $xs', '0 * $ys';
		coordinates = '-1 * $xs', '-2 * $ys', '1 * $xs', '-2 * $ys';
		coordinates = '-1 * $xs', '2 * $ys', '-1 * $xs', '0 * $ys';
		coordinates = '1 * $xs', '0 * $ys', '1 * $xs', '-2 * $ys';
		line_width = 2;
		line_color = 128, 128, 128;
	}local_S;
}local_letters;

picture {
}pic1;

begin_pcl;

# { target/distractor, global/local, stimulus }
array <int> global_targets [2][2] = { { 1, 1, 1 }, { 1, 1, 2 } };
array <int> local_targets [2][2] = { { 1, 2, 1 }, { 1, 2, 2 } };

array <int> global_distractors [3][2] = { { 2, 1, 3 }, { 2, 1, 4 }, { 2, 1, 5 } };
array <int> local_distractors [3][2] = { { 2, 2, 3 }, { 2, 2, 4 }, { 2, 2, 5 } };

array <int> stimulus_set [0][2];

loop int i = 1 until i > 1 begin
	stimulus_set.append( global_targets );
	stimulus_set.append( global_targets );
	i = i + 1;
end;

loop int i = 1 until i > 1 begin
	stimulus_set.append( global_distractors );
	stimulus_set.append( local_distractors );
	i = i + 1;
end;

int x_scale = 70;
int y_scale = 90;

array <int> global_8_coords [15][2] = { 
	{-1,  2}, {0,  2}, {1,  2},
	{-1,  1}, {0,  1}, {1,  1},
	{-1,  0}, {0,  0}, {1,  0},
	{-1, -1}, {0, -1}, {1, -1},
	{-1, -2}, {0, -2}, {1, -2}};

array <int> global_letters[5][11] = { 
	{ 1, 2, 3, 4, 7, 8, 9, 10, 13, 14, 15 }, #E
	{ 1, 2, 3, 4, 6, 7, 8, 9, 10, 13, 13 }, #P
	{ 1, 3, 4, 6, 7, 8, 9, 10, 12, 13, 15}, #H
	{ 1, 3, 4, 6, 7, 9, 10, 12, 13, 14, 15}, #U
	{ 1, 2, 3, 4, 7, 8, 9, 12, 13, 14, 15 } }; #S

loop
	int h = 1
until
	h > 5
begin
	array <int> i [15] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
	i.shuffle();
	pic1.clear();
	int j = 1;

	loop
	until 
		j > 10
	begin
		pic1.add_part( local_letters[h], global_8_coords[i[j]][1] * x_scale, global_8_coords[i[j]][2] * y_scale );
		j = j + 1;
	end;

	loop
	until 
		j > 15
	begin
		pic1.add_part( local_8, global_8_coords[i[j]][1] * x_scale, global_8_coords[i[j]][2] * y_scale );
		j = j + 1;
	end;

	pic1.present();
	wait_interval( 2000 );

	h = h + 1;
end;

loop
	int h = 1
until
	h > 5
begin
	
	### CREATE GLOBAL TARGET
	
	pic1.clear();
		
	loop
		int i = 1
	until
		i > 11
	begin
		pic1.add_part( local_8, global_8_coords[global_letters[h][i]][1] * x_scale, global_8_coords[global_letters[h][i]][2] * y_scale );
		i = i + 1;
	end;
	
	###

	pic1.present();
	wait_interval( 2000 );
	
	h = h + 1;
end;