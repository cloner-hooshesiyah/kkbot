-- By Mohamed_devt { @MD_IQ19 }

-- only enable one of them 
local Kick = true;
local Warn = false;

do


local function run(msg, matches)
    
    if ( kick == true ) then
        Warn = false;
    elseif ( Warn == true ) then
        Kick = false;
    end


    -- check if the user is owner
    if (  is_realm(msg) and is_admin(msg)or is_sudo(msg) or is_momod(msg) )  then
        -- if he is a owner then exit out of the code
        return
    end

    -- load the data
    local data = load_data(_config.moderation.data)
    
    -- get the receiver and set the variable chat to it
    local chat = get_receiver(msg)

    -- get the sender id and set the variable user to it
    local user = "user#id"..msg.from.id

    -- check if the data 'LockFuck' from the table 'settings' is "yes"
    if ( data[tostring(msg.to.id)]['settings']['LockFuck'] == "yes" ) then
        -- send a message 
        send_large_msg(chat, "Ù„Ø§ØªØªÙƒÙ„Ù… Ø¨Ø§Ù„ÙØ§Ø¸ Ù…Ø®Ù„Ø© Ø¨Ø§Ù„Ø§Ø¯Ø¨ Ø¯ÙŠ ÙŠÙ„Ø§ ðŸ‘žðŸšª")
        
        -- kick the user who sent the message
        if ( Kick == true ) then
            chat_del_user(chat, user, ok_cb, true)
        elseif ( Warn   == true ) then
            send_large_msg( get_receiver(msg), "Ù„Ø§ØªØªÙƒÙ„Ù… Ø¨Ø§Ù„ÙØ§Ø¸ Ù…Ø®Ù„Ø© Ø¨Ø§Ù„Ø§Ø¯Ø¨ Ø¯ÙŠ ÙŠÙ„Ø§ ðŸ‘žðŸšª @" .. msg.from.username )
        end

    end

end
 
return {
  patterns = {
   "ÙƒØ³",
    "Ø¹ÙŠØ±",
 "Ø§Ù†Ø¬Ø¨",
 "Ø­Ù…Ø§Ø±",
 "ÙƒØ­Ø¨Ø©",
 "ÙƒÙ„Ø¹ÙŠØ±",
 "Ù†ÙŠØ¬",
 "ÙƒÙˆØ§Ø¯",
 "Ø²Ù…Ø§Ù„",
 "Ø´Ø±Ù…ÙˆØ·",
 "Ø®ÙˆØ§Øª Ø§Ù„ÙƒØ­Ø¨Ø©",
 "ÙØ±Ø®",
 "Ø§Ù†ÙŠØ¬Ùƒ",
 "ØªÙ†Ø­",
 "ÙØ±Ù†Ø³ÙŠ",
 "ÙƒÙˆØ§Ø¯",
 "Ø§Ø®ØªÙƒ",
 "Ø®Ø§Ù„ØªÙƒ",
 "ØªØªÙ„Ø²Ùƒ",
 "ÙƒØ­Ø¨Ù‡",
 "Ø®ÙˆØ§Øª Ø§Ù„ÙƒØ­Ø¨Ù‡",
 "ØªÙ†ÙŠØ¬",
 "Ù†ÙŠØ¬Ù‡ ",
 "Ù†ÙŠØ¬Ø©",
 "Ø¹ÙŠØ±ÙŠ",
 "Ø§Ø®ØªÙƒ"
  },
  run = run
}

end
