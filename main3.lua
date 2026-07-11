-- $Name: Sturman$
-- $Version: 0.6.5$
-- $Autor: kerbal$
-- $Info: The remake of the game "Штурман" by Oleg Shamshura for MSX. Thank you very much to gl00my, Minoru and spline for help in the making a this remake. Thank you very much to Oleg Shamshura for having invented this wonderful game!$

require "fmt";
require "theme";

function init()
    theme.win.geom(222, 30, 518, 522);
end

local LANG = ""

local gam_lang = {
    ru = 'Язык',
    en = 'Language',
}

local gam_info = {
    ru = [[Ремейк игры "Штурман" Олега Шамшуры для MSX. Большое спасибо gl00my, Minoru и spline за помощь в создании ремейка. Огромное спасибо Олегу Шамшуре за то, что придумал эту замечательную игру!]],
    en = [[The remake of the game "Штурман" by Oleg Shamshura for MSX. Thank you very much to gl00my, Minoru and spline for help in the making a this remake. Thank you very much to Oleg Shamshura for having invented this wonderful game!]],
}

local gam_title = {
    ru = 'Штурман',
    en = 'Sturman',
}


local gam_start = {
    ru = 'НАЧАТЬ',
    en = 'START',
}

if not LANG or not gam_lang[LANG] then
    LANG = "ru"
end


start_en = menu {
    nam = "@start_en";
    act = function(s)
        -- theme.win.reset(); -- done in init of module_en.lua
        --gamefile('module_en.lua', true);
        --return walk 'main';
        LANG = "en"
    end
}

start_ru = menu {
    nam = "@start_ru";
    act = function(s)
        -- theme.win.reset(); -- done in init of module_ru.lua
        --gamefile('module_ru.lua', true);
        --return walk 'main';
        LANG = "ru"
    end
}

start_game = menu {
    nam = "@start_game";
    act = function(s)
        -- theme.win.reset(); -- done in init of module_ru.lua
        gamefile('module_'..LANG..'.lua', true);
    end
}

room {
    nam = "main";
    title = function(s)
        return gam_title[LANG];
    end,
    disp = gam_title;
    decor = function(s)
        return fmt.c(
            '^^'..
            gam_info[LANG]..'^^^^'..
            gam_lang[LANG]..'^^'..
            fmt.img('gb.png')..' '..[[{@start_en|English}^^]]..
            fmt.img('ru.png')..' '..[[{@start_ru|Русский}^^]]..
            '^^'..
            [[{@start_game|]]..gam_start[LANG]..[[}]]
        );
    end
}
