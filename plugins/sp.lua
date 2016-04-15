local function run(msg)
 if not is_sudo(msg) then
              return "نگاییییییییییییییددددددددممممممممممممممممم😡"
       end
if msg.text == "پرسپولیس" then
	return "نگاییییییییییییییددددددددممممممممممممممممم😡"

end
end

return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
	       	"^(پرسپولیس)$",
	       			}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
