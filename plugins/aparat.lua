--[[

#
#     @GPMOD
#   @Dragon_Born
#      

]]

local function run(msg, matches)
	if matches[1]:lower() == 'aparat' then
		local url = http.request('http://www.aparat.com/etc/api/videoBySearch/text/'..URL.escape(matches[2]))
		local jdat = json:decode(url)

		local items = jdat.videobysearch
		text = 'Ù†ØªÛŒØ¬Ù‡ Ø¬Ø³ØªÙˆØ¬Ùˆ Ø¯Ø± Ø¢Ù¾Ø§Ø±Ø§Øª: \n'
		for i = 1, #items do
		text = text..'\n'..i..'- '..items[i].title..'  -  ØªØ¹Ø¯Ø§Ø¯ Ø¨Ø§Ø²Ø¯ÛŒØ¯: '..items[i].visit_cnt..'\n    Ù„ÛŒÙ†Ú©: aparat.com/v/'..items[i].uid
		end
		text = text..'\n\n@GPMod'
		return text
	end
end

return {
   patterns = {
"^[/!](aparat) (.*)$",
   },
   run = run
}
