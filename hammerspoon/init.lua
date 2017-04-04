-- ~/.config/karabiner/karabiner.json
-- {
--   "global": {
--     "check_for_updates_on_startup": true,
--     "show_in_menu_bar": true,
--     "show_profile_name_in_menu_bar": false
--   },
--   "profiles": [
--     {
--       "name": "Default profile",
--       "selected": true,
--       "simple_modifications": {
--         "caps_lock": "right_control",
--         "left_control": "f18"
--       }
--     }
--   ]
-- }


-- for debug...
-- hs.hotkey.bind({"ctrl", "cmd"}, "r", function () hs.reload() end)
-- hs.console.clearConsole()
-- hs.openConsole()
-- hs.consoleOnTop()


-- Hyperkey hack
-- hattip https://gist.github.com/ttscoff/cce98a711b5476166792d5e6f1ac5907
hyper = hs.hotkey.modal.new('', 'F18')
function hyper:entered()
   hs.timer.doAfter(.6, function() hyper:exit() end)
end

-- hyper + space (Spotlight)
hyper:bind({}, 'space', function ()
  hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'space')
  hyper:exit()
end)

-- hyper + -/+ (The Hit List)
hyper:bind({}, '-', function ()
  hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, '-')
  hyper:exit()
end)
hyper:bind({}, '=', function ()
  hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, '=')
  hyper:exit()
end)




-- Press Cmd+Q twice to quit
-- hattip https://github.com/raulchen/dotfiles/blob/master/hammerspoon/double_cmdq_to_quit.lua
quitModal = hs.hotkey.modal.new('cmd','q', 'Press Cmd+Q again to quit')
function quitModal:entered()
  hs.timer.doAfter(.3, function() quitModal:exit() end)
end

quitModal:bind('cmd', 'q', function ()
  hs.application.frontmostApplication():selectMenuItem("^Quit.*$")
  quitModal:exit()
end)

quitModal:bind('', 'escape', function() quitModal:exit() end)
