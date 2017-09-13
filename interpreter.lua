
run_program = function()
		here().cur_map();
		draw_map();
		draw_space();
		here():pic();
		lim_steps = 256;
		ship_start_pos();
		draw_space_a();
		ways(here()):disable();
		draw_map_a();
		ship_orientation = "up";
		turn_flag = true;
		drop_goods = true;
		ship_on_desc = true;
		shift_register_P = 0;
		active_slot = 1;
		active_register = 1;
		clear_stack(main_stack);
		clear_stack(sub0_stack);
		clear_stack(sub1_stack);
		clear_stack(sub2_stack);
		normalise_stack(2, sub0_stack);
		normalise_stack(3, sub1_stack);
		normalise_stack(4, sub2_stack);
		normalise_stack(1, main_stack);
	--[[
		for i = 1, #main_stack do
			print (main_stack[i][1], main_stack[i][2], main_stack[i][3]);
		end;
	--]]
		walkin("Anim");
		timer:set(40);
end;

clear_stack = function(stack_table)
	while #stack_table > 0 do
		table.remove(stack_table, #stack_table);
	end;
end;

normalise_stack = function(stack_num, stack_table)
	local tmp = {};
	local counter;
	local data, register, cur_stack;
	for i = 1, #slotter[stack_num] do
		cur_stack = stack_num;
		register = i;
		data = slotter[cur_stack][register];
		if data ~= "-" then
		table.insert(tmp, {data, register, cur_stack});
		end;
	end;
	local i = 1;
	while i <= #tmp do
		if tmp[i][1] == "*" or tmp[i][1] == "↑" or tmp[i][1] == "→" or tmp[i][1] == "←" or tmp[i][1] == "0" or tmp[i][1] == "1" or tmp[i][1] == "2" then
			table.insert(stack_table, tmp[i]);
		elseif tmp[i][1] == "3" then
			if i + 1 <= #tmp then
				if tmp[i + 1][1] == "*" or tmp[i + 1][1] == "↑" or tmp[i + 1][1] == "→" or tmp[i + 1][1] == "←" or tmp[i + 1][1] == "0" or tmp[i + 1][1] == "1" or tmp[i + 1][1] == "2" then
					for p = 1, 3 do
						table.insert(stack_table, tmp[i + 1]);
					end;
				i = i + 1;
				end;
			end;
		elseif tmp[i][1] == "4" then
			if i + 1 <= #tmp then
				if tmp[i + 1][1] == "*" or tmp[i + 1][1] == "↑" or tmp[i + 1][1] == "→" or tmp[i + 1][1] == "←" or tmp[i + 1][1] == "0" or tmp[i + 1][1] == "1" or tmp[i + 1][1] == "2" then
					for p = 1, 4 do
						table.insert(stack_table, tmp[i + 1]);
					end;
				i = i + 1;
				end;
			end;
		elseif tmp[i][1] == "5" then
			if i + 1 <= #tmp then
				if tmp[i + 1][1] == "*" or tmp[i + 1][1] == "↑" or tmp[i + 1][1] == "→" or tmp[i + 1][1] == "←" or tmp[i + 1][1] == "0" or tmp[i + 1][1] == "1" or tmp[i + 1][1] == "2" then
					for p = 1, 5 do
						table.insert(stack_table, tmp[i + 1]);
					end;
				i = i+ 1;
				end;
			end;
		elseif tmp[i][1] == "6" then
			if i + 1 <= #tmp then
				if tmp[i + 1][1] == "*" or tmp[i + 1][1] == "↑" or tmp[i + 1][1] == "→" or tmp[i + 1][1] == "←" or tmp[i + 1][1] == "0" or tmp[i + 1][1] == "1" or tmp[i + 1][1] == "2" then
					for p = 1, 6 do
						table.insert(stack_table, tmp[i + 1]);
					end;
				i = i + 1;
				end;
			end;
		elseif tmp[i][1] == "7" then
			if i + 1 <= #tmp then
				if tmp[i + 1][1] == "*" or tmp[i + 1][1] == "↑" or tmp[i + 1][1] == "→" or tmp[i + 1][1] == "←" or tmp[i + 1][1] == "0" or tmp[i + 1][1] == "1" or tmp[i + 1][1] == "2" then
					for p = 1, 7 do
						table.insert(stack_table, tmp[i + 1]);
					end;
				i = i + 1;
				end;
			end;
		elseif tmp[i][1] == "8" then
			if i + 1 <= #tmp then
				if tmp[i + 1][1] == "*" or tmp[i + 1][1] == "↑" or tmp[i + 1][1] == "→" or tmp[i + 1][1] == "←" or tmp[i + 1][1] == "0" or tmp[i + 1][1] == "1" or tmp[i + 1][1] == "2" then
					for p = 1, 8 do
						table.insert(stack_table, tmp[i + 1]);
					end;
				i = i + 1;
				end;
			end;
		elseif tmp[i][1] == "9" then
			if i + 1 <= #tmp then
				if tmp[i + 1][1] == "*" or tmp[i + 1][1] == "↑" or tmp[i + 1][1] == "→" or tmp[i + 1][1] == "←" or tmp[i + 1][1] == "0" or tmp[i + 1][1] == "1" or tmp[i + 1][1] == "2" then
					for p = 1, 9 do
						table.insert(stack_table, tmp[i + 1]);
					end;
				i = i + 1;
				end;
			end;
		end;
		i = i + 1;
	end;
	clear_stack(tmp);
end;


do_move_forward = function()
		turn_flag = true;
		animation_counter = 0;
		local mov_x, mov_y = 0, 0;
		snd.play("sfx/1.ogg")
	if ship_orientation == "up" then
		ship_pos_y = ship_pos_y - 1;
		mov_x, mov_y = 0, -32;
	elseif ship_orientation == "down" then
		ship_pos_y = ship_pos_y + 1;
		mov_x, mov_y = 0, 32;
	elseif ship_orientation == "left" then
		ship_pos_x = ship_pos_x - 1;
		mov_x, mov_y = -32, 0;
	elseif ship_orientation == "right" then
		ship_pos_x = ship_pos_x + 1;
		mov_x, mov_y = 32, 0;
	end;
	if ship_pos_x < 1 or ship_pos_x > 16 or ship_pos_y < 1 or ship_pos_y > 16 then
		ship_on_desc = false;
	else
		draw_space();
		ship:draw(canvas_map, ship_pos_x * 32 - 29, ship_pos_y * 32 - 29);
	end;
	
end;

do_thurn_clockwise = function()
	snd.play("sfx/2.ogg")
	if ship_orientation == "up" then
		ship_orientation = "right";
	elseif ship_orientation == "right" then
		ship_orientation = "down";
	elseif ship_orientation == "down" then
		ship_orientation = "left";
	elseif ship_orientation == "left" then
		ship_orientation = "up";
	end;
end;

do_thurn_contrclockwise = function()
	snd.play("sfx/2.ogg")
	if ship_orientation == "up" then
		ship_orientation = "left";
	elseif ship_orientation == "left" then
		ship_orientation = "down";
	elseif ship_orientation == "down" then
		ship_orientation = "right";
	elseif ship_orientation == "right" then
		ship_orientation = "up";
	end;
end;

do_drop_conteiner = function()
	if map[ship_pos_y][ship_pos_x] == "C" then
		snd.play("sfx/3.ogg")
		map[ship_pos_y][ship_pos_x] = "S";
		draw_map();
		draw_space();
		draw_base_a();
		ship:draw(canvas_map, ship_pos_x * 32 - 29, ship_pos_y * 32 - 29);
	elseif map[ship_pos_y][ship_pos_x] == "S" then
		mission_stage = "Двойная отгрузка";
	else
		snd.play("sfx/4.ogg")
		drop_goods = false;
	end;
end;

do_empty_command = function()
	if active_slot == 1 then
		while slotter[1][active_register + shift_register_P] == "-" do
			if active_register + shift_register_P < lim_P then
				next_register();
			else
				timer:stop();
				shift_register_P = 0;
				active_register = 1;
			end;
		end;
	elseif active_slot == 2 or active_slot == 3 or active_slot == 4 then
		while slotter[active_slot][active_register] == "-" do
			if active_register < 21 then
				next_register();
			else
				active_register, active_slot = slotter[active_slot][0][#slotter[active_slot][0]];
				table.remove(slotter[active_slot][0], #slotter[active_slot][0]);
			--	active_register = slotter[active_slot][0];
			--	active_slot = slotter[active_slot][-1];
				break;
			end;
		end;
	end;
end;
