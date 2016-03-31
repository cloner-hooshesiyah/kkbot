💀اِبَُُّْْٰٕٖلَّّْٕٖٔیَُِٰٰس💀ٍّْْٰٕ รเภค, [۳۱.۰۳.۱۶ ۱۲:۱۳]
Skip to content
This repository

    Pull requests
    Issues
    Gist

    @kinehbot

1
0

    0

kinehbot/avgbot
Code
Issues 0
Pull requests 0
Wiki
Pulse
Graphs
Settings
avgbot/plugins/plugins.lua
3fceb6a 9 hours ago
@kinehbot kinehbot Update plugins.lua
223 lines (197 sloc) 5.96 KB
do

— Returns the key (index) in the config.enabled_plugins table
local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  — If not found
  return false
end

— Returns true if file exists in plugins folder
local function plugin_exists( name )
  for k,v in pairs(plugins_names()) do
    if name..'.lua' == v then
      return true
    end
  end
  return false
end

local function list_all_plugins(only_enabled)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    —  ✔️ enabled, ❌ disabled
    local status = '❌'
    nsum = nsum+1
    nact = 0
    — Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '✔️' 
      end
      nact = nact+1
    end
    if not only_enabled or status == '✔️' then
      — get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'. '..v..'  '..status..'\n'
    end
  end
  local text = text..'\nThere are '..nsum..' plugins installed.\n'..nact..' plugins enabled and '..nsum-nact..' disabled'
  return text
end

local function list_plugins(only_enabled)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    —  ✔️ enabled, ❌ disabled
    local status = '❌'
    nsum = nsum+1
    nact = 0
    — Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '✔️' 
      end
      nact = nact+1
    end
    if not only_enabled or status == '✔️' then
      — get the name
      v = string.match (v, "(.*)%.lua")
     — text = text..v..'  '..status..'\n'
    end
  end
  local text = text..'\n'..nact..' plugins enabled from '..nsum..' plugins installed.'
  return text
end

local function reload_plugins( )
  plugins = {}
  load_plugins()
  return list_plugins(true)
end


local function enable_plugin( plugin_name )
  print('checking if '..plugin_name..' exists')
  — Check if plugin is enabled
  if plugin_enabled(plugin_name) then
    return 'Plugin '..plugin_name..' is enabled'
  end
  — Checks if plugin exists
  if plugin_exists(plugin_name) then
    — Add to the config table
    table.insert(_config.enabled_plugins, plugin_name)
    print(plugin_name..' added to _config table')
    save_config()
    — Reload the plugins
    return reload_plugins( )
  else
    return 'Plugin '..plugin_name..' does not exists'
  end
end

local function disable_plugin( name, chat )
  — Check if plugins exists
  if not plugin_exists(name) then
    return 'Plugin '..name..' does not exists'
  end
  local k = plugin_enabled(name)
  — Check if plugin is enabled
  if not k then
    return 'Plugin '..name..' not enabled'
  end
  — Disable and reload
  table.remove(_config.enabled_plugins, k)
  save_config( )
  return reload_plugins(true)    
end

local function disable_plugin_on_chat(receiver, plugin)
  if not plugin_exists(plugin) then
    return "Plugin doesn't exists"
  end

  if not _config.disabled_plugin_on_chat then
    _config.disabled_plugin_on_chat = {}
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    _config.disabled_plugin_on_chat[receiver] = {}
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = true

  save_config()
  return 'Plugin '..plugin..' disabled on this chat'
end

local function reenable_plugin_on_chat(receiver, plugin)
  if not _config.disabled_plugin_on_chat then
    return 'There aren\'t any disabled plugins'
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    return 'There aren\'t any disabled plugins for this chat'
  end

  if not _config.disabled_plugin_on_chat[receiver][plugin] then
    return 'This plugin is not disabled'
  end

💀اِبَُُّْْٰٕٖلَّّْٕٖٔیَُِٰٰس💀ٍّْْٰٕ รเภค, [۳۱.۰۳.۱۶ ۱۲:۱۳]
_config.disabled_plugin_on_chat[receiver][plugin] = false
  save_config()
  return 'Plugin '..plugin..' is enabled again'
end

local function run(msg, matches)
  — Show the available plugins 
  if matches[1] == 'plug' and is_sudo(msg) then —after changed to moderator mode, set only sudo
    return list_all_plugins()
  end

  — Re-enable a plugin for this chat
  if matches[1] == '+' and matches[3] == 'chat' then
    local receiver = get_receiver(msg)
    local plugin = matches[2]
    print("enable "..plugin..' on this chat')
    return reenable_plugin_on_chat(receiver, plugin)
  end

  — Enable a plugin
  if matches[1] == '+' and is_sudo(msg) then —after changed to moderator mode, set only sudo
    local plugin_name = matches[2]
    print("enable: "..matches[2])
    return enable_plugin(plugin_name)
  end

  — Disable a plugin on a chat
  if matches[1] == '-' and matches[3] == 'chat' then
    local plugin = matches[2]
    local receiver = get_receiver(msg)
    print("disable "..plugin..' on this chat')
    return disable_plugin_on_chat(receiver, plugin)
  end

  — Disable a plugin
  if matches[1] == '-' and is_sudo(msg) then —after changed to moderator mode, set only sudo
    if matches[2] == 'plugins' then
      return 'This plugin can\'t be disabled'
    end
    print("disable: "..matches[2])
    return disable_plugin(matches[2])
  end

  — Reload all the plugins!
  if matches[1] == '*' or matches[1] == 'r' and is_sudo(msg) then —after changed to moderator mode, set only sudo
    return reload_plugins(true)
  end
end

return {
  description = "Plugin to manage other plugins. Enable, disable or reload.", 
  usage = {
      moderator = {
          "plug disable [plugin] chat : disable plugin only this chat.",
          "plug enable [plugin] chat : enable plugin only this chat.",
          },
      sudo = {
          "plug : list all plugins.",
          "plug enable [plugin] : enable plugin.",
          "plug disable [plugin] : disable plugin.",
          "plug reload : reloads all plugins." },
          },
  patterns = {
    "^plug$",
    "^plug? (+) ([%w_%.%-]+)$",
    "^plug? (-) ([%w_%.%-]+)$",
    "^plug? (+) ([%w_%.%-]+) (chat)",
    "^plug? (-) ([%w_%.%-]+) (chat)",
    "^plug? (*)$" },
  run = run,
  moderated = true, — set to moderator mode
  —privileged = true
}

end

    Status API Training Shop Blog About 

    © 2016 GitHub, Inc. Terms Privacy Security Contact Help
