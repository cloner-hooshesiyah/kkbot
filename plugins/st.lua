local function run(msg)
 if not is_sudo(msg) then
              return "خفشو تو امیر نیستی جنده لاشی😡"
       end
if msg.text == "نوس اسپید" then
	return "جوووووونمممممم باااااابااااااااییییییی😍😍"

end
end

return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
	       	"^(نوس اسپید)$",
	       			}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
