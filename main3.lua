require "sprite"
require "keys"
require "click"
require "fonts"
require "timer"
require "snd"

dofile "interpreter.lua"
dofile "maps.lua"
dofile "animations.lua"

local fnt = _'$fnt'
fnt:face ('psst', 'themes/default/PressStart2P.ttf', 12)

declare{
canvas_map = false; spr_map = false, ship = false, base = false, camp = false, camp_catch = false, w_way = false, h_way = false,
danger = false, turn_left = false, turn_right = false, empt = false, main_stack = false,sub0_stack = false, sub1_stack = false, sub2_stack = false,}

global{
	active_slot = 1; -- 1 = "[P]", 2 = "[0]", 3 = "[1]", 4 = "[2]"
	active_register = 1;
	animation_counter = 24;
	shift_register_P = 0;
	lim_steps = 256;
	lim_P = 100;
	lim_012 = 21;
	ship_orientation = "up";
	drop_goods = true;
	ship_on_desc = false;
	turn_flag = true;
	prew_pos_x = 0; -- переменные для хранения позиции предыдущего хода
	prew_pos_y = 0; -- -- переменные для хранения позиции предыдущего хода
	ship_pos_x = 0;
	ship_pos_y = 0;
	mission_stage = "";
slotter = {
		{},
		{},
		{},
		{},
	};
map = {
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
	};
}

local function forwerts()
	if drop_goods and ship_on_desc then
		local c, r, s = main_stack[1][1], main_stack[1][2], main_stack[1][3];
		table.remove(main_stack, 1);
		--	print(c, r, s);
		show_command_cur(r, s);
		if map[ship_pos_y][ship_pos_x] == "D" then
			mission_stage = "Опасность";
			snd.play("sfx/coll.ogg")
			timer:stop();
			walkout();
			return;
		end;
		if map[ship_pos_y][ship_pos_x] == "H" then
			if ship_orientation == "up" or ship_orientation == "down" then
				if not (c == "→" or c == "←") then
					mission_stage = "Препятствие";
					snd.play("sfx/coll.ogg")
					timer:stop();
					walkout();
					return;
				end;
			end;
		end;
		if map[ship_pos_y][ship_pos_x] == "W" then
			if ship_orientation == "left" or ship_orientation == "right" then
				if not (c == "→" or c == "←") then
					mission_stage = "Препятствие";
					snd.play("sfx/coll.ogg")
					timer:stop();
					walkout();
					return;
				end;
			end;
		end;
		if map[ship_pos_y][ship_pos_x] == "◀" and turn_flag then
			turn_flag = false;
			do_thurn_contrclockwise();
		end;
		if map[ship_pos_y][ship_pos_x] == "▶" and turn_flag then
			turn_flag = false;
			do_thurn_clockwise();
		end;

		if c == "↑" then
			do_move_forward();
			--	print (#main_stack);
		elseif c == "→" then
			do_thurn_clockwise();
		elseif c == "←" then
			do_thurn_contrclockwise();
		elseif c == "*" then
			do_drop_conteiner();
		elseif c == "0" then
			if #sub0_stack > 0 then
				for i = #sub0_stack, 1, -1 do
					table.insert(main_stack, 1, sub0_stack[i])
				end;
				return true; -- again
			else
				return;
			end;
		elseif c == "1" then
			if #sub1_stack > 0 then
				for i = #sub1_stack, 1, -1 do
					table.insert(main_stack, 1, sub1_stack[i])
				end;
				return true; -- again;
			else
				return;
			end;
		elseif c == "2" then
			if #sub2_stack > 0 then
				for i = #sub2_stack, 1, -1 do
					table.insert(main_stack, 1, sub2_stack[i])
				end;
				return true; -- again;
			else
				return;
			end;
		end;
	else
		if drop_goods then
			timer:stop()
			mission_stage = "Граница поля";
			snd.play("sfx/coll.ogg")
			walkout();
		else
			timer:stop()
			mission_stage = "Промах";
			walkout();
		end;
		timer:stop()
		return;
	end;
end

game.timer = function(s)
	local function halt()
		-- halt logic
	end
	if animation_counter < 24 then
		animation_counter = animation_counter + 1;
		play_animation();
		halt();
		return;
	elseif #main_stack > 0 then
		while forwerts() do
		-- nothing to do
		end
		halt()
	else
		walkout();
		camps_calc();
	end;
end;

set_map = function(m)
	for i = 1, #m do
		for j = 1, #m[i] do
		map[i][j] = m[i][j];
		end;
	end;
end;

camps_calc = function()
local camps_incomplete = 0;
local camps_complete = 0;
	for i = 1, 16 do
		for j = 1, 16 do
			if map[i][j] == "C" then
				camps_incomplete = camps_incomplete + 1;
			end;
			if map[i][j] == "S" then
				camps_complete = camps_complete + 1;
			end;
		end;
	end;
	if camps_incomplete == 0 then
		timer:stop()
		mission_stage = "Задание выполнено";
		ways():enable();
	else
		timer:stop()
		mission_stage = "Осталось ещё "..camps_incomplete.." базы";
	end;
end;

show_command_cur = function(r,s)
	active_slot = s;
	if r > 21 then
		active_register = 21;
		shift_register_P = r - 21;
	else active_register = r;
	end;
end;

ship_start_pos = function()
	for i = 1, 16 do
		for j = 1, 16 do
			if map[i][j] == "P" then
				ship_pos_x = j;
				ship_pos_y = i;
				mission_stage = "Координаты^ВПП: "..ship_pos_x.." "..ship_pos_y;
			end;
		end;
	end;
end;

function keys:filter(press, key)
--  if key == 'z' then -- только нажатия z ловим
--      return press
--  end
    return press -- ловим все нажатия
end;

--[[
game.onkey = function(s, press, key)
    if key == 'z' then
        p("pressed: ", key)
        return
    end
    return false
end
--]]

set_command = function(command)
	if active_slot == 1 then
		local k = shift_register_P + active_register;
		table.insert(slotter[active_slot], k, command);
		table.remove(slotter[active_slot], lim_P + 1);
		if active_register == 21 and shift_register_P < 79 then
			shift_register_P = shift_register_P + 1;
		elseif active_register <= 20 then
			active_register = active_register + 1;
		end;
	else
		table.insert(slotter[active_slot], active_register, command);
		table.remove(slotter[active_slot], lim_012 + 1);
		if active_register <= 20 then
			active_register = active_register + 1;
		end;
	end;
end;

del_command = function()
	if active_slot == 1 then
		local k = shift_register_P + active_register;
		table.insert(slotter[active_slot], lim_P + 1, "-");
		table.remove(slotter[active_slot], k);
	else
		table.insert(slotter[active_slot], lim_012 + 1, "-");
		table.remove(slotter[active_slot], active_register);
	end;
end;

cur_up = function()
	if active_slot == 1 and active_register == 1 and shift_register_P > 0 then
		shift_register_P = shift_register_P - 1;
	end;
	if active_register >= 2 then
		active_register = active_register - 1;
	end;
end;

next_register = function()
	if active_slot == 1 then
		if active_register == 21 then
			shift_register_P = shift_register_P + 1;
		end;
		if active_register <= 20 then
		active_register = active_register + 1;
		end;
	else
		active_register = active_register + 1;
	end;
end;

cur_down = function()
	if active_slot == 1 and active_register == 21 and shift_register_P < 79 then
		shift_register_P = shift_register_P + 1;
	end;
	if active_register <= 20 then
		active_register = active_register + 1;
	end;
end;

cur_left = function()
	if active_slot >= 2 then
		active_slot = active_slot - 1;
	end;
end;

cur_right = function()
	if active_slot <= 3 then
		active_slot = active_slot + 1;
	end;
end;

game.onkey = function(s, press, key)
	if #objs(here()) > 0 then
		if key == 'left' then
			cur_left();
			return;
		end;
		if key == 'right' then
			cur_right();
			return;
		end;
		if key == 'up' then
			cur_up();
			return;
		end;
		if key == 'down' then
			cur_down();
			return;
		end;
		if key == 'backspace' then
			del_command();
			return;
		end;
		if key == 'space' then
			set_command("*");
			return;
		end;
		if key == '=' then
			set_command("↑");
			return;
		end;
		if key == '.' then
			set_command("→");
			return;
		end;
		if key == ',' then
			set_command("←");
			return;
		end;
		if key == '0' then
			set_command("0");
			return;
		end;
		if key == '1' then
			set_command("1");
			return;
		end;
		if key == '2' then
			set_command("2");
			return;
		end;
		if key == '3' then
			set_command("3");
			return;
		end;
		if key == '4' then
			set_command("4");
			return;
		end;
		if key == '5' then
			set_command("5");
			return;
		end;
		if key == '6' then
			set_command("6");
			return;
		end;
		if key == '7' then
			set_command("7");
			return;
		end;
		if key == '8' then
			set_command("8");
			return;
		end;
		if key == '9' then
			set_command("9");
			return;
		end;
		if key == 'return' then
			run_program();
			return;
		end;
		return false;
	end;
end;

init_stack = function(w, reg_lim)
	for i = 1, reg_lim do
		table.insert(w, "-");
	end;
end;

clear_slot = function(w)
	for i = 1, #w do
		w[i] = "-";
	end;
end;

clear_slotter = function()
	clear_slot(slotter[4]);
	clear_slot(slotter[3]);
	clear_slot(slotter[2]);
	clear_slot(slotter[1]);
	active_register = 1;
	shift_register_P = 0;
end;

draw_register = function(i,j,w)
	local register
	local color_w = "";
	if w == '0' then color_w = '{$fnt psst, "red"|0}';
	elseif w == '1' then color_w = '{$fnt psst, "yellow"|1}';
	elseif w == '2' then color_w = '{$fnt psst, "blue" |2}';
	elseif w == '3' then color_w = '{$fnt psst, "lightgreen" |3}';
	elseif w == '4' then color_w = '{$fnt psst, "lightgreen" |4}';
	elseif w == '5' then color_w = '{$fnt psst, "lightgreen" |5}';
	elseif w == '6' then color_w = '{$fnt psst, "lightgreen" |6}';
	elseif w == '7' then color_w = '{$fnt psst, "lightgreen" |7}';
	elseif w == '8' then color_w = '{$fnt psst, "lightgreen" |8}';
	elseif w == '9' then color_w = '{$fnt psst, "lightgreen" |9}';
	elseif w == '*' then color_w = '{$fnt psst, "magenta" |*}';
	elseif w == '↑' then color_w = '{$fnt psst, "white" |↑}';
	elseif w == '→' then color_w = '{$fnt psst, "white" |→}';
	elseif w == '←' then color_w = '{$fnt psst, "white" |←}';
	else color_w = w;
	end;
	if i == active_slot and j == active_register then
		register = "|"..'{$fnt psst, "red"|▶}'..color_w..'{$fnt psst, "red"|◀}'.."|";
	else register = "| "..color_w.." |";
	end;
	return register;
end;

make_ship = function()
--	local f = sprite.fnt('themes/default/PressStart2P.ttf', 30);
	ship = sprite.new (32,32);
--	f:text("O", "sandybrown"):draw(ship, 1, 0);
--	f:text("¤", "navy"):compose(ship, 0, 1);
	s3:draw(ship, 0, 0);
	s4:draw(ship, 16, 0);
	s1:draw(ship, 0, 16);
	s2:draw(ship, 16, 16);
end;

draw_items = function()
	canvas_map = sprite.new "box:518x518, lawngreen";
	spr_map = sprite.new "box:512x512, lightblue";
	local f = sprite.fnt('themes/default/PressStart2P.ttf', 32);

	base = sprite.new "box:32x32, magenta";
--	f:text("P", "yellow"):draw(base, 1, 1);
	s5:draw(base, 0, 0);
	s6:draw(base, 16, 0);
	s7:draw(base, 0, 16);
	s8:draw(base, 16, 16);
	
	camp = sprite.new "box:32x32, white";
--	f:text("г", "red"):draw(camp, 1, 1);
	h7:draw(camp, 0, 0);
	f1:draw(camp, 16, 0);
	w1:draw(camp, 0, 16);
	s0:draw(camp, 16, 16);
	
	camp_catch = sprite.new "box:32x32, white";
--	f:text("г", "green"):draw(camp_catch, 1, 1);
	h7:draw(camp_catch, 0, 0);
	f1:draw(camp_catch, 16, 0);
	w1:draw(camp_catch, 0, 16);
	t1:draw(camp_catch, 16, 16);

	empt = sprite.new "box:32x32, blue";
--	local dot = sprite.new "box:2x2, yellow";
--[[
	dot:draw(empt, 0, 0);
	dot:draw(empt, 4, 0);
	dot:draw(empt, 8, 0);
	dot:draw(empt, 0, 4);
	dot:draw(empt, 0, 8);
--]]
	e1:draw(empt, 0, 0);
	e2:draw(empt, 16, 0);
	e3:draw(empt, 0, 16);
	e4:draw(empt, 16, 16);

	danger = sprite.new "box:32x32, blue";
--	local red_kvad = sprite.new "box:30x30, red";
--	red_kvad:draw(danger, 1, 1);
	d1:draw(danger, 0, 0);
	d2:draw(danger, 16, 0);
	d3:draw(danger, 0, 16);
	d4:draw(danger, 16, 16);

	h_way = sprite.new "box:32x32, yellow";
--	local h_line = sprite.new "box:10x2, magenta";
--	h_line:draw(h_way, 1, 5);
	h6:draw(h_way, 0, 0);
	h6:draw(h_way, 16, 0);
	h5:draw(h_way, 0, 16);
	h5:draw(h_way, 16, 16);

	w_way = sprite.new "box:32x32, yellow";
--	local w_line = sprite.new "box:2x10, magenta";
--	w_line:draw(w_way, 5, 1);
	w4:draw(w_way, 0, 0);
	w6:draw(w_way, 16, 0);
	w4:draw(w_way, 0, 16);
	w6:draw(w_way, 16, 16);
	
	turn_left = sprite.new "box:32x32, green";
--	f:text("◀", "black"):draw(turn_left, 1, 2);
	g2:draw(turn_left, 0, 0);
	g4:draw(turn_left, 16, 0);
	g1:draw(turn_left, 0, 16);
	g3:draw(turn_left, 16, 16);

	turn_right = sprite.new "box:32x32, green";
--	f:text("▶", "black"):draw(turn_right, 2, 2);
	g6:draw(turn_right, 0, 0);
	g8:draw(turn_right, 16, 0);
	g5:draw(turn_right, 0, 16);
	g7:draw(turn_right, 16, 16);
	
end;

draw_map = function()
local locmap = "";
	for i = 1, 16 do
		for j = 1, 16 do
			local l = i * 32 - 32;
			local k = j * 32 - 32;
			locmap = map[j][i];
			if locmap == "P" then base:draw(spr_map, l, k);
			elseif locmap == "C" then camp:draw(spr_map, l, k);
			elseif locmap == "S" then camp_catch:draw(spr_map, l, k);
			elseif locmap == "D" then danger:draw(spr_map, l, k);
			elseif locmap == "H" then h_way:draw(spr_map, l, k);
			elseif locmap == "W" then w_way:draw(spr_map, l, k);
			elseif locmap == "◀" then turn_left:draw(spr_map, l, k);
			elseif locmap == "▶" then turn_right:draw(spr_map, l, k);
			else empt:draw(spr_map, l, k);
			--else f:text(locmap, "lightgreen"):draw(spr_map, l, k);
			end;
		end;
	end;
end;

draw_space = function()
	spr_map:draw(canvas_map, 3, 3);
end;

function init()
	std.strip_call = false;
	init_stack(slotter[1], lim_P);
	init_stack(slotter[2], lim_012);
	init_stack(slotter[3], lim_012);
	init_stack(slotter[4], lim_012);
	slotter[2][0] = {};
	slotter[3][0] = {};
	slotter[4][0] = {};
	place("mission_messages", me());
end;

function start()
	main_stack = {};
	sub0_stack = {};
	sub1_stack = {};
	sub2_stack = {};
	make_ship();
	draw_items();
	draw_map();
	draw_space();
	make_all_sprites();
	draw_map_a();
end;

obj {
	nam = "deck",
	dsc = function(s)
		local body = "";
		body = "<c>".."-{[P]|["..'{$fnt psst, "magenta"|P}'.."]}-".."-{[0]|["..'{$fnt psst, "red"|0}'.."]}-".."-{[1]|["..'{$fnt psst, "yellow"|1}'.."]}-".."-{[2]|["..'{$fnt psst, "blue"|2}'.."]}-^";
		for j = 1, 21 do
			for i = 1, 4 do
				if i == 1 then
					local k = shift_register_P + j;
					body = body..draw_register(i,j, slotter[i][k]);
				else
					body = body..draw_register(i,j, slotter[i][j]);
				end;
			end;
				body = body.."^";
		end;
		body = body.."--------------------";
		return pn(body.."</c>".."^");
	end;
	obj = {"[P]","[0]","[1]","[2]"};
};

obj {
	nam = "[P]",
--	act = function(s) p "MainLine"; end,
};

obj {
	nam = "[0]",
}

obj {
	nam = "[1]",
}

obj {
	nam = "[2]",
}


obj {
	nam = "key_board",
	dsc = function(s)
		local body = "";
		body = "<c>".."^{btn_1|["..'{$fnt psst, "yellow"|1}'.."]}".." {btn_2|["..'{$fnt psst, "blue"|2}'.."]}".." {btn_3|["..'{$fnt psst, "lightgreen"|3}'.."]}".." {btn_4|["..'{$fnt psst, "lightgreen"|4}'.."]}".." {btn_d|["..'{$fnt psst, "magenta"|*}'.."]}^^^".."{btn_5|["..'{$fnt psst, "lightgreen"|5}'.."]}".." {btn_6|["..'{$fnt psst, "lightgreen"|6}'.."]}".." {btn_7|["..'{$fnt psst, "lightgreen"|7}'.."]}".." {btn_8|["..'{$fnt psst, "lightgreen"|8}'.."]}".." {btn_f|["..'{$fnt psst, "white"|↑}'.."]}^^^".."{btn_9|["..'{$fnt psst, "lightgreen"|9}'.."]}".." {arr_up|["..'{$fnt psst, "cadetblue"|▲}'.."]}".." {btn_0|["..'{$fnt psst, "red"|0}'.."]}".." {btn_tl|["..'{$fnt psst, "white"|←}'.."]}".." {btn_tr|["..'{$fnt psst, "white"|→}'.."]}^^^".."{arr_left|["..'{$fnt psst, "cadetblue"|◀}'.."]}".." {arr_down|["..'{$fnt psst, "cadetblue"|▼}'.."]}".." {arr_right|["..'{$fnt psst, "cadetblue"|▶}'.."]}".." {btn_del|["..'{$fnt psst, "cadetblue"|D}'.."]}".." {btn_run|["..'{$fnt psst, "red"|R}'.."]}".."</c>";
		return pn(body);
	end,
	obj = {"btn_0","btn_1","btn_2","btn_3","btn_4","btn_5","btn_6","btn_7","btn_8","btn_9","btn_d","btn_f","btn_tl","btn_tr","arr_up","arr_left","arr_down","arr_right","btn_run","btn_del"};
}

obj {
	nam = "btn_0",
	act = function(s) set_command("0"); end,
}

obj {
	nam = "btn_1",
	act = function(s) set_command("1"); end,
}

obj {
	nam = "btn_2",
	act = function(s) set_command("2"); end,
}

obj {
	nam = "btn_3",
	act = function(s) set_command("3"); end,
}

obj {
	nam = "btn_4",
	act = function(s) set_command("4"); end,
}

obj {
	nam = "btn_5",
	act = function(s) set_command("5"); end,
}

obj {
	nam = "btn_6",
	act = function(s) set_command("6"); end,
}

obj {
	nam = "btn_7",
	act = function(s) set_command("7"); end,
}

obj {
	nam = "btn_8",
	act = function(s) set_command("8"); end,
}

obj {
	nam = "btn_9",
	act = function(s) set_command("9"); end,
}

obj {
	nam = "btn_d",
	act = function(s) set_command("*"); end,
}

obj {
	nam = "btn_f",
	act = function(s) set_command("↑"); end,
}

obj {
	nam = "btn_tl",
	act = function(s) set_command("←"); end,
}

obj {
	nam = "btn_tr",
	act = function(s) set_command("→"); end,
}

obj {
	nam = "arr_up",
	act = function(s) cur_up(); end,
}

obj {
	nam = "arr_down",
	act = function(s) cur_down(); end,
}

obj {
	nam = "arr_left",
	act = function(s) cur_left(); end,
}

obj {
	nam = "arr_right",
	act = function(s) cur_right(); end,
}

obj {
	nam = "btn_run",
	act = function(s)
		run_program();
	end,
}

obj {
	nam = "btn_del",
	act = function(s) del_command(); end,
}

stat {
	nam = "mission_messages",
	disp = function(s)
		return pn (s.message..mission_stage);
	end,
	{
		message = "",
	},
}
--

room {
	nam = "main",
	disp = "***Инструкция***",
	pic = function()
		return deep_sky;
	end,
	dsc = "^"..[[Вы - курсант лётной академии. Ваша задача - освоить прокладку курса с помощью новейшего комплекса "Автопилот Высшего Сорта". Сокращённо - АВ0Сь. Проложите курс так, чтобы корабль смог избежать неприятностей и доставил груз на все базы. Корабль всегда стартует с посадочной площадки.]],
	way = {"instr_1"},
}

room {
	nam = "instr_1",
	disp = "Основы управления",
	title = "***Управление***",
	pic = function()
		return deep_sky;
	end,
	dsc = "^"..[[Поведение корабля задаёт программа.
	Она состоит из команд и пишется в стеке ]].."["..'{$fnt psst, "magenta"|P}'.."]^^".."Основные команды:^^".."["..'{$fnt psst, "white"|↑}'.."] (+) - перелет в следующий квадрат по курсу^^".."["..'{$fnt psst, "white"|←}'.."] (<) - поворот на месте влево^^".."["..'{$fnt psst, "white"|→}'.."] (>) - поворот на месте вправо^^".."["..'{$fnt psst, "magenta"|*}'.."] (пробел) - сброс груза^^".."["..'{$fnt psst, "red"|R}'.."] (ввод) - пуск программы^^".."["..'{$fnt psst, "cadetblue"|D}'.."] (забой) - удаление лишней команды^^",
	way = {"lesson_1"},
}

room {
	nam = "Anim",
	disp = "",
	title = "",
	pic = function()
		return canvas;
	end,
	obj = {"deck", "key_board"},
}

room {
	nam = "lesson_1",
	disp = "Начать урок 1",
	title = "Урок 1",
	cur_map = function()
		set_map(map_1);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"instr_2"},
}

--[[
room {
	nam = "lesson_1",
	disp = "Начать урок 1",
	title = "Урок 1",
	cur_map = function()
		set_map(map_1);
	end,
	pic = function()
		return canvas;
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		ship_start_pos();
		draw_map_a();
		draw_space();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"instr_2"},
}
--]]

room {
	nam = "instr_2",
	disp = "Урок 2",
	title = "***Процедуры***",
	pic = function()
		return deep_sky;
	end,
	dsc = "^"..[[Последовательности команд можно объединять в процедуры, чтобы не задавать несколько раз одно и то же.]].."^^"..[[Процедура задаётся в столбце ]].."["..'{$fnt psst, "red"|0}'.."], ".."["..'{$fnt psst, "yellow"|1}'.."] или ".."["..'{$fnt psst, "blue"|2}'.."], а в нужном месте программы достаточно нажать клавишу 0, 1 или 2.",
	way = {"lesson_2"},
}

room {
	nam = "lesson_2",
	disp = "Начать урок 2",
	title = "Урок 2",
	cur_map = function()
		set_map(map_2);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"instr_3"},
}

room {
	nam = "instr_3",
	disp = "Урок 3",
	title = "***Циклы***",
	pic = function()
		return deep_sky;
	end,
	dsc = "^"..[[Другой способ сокращения записи применяется к цепочкам одинаковых команд.]].."^^"..[[Нужно указать, сколько раз повторить необходимую команду. Такой приём называют циклом. Для этого используются клавиши ]].."["..'{$fnt psst, "lightgreen"|3}'.."], ".."["..'{$fnt psst, "lightgreen"|4}'.."], ".."["..'{$fnt psst, "lightgreen"|5}'.."], ".."["..'{$fnt psst, "lightgreen"|6}'.."], ^".."["..'{$fnt psst, "lightgreen"|7}'.."], ".."["..'{$fnt psst, "lightgreen"|8}'.."], ".."["..'{$fnt psst, "lightgreen"|9}'.."].",
	way = {"lesson_3"},
}

room {
	nam = "lesson_3",
	disp = "Начать урок 3",
	title = "Урок 3",
	cur_map = function()
		set_map(map_3);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"instr_4"},
}

room {
	nam = "instr_4",
	disp = "Урок 4",
	title = "***Циклы процедур***",
	pic = function()
		return deep_sky;
	end,
	dsc = "^"..[[Процедуры также можно повторять в цикле.]],
	way = {"lesson_4"},
}

room {
	nam = "lesson_4",
	disp = "Начать урок 4",
	title = "Урок 4",
	cur_map = function()
		set_map(map_4);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"lesson_5"},
}

room {
	nam = "lesson_5",
	disp = "Начать урок 5",
	title = "Урок 5",
	cur_map = function()
		set_map(map_5);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"lesson_6"},
}

room {
	nam = "lesson_6",
	disp = "Начать урок 6",
	title = "Урок 6",
	cur_map = function()
		set_map(map_6);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"lesson_7"},
}

room {
	nam = "lesson_7",
	disp = "Начать урок 7",
	title = "Урок 7",
	cur_map = function()
		set_map(map_7);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"lesson_8"},
}

room {
	nam = "lesson_8",
	disp = "Начать урок 8",
	title = "Урок 8",
	cur_map = function()
		set_map(map_8);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"lesson_9"},
}

room {
	nam = "lesson_9",
	disp = "Начать урок 9",
	title = "Урок 9",
	cur_map = function()
		set_map(map_9);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
	way = {"lesson_10"},
}

room {
	nam = "lesson_10",
	disp = "Начать урок 10",
	title = "Урок 10",
	cur_map = function()
		set_map(map_10);
	end,
	pic = function()
		return canvas_map;
	end,
	onenter = function(s)
		ways(s):disable();
		clear_slotter();
		s.cur_map();
		draw_map();
		draw_space();
		ship_start_pos();
		s:pic();
	end,
	obj = {"deck", "key_board"},
}
