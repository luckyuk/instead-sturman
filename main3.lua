-- $Name: Shturman$
-- $Version: 0.6.4$
-- $Autor: kerbal$
-- $Info: The remake of the game "Штурман" by Oleg Shamshura for MSX. Thank you very much to gl00my, Minoru and spline for help in the making a this remake. Thank you very much to Oleg Shamshura for having invented this wonderful game!$

require "fmt";
require "theme";

function init()
    theme.win.geom(222, 30, 518, 522);
end

local gam_lang = {
    ru = 'Язык',
    en = 'Language',
}

local gam_title = {
    ru = 'Штурман',
    en = 'Shturman',
}

if not LANG or not gam_lang[LANG] then
    LANG = "en"
end

gam_lang = gam_lang[LANG]
gam_title = gam_title[LANG]

start_en = menu {
    nam = "@start_en";
    act = function(s)
        -- theme.win.reset(); -- done in init of module_en.lua
        gamefile('module_en.lua', true);
        return walk 'main';
    end
}

start_ru = menu {
    nam = "@start_ru";
    act = function(s)
        -- theme.win.reset(); -- done in init of module_ru.lua
        gamefile('module_ru.lua', true);
        return walk 'main';
    end
}

room {
    nam = "main";
    disp = gam_title;
    dsc = function(s)
        return fmt.c(
            gam_lang..'^^'..
            fmt.img('gb.png')..' '..[[{@start_en|English}^^]]..
            fmt.img('ru.png')..' '..[[{@start_ru|Русский}^^]]
        );
    end
}
