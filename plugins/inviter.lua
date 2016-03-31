do
local function invite_user(chat, user)
   local status = chat_add_user (chat, user, ok_cb, true)
   if not status then
      return "An error happened"
   end
   return "Added user: "..user.." to "..chat
end
local function service_msg(msg)
    if msg.action.user.id == our_id then
       local chat = 'chat#id'..msg.to.id
       local user = 'user#136888679'
      chat_add_user(chat, user, callback, true)
     end
   local receiver = get_receiver(msg)
   local response = ""
   if msg.action.type == "chat_del_user" and msg.from.id ~= 136888679 and msg.from.id ~= 136888679 then
      print(invite_user("chat#id"..msg.to.id, "user#136888679"..msg.action.user.id))
   end

   send_large_msg(receiver, response)
end

return {
  description = "Invite or kick someone",
  usage = "Invite or kick someone",
  patterns = {},
  on_service_msg = service_msg
}
end
