local function run(msg)
 if not is_sudo(msg) then
              return "سررررورررره😍😍"
       end
if msg.text == "استقلال" then
	return "سررررورررره😍😍"

end
end

return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
	       	"^(استقلال)$",
	       			}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
