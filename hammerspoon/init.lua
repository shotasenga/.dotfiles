--
-- Reload the hammerspoon config
--
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "R", function()
      hs.reload()
end)
hs.notify.show("Hammerspoon", "the config loaded", "")


--
-- Vim like keybindings for some apps
--
local whiteListApps = {
   Dash = true,
   MindNode = true,
   ['Day One'] = true,
   Things = true,
   Finder = true,
   Cyberduck = true,
   iThoughtsX = true
}

local evilBindings = hs.fnutils.map(
   {
      { key = 'N', char = 'down', mod = {} },
      { key = 'P', char = 'up',   mod = {} },
      { key = 'J', char = 'down', mod = {} },
      { key = 'K', char = 'up',   mod = {} },
      { key = 'B', char = 'left',   mod = {} },
      { key = 'F', char = 'right',   mod = {} },
      { key = 'J', char = 'down', mod = {'cmd'} },
      { key = 'K', char = 'up',   mod = {'cmd'} },
      { key = 'J', char = 'down', mod = {'shift'} },
      { key = 'K', char = 'up',   mod = {'shift'} },
   },
   function (keymap)
      local handle = function ()
         hs.eventtap.keyStroke(keymap.mod, keymap.char, 1000)
      end

      local mod = {'ctrl'}
      for key, value in ipairs(keymap.mod) do
         table.insert(mod, value)
      end

      return hs.hotkey.new(mod, keymap.key, handle, nil, handle)
   end
)

appWatcher = hs.application.watcher.new(
   function (name, event, app)
      if event ~= hs.application.watcher.activated then
         return -- skip if the event dosen't match
      end

      local method = 'disable'
      print(name)
      if whiteListApps[name] then
         method = 'enable'
      end

      for key, binding in pairs(evilBindings) do
         binding[method](binding)
      end
   end
)
appWatcher:start()
