local function run(msg, matches ) 
  if matches[1] == "name" then
    return msg.from.print_name
  end
end

return {
  patterns ={
    "^[/! #](name)$" 
 }, 
  run = run 
}

-- (developed by @parsa_psg)
