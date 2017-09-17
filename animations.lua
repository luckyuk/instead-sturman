declare {
	a0 = sprite.new "pics/transp.gif",
	a1 = sprite.new "pics/ang2.gif",
	a2 = sprite.new "pics/ang3.gif",
	a3 = sprite.new "pics/ang4.gif",
	c1 = sprite.new "pics/cont1.gif",
	c2 = sprite.new "pics/cont2.gif",
	c3 = sprite.new "pics/cont3.gif",
	c4 = sprite.new "pics/cont4.gif",
	d1 = sprite.new "pics/dang1.gif",
	d2 = sprite.new "pics/dang2.gif",
	d3 = sprite.new "pics/dang3.gif",
	d4 = sprite.new "pics/dang4.gif",
	e1 = sprite.new "pics/empt1.gif",
	e2 = sprite.new "pics/empt2.gif",
	e3 = sprite.new "pics/empt3.gif",
	e4 = sprite.new "pics/empt4.gif",
	f1 = sprite.new "pics/flag.gif",
	f2 = sprite.new "pics/flam1_dl.gif",
	f3 = sprite.new "pics/flam1_dr.gif",
	f4 = sprite.new "pics/flam1_ul.gif",
	f5 = sprite.new "pics/flam1_ur.gif",
	f6 = sprite.new "pics/flam2_dl.gif",
	f7 = sprite.new "pics/flam2_dr.gif",
	f8 = sprite.new "pics/flam2_ul.gif",
	f9 = sprite.new "pics/flam2_ur.gif",
	g1 = sprite.new "pics/green_lld.gif",
	g2 = sprite.new "pics/green_llu.gif",
	g3 = sprite.new "pics/green_lrd.gif",
	g4 = sprite.new "pics/green_lru.gif",
	g5 = sprite.new "pics/green_rld.gif",
	g6 = sprite.new "pics/green_rlu.gif",
	g7 = sprite.new "pics/green_rrd.gif",
	g8 = sprite.new "pics/green_rru.gif",
	h1 = sprite.new "pics/h1l.gif",
	h2 = sprite.new "pics/h2l.gif",
	h3 = sprite.new "pics/h3l.gif",
	h4 = sprite.new "pics/h4l.gif",
	h5 = sprite.new "pics/hd.gif",
	h6 = sprite.new "pics/hu.gif",
	h7 = sprite.new "pics/human.gif",
	l0 = sprite.new "pics/l.gif",
	l1 = sprite.new "pics/lcuc.gif",
	l2 = sprite.new "pics/lu.gif",
	l3 = sprite.new "pics/luc.gif",
	s1 = sprite.new "pics/ship_dl.gif",
	s2 = sprite.new "pics/ship_dr.gif",
	s3 = sprite.new "pics/ship_ul.gif",
	s4 = sprite.new "pics/ship_ur.gif",
	s5 = sprite.new "pics/sp1.gif",
	s6 = sprite.new "pics/sp2.gif",
	s7 = sprite.new "pics/sp3.gif",
	s8 = sprite.new "pics/sp4.gif",
	s9 = sprite.new "pics/spe.gif",
	s0 = sprite.new "pics/stock.gif",
	t1 = sprite.new "pics/thurn_d.gif",
	t2 = sprite.new "pics/thurn_dl.gif",
	t3 = sprite.new "pics/thurn_dlm.gif",
	t4 = sprite.new "pics/thurn_dr.gif",
	t5 = sprite.new "pics/thurn_drm.gif",
	t6 = sprite.new "pics/thurn_u.gif",
	t7 = sprite.new "pics/thurn_ul.gif",
	t8 = sprite.new "pics/thurn_ur.gif",
	u1 = sprite.new "pics/u.gif",
	u2 = sprite.new "pics/upbox.gif",
	u3 = sprite.new "pics/urc.gif",
	v1 = sprite.new "pics/vent1.gif",
	v2 = sprite.new "pics/vent2.gif",
	w1 = sprite.new "pics/whpl.gif",
	w2 = sprite.new "pics/whshad.gif",
	w3 = sprite.new "pics/whpl.gif",
	w4 = sprite.new "pics/wl.gif",
	w5 = sprite.new "pics/whshadcorn.gif",
	w6 = sprite.new "pics/wr.gif",
	deep_sky = sprite.new "pics/ss122.gif",
}

declare {
	full_map = sprite.new "box:1536x1536, black",
	canvas = sprite.new "box:512x512, black",
	ship_a = sprite.new "box:32x32, black",
	empty_a = sprite.new "box:96x96, black",
	base_a = sprite.new "box:96x96, black",
	base_b = sprite.new "box:96x96, black",
	vpp_a = sprite.new "box:96x96, black",
	thur_left_a = sprite.new "box:96x96, black",
	thur_right_a = sprite.new "box:96x96, black",
	danger_a = sprite.new "box:96x96, black",
	h_way_a = sprite.new "box:96x96, black",
	w_way_a = sprite.new "box:96x96, black",
	intro_a = sprite.new "box:512x256",
	finish_a = sprite.new "box:512x192",
	--
	spr_ship = false,
	spr_expl1 = false,
	spr_expl2 = false,
	spr_empty = false,
	spr_base1 = false,
	spr_base2 = false,
	spr_danger = false,
	spr_vpp = false,
	spr_left = false,
	spr_right = false,
	spr_vert = false,
	spr_hor = false,
	intro = false,
	finish = false,
};

spr_ship = {
	{s3, s4},
	{s1, s2},
}

spr_expl1 = {
	{f4, f5},
	{f2, f3},
}

spr_expl2 = {
	{f8, f9},
	{f6, f7},
}

spr_empty = {
	{e1, e2, e1, e2, e1, e2},
	{e3, e4, e3, v1, e3, e4},
	{e1, v2, e1, e2, e1, e2},
	{e3, e4, e3, e4, e3, e4},
	{e1, e2, u2, e2, e1, e2},
	{e3, e4, e3, e4, e3, e4},
}

spr_base1 = {
	{w1, w1, w1, w1, w1, w1},
	{w1, f1, w1, h7, a2, a1},
	{w1, s0, h1, h2, a2, a3},
	{a2, a3, h3, h4, a2, a3},
	{a2, a3, h7, w1, w5, w2},
	{w5, w2, w1, w1, h7, w1},
}

spr_base2 = {
	{w1, w1, w1, w1, w1, w1},
	{w1, f1, w1, h7, a2, a1},
	{w1, s0, c1, c2, a2, a3},
	{a2, a3, c3, c4, a2, a3},
	{a2, a3, h7, w1, w5, w2},
	{w5, w2, w1, w1, h7, w1},
}

spr_danger = {
	{e1, e2, e1, e2, e1, e2},
	{e3, e1, e3, e4, e2, e4},
	{e1, e2, d1, d2, v1, e2},
	{e3, v2, d3, d4, e3, e4},
	{e1, e3, e1, e2, e4, e2},
	{e3, e4, e3, e4, e3, e4},
}

spr_vpp = {
	{v2, s9, w4, w6, s9, v2},
	{e1, s9, w4, w6, s9, e2},
	{e3, s9, s5, s6, s9, e4},
	{e1, s9, s7, s8, s9, e2},
	{e3, s9, s9, s9, s9, e4},
	{v2, e3, e4, e3, e4, v2},
}

spr_left = {
	{e1, e2, e1, u2, e1, e2},
	{e3, t7, t6, t6, t8, e4},
	{e1, t3, g2, g4, t5, e2},
	{v1, t3, g1, g3, t5, e4},
	{e1, t2, t1, t1, t4, e2},
	{e3, e4, e3, e4, e3, v1},
}

spr_right = {
	{e1, e2, e1, u2, e1, e2},
	{e3, t7, t6, t6, t8, e4},
	{e1, t3, g6, g8, t5, e2},
	{v1, t3, g5, g7, t5, e4},
	{e1, t2, t1, t1, t4, e2},
	{e3, e4, e3, e4, e3, v1},
}

spr_vert = {
	{e1, e2, v2, v2, e1, e2},
	{e3, v2, w4, w6, e2, e4},
	{e1, e1, w4, w6, e1, e2},
	{e3, e3, w4, w6, v1, e4},
	{e1, e3, w4, w6, e4, e2},
	{e3, e4, v2, u2, e3, e4},
}

spr_hor = {
	{e1, e2, e3, e4, e1, e2},
	{e3, e4, e1, v2, e3, e4},
	{v1, h6, h6, h6, h6, v1},
	{v1, h5, h5, h5, h5, v1},
	{e1, e2, e3, e4, e1, e2},
	{e3, e4, e1, e2, e3, e4},
}

intro = {
	{e1, e2, l3, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, e2, l3, a0, a0, a0, a0, a0, e1, l3, a0, a0, a0, a0},
	{e3, e4, e3, e4, l3, a0, a0, a0, e3, e4, l3, a0, a0, a0, a0, a0, a0, a0, e3, e4, e3, e4, e3, l3, a0, a0, e3, e4, e3, e4, l3, a0},
	{e1, e2, v1, e2, e1, l3, a0, e2, v2, e2, e1, e2, l3, e2, e1, l3, a0, e2, e1, e2, v1, e2, e1, e2, e1, e2, e1, v1, e1, e2, e1, e2},
	{e3, e4, e3, e4, e3, e4, e3, e4, e3, e4, e3, v1, e3, e4, e3, e4, l3, e4, e3, e4, e3, e4, e3, e4, e3, e4, e3, e4, e3, e4, e3, e4},
	{e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2},
	{u2, e4, u2, e4, u2, e4, u2, u2, u2, e4, u2, e4, u2, e4, u2, u2, u2, e4, u2, e4, e3, e4, u2, e4, e3, u2, u2, e4, u2, e4, u2, e4},
	{u2, e2, u2, e2, u2, e2, e1, u2, e1, e2, u2, e2, u2, e2, u2, e2, u2, e2, u2, u2, e1, u2, u2, e2, u2, e2, u2, e2, u2, e2, u2, e2},
	{u2, e4, u2, e4, u2, e4, e3, u2, e3, e4, u2, u2, u2, e4, u2, e4, u2, e4, u2, e4, u2, e4, u2, e4, u2, e4, u2, e4, u2, u2, u2, e4},
	{u2, e2, u2, e2, u2, e2, e1, u2, e1, e2, e1, e2, u2, e2, u2, u2, u2, e2, u2, e2, e1, e2, u2, e2, u2, u2, u2, e2, u2, e2, u2, e2},
	{u2, u2, u2, u2, u2, e4, e3, u2, e3, e4, u2, u2, u2, e4, u2, e4, e3, e4, u2, e4, e3, e4, u2, e4, u2, e4, u2, e4, u2, e4, u2, e4},
	{e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, v2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2, e1, e2},
	{e3, e4, e3, e4, l2, e4, e3, e4, v1, e4, e3, e4, e3, e4, l2, u1, e3, e4, e3, l2, u1, e4, v2, e4, e3, e4, e3, e4, e3, e4, e3, e4},
	{u1, e2, l2, u1, l1, u3, e1, e2, e1, e2, l2, u1, u1, u1, l1, a0, u3, e2, l2, l1, a0, u3, u1, u1, u1, e2, e1, v1, e1, e2, e1, e2},
	{a0, u3, l1, a0, a0, a0, u3, e4, l2, u1, l1, a0, a0, a0, a0, a0, a0, u3, l1, a0, a0, a0, a0, a0, a0, u3, e3, e4, e3, l2, u1, u1},
	{a0, a0, a0, a0, a0, a0, a0, u3, l1, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, u3, u1, u1, l1, a0, a0},
	{a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0},
}

finish = {
	{a0, a0, a0, a0, a0, a0, a0, a0, a0, e2, l3, e2, e1, e2, l3, a0, a0, a0, a0, e2, e1, l3, a0, a0, a0, a0, a0, a0, a0, a0, a0, a0,},
	{a0, a0, a0, a0, a0, a0, a0, a0, e3, e4, e3, e4, e3, v1, l0, a0, a0, a0, e3, e4, e3, e4, e3, l3, a0, a0, a0, a0, a0, a0, a0, a0,},
	{a0, a0, a0, e2, e1, l3, a0, e2, e1, e2, e1, e2, e1, e2, w4, w6, l3, e2, e1, e2, s9, s9, s9, s9, l3, e2, e1, l3, a0, a0, a0, a0,},
	{a0, a0, e3, e4, e3, e4, e3, e1, e3, f1, e3, e4, e3, e4, w4, w6, e3, e4, e3, e4, s9, s5, s6, s9, e3, e4, e3, e4, e3, l3, a0, a0,},
	{a0, a0, e1, u2, e1, e2, e1, e2, e1, e2, v1, e2, e1, e2, w4, w6, e1, e2, e1, e2, s9, s7, s8, s9, e1, e2, v2, v2, e1, e2, l3, a0,},
	{a0, e4, e3, e4, e3, e4, e3, e4, e3, e4, e3, e4, e3, e4, w4, w6, e3, e4, v2, e2, s9, s9, s9, s9, e3, e4, v2, v2, e3, e4, l0, a0,},
	{a0, e2, e1, e2, e1, u2, e1, e2, e1, e2, g6, g8, e1, e2, w4, w6, e1, e1, e1, e2, e2, e2, e1, e2, e1, e2, e1, e2, e1, e2, l0, a0,},
	{e3, e1, e3, e4, e3, e1, e3, e4, e2, e4, g5, g7, e3, e4, w4, w6, e3, e3, e3, e4, e4, w3, w3, w3, w3, e4, e3, e4, e3, e4, e3, l3,},
	{e1, e2, e1, e2, e1, e2, d1, d2, e1, e2, e1, e2, e1, v2, w4, w6, e1, e2, e3, e4, e1, w3, a2, a1, w3, e2, e1, e2, e1, e2, e1, l0,},
	{e3, e4, e3, e4, e3, v2, d3, d4, e3, e4, e3, e4, e3, e4, w4, w6, e3, e4, e3, e4, e3, w3, a2, a3, w3, e4, u2, e4, e3, v1, e3, l0,},
	{e1, v2, e1, e2, e1, e3, e1, e2, e4, e2, e1, v1, e1, e2, w4, w6, e1, v1, e1, e2, v1, w3, w5, w2, w3, e2, e1, e2, e1, e2, e1, e2,},
	{e3, e4, e3, e4, e3, e4, e3, e4, e3, e4, e3, e4, e3, e4, w4, w6, e3, e4, e3, e4, e3, w3, h1, h2, w3, e4, e3, e4, e3, e4, e3, e4,},
}

make_a_sprite = function(spr, spr_tabl)
	local l, k;
	for i = 1, #spr_tabl do
		for j = 1, #spr_tabl[i] do
			l = i * 16 - 16;
			k = j * 16 - 16;
			spr_tabl[i][j]:copy(spr, k, l);
		end;
	end;
end;

make_all_sprites = function()
	make_a_sprite(ship_a, spr_ship);
	make_a_sprite(empty_a, spr_empty);
	make_a_sprite(base_a, spr_base1);
	make_a_sprite(base_b, spr_base2);
	make_a_sprite(danger_a, spr_danger);	
	make_a_sprite(vpp_a, spr_vpp);
	make_a_sprite(thur_left_a, spr_left);
	make_a_sprite(thur_right_a, spr_right);
	make_a_sprite(w_way_a, spr_vert);
	make_a_sprite(h_way_a, spr_hor);
	make_a_sprite(intro_a, intro);
	make_a_sprite(finish_a, finish);
end;

draw_map_a = function()
local locmap = "";
	for i = 1, 16 do
		for j = 1, 16 do
			local l = i * 96 - 96;
			local k = j * 96 - 96;
			locmap = map[j][i];
			if locmap == "P" then vpp_a:copy(full_map, l, k);
			elseif locmap == "C" then base_a:copy(full_map, l, k);
			elseif locmap == "S" then base_b:copy(full_map, l, k);
			elseif locmap == "D" then danger_a:copy(full_map, l, k);
			elseif locmap == "H" then h_way_a:copy(full_map, l, k);
			elseif locmap == "W" then w_way_a:copy(full_map, l, k);
			elseif locmap == "◀" then thur_left_a:copy(full_map, l, k);
			elseif locmap == "▶" then thur_right_a:copy(full_map, l, k);
			else empty_a:copy(full_map, l, k);
			end;
		end;
	end;
end;

draw_base_a = function()
local locmap = "";
	for i = 1, 16 do
		for j = 1, 16 do
			local l = i * 96 - 96;
			local k = j * 96 - 96;
			locmap = map[j][i];
			if locmap == "C" then base_a:draw(full_map, l, k);
			elseif locmap == "S" then base_b:draw(full_map, l, k);
			end;
		end;
	end;
end;

draw_space_a = function()
	local ship_pos_x_a = -1 * ship_pos_x * 96 + 64 + 240;
	local ship_pos_y_a = -1 * ship_pos_y * 96 + 64 + 240;
	deep_sky:copy(canvas, 0, 0);
	full_map:copy(canvas, ship_pos_x_a, ship_pos_y_a);
	ship_a:copy(canvas, 240, 240);
end;

play_animation = function()
	print(animation_counter)
	local pos = animation_counter * step_local;
	local ship_pos_x_a = 0;
	local ship_pos_y_a = 0;
	if ship_orientation == "up" then
		ship_pos_x_a = -1 * ship_pos_x * 96 + 64 + 240;
		ship_pos_y_a = -1 * (ship_pos_y + 1) * 96 + 64 + 240 + pos;
	elseif ship_orientation == "down" then
		ship_pos_x_a = -1 * ship_pos_x * 96 + 64 + 240;
		ship_pos_y_a = -1 * (ship_pos_y - 1) * 96 + 64 + 240 - pos;
	elseif ship_orientation == "left" then
		ship_pos_x_a = -1 * (ship_pos_x + 1) * 96 + 64 + 240 + pos;
		ship_pos_y_a = -1 * ship_pos_y * 96 + 64 + 240;
	elseif ship_orientation == "right" then
		ship_pos_x_a = -1 * (ship_pos_x - 1) * 96 + 64 + 240 - pos;
		ship_pos_y_a = -1 * ship_pos_y * 96 + 64 + 240;
	end;
	deep_sky:copy(canvas, 0, 0);
	full_map:copy(canvas, ship_pos_x_a, ship_pos_y_a);
	ship_a:copy(canvas, 240, 240);
	here():pic();
end;