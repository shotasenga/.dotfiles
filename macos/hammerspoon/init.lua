--
-- Reload the hammerspoon config
--
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()


--
-- WiFi notification
--
function handleWifiChanged()
   local network = hs.wifi.currentNetwork() or "Offline"

   local notify = hs.notify.new()
   notify:title("WiFi status ")
   notify:informativeText('changed to \"' .. network .. '"')
   notify:autoWithdraw(false)
   notify:withdrawAfter(0)
   notify:setIdImage(hs.image.imageFromName("NSNetwork"))
   notify:send()
end

hs.wifi.watcher.new(handleWifiChanged):start()
handleWifiChanged()


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
   iThoughtsX = true,
   Dynalist = true,
   Slack = true,
   ['Google Chrome'] = true
}

local appsForPartialKeymap = {
   ['Google Chrome'] = true
}

local evilBindings = hs.fnutils.map(
   {
      { key = 'N', char = 'down', mod = {} },
      { key = 'P', char = 'up',   mod = {} },
      { key = 'B', char = 'left',   mod = {} },
      { key = 'F', char = 'right',   mod = {} },
      { key = 'N', char = 'down', mod = {'cmd'} },
      { key = 'P', char = 'up',   mod = {'cmd'} },
      { key = 'N', char = 'down', mod = {'shift'} },
      { key = 'P', char = 'up',   mod = {'shift'} },
   },
   function (keymap)
      local handle = function ()
         hs.eventtap.keyStroke(keymap.mod, keymap.char, 1000)
      end

      local mod = {'ctrl'}
      for key, value in ipairs(keymap.mod) do
         table.insert(mod, value)
      end

      return {
        keymap = keymap,
        hotkey = hs.hotkey.new(mod, keymap.key, handle, nil, handle)
      }
   end
)

appWatcher = hs.application.watcher.new(
   function (name, event, app)
      if event ~= hs.application.watcher.activated then
         return -- skip if the event dosen't match
      end

      local method = 'disable'

      if whiteListApps[name] then
         method = 'enable'
      end

      local partial = false
      if appsForPartialKeymap[name] then
         partial = true
      end


      for key, binding in pairs(evilBindings) do
         if (binding.keymap.key == 'B' or binding.keymap.key == 'F') and partial then
           binding.hotkey.disable(binding.hotkey)
         else
           binding.hotkey[method](binding.hotkey)
         end
      end
   end
)
appWatcher:start()
