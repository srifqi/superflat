-- Modify parameter in parameter.lua !

-----------------
-- Text Parser --
-----------------

-- Minetest library
function string:split(sep) local sep, fields = sep or ",", {} local pattern = string.format("([^%s]+)", sep) self:gsub(pattern, function(c) fields[#fields+1] = c end) return fields end

function sflat.parsetext(text)
	if text:split(";")[2] ~= nil then
		local options = text:split(";")[2]:split(",")
		if options[1] ~= nil or options[1] ~= "" then
			sflat.options.biome = options[1]
			if options[2] == "decoration" then
				sflat.options.decoration = true
			end
		end
	end
	
	local text, blocks = text:split(";")[1]:split(","), {}
	for a=1, #text do
		local node, amount = string.match(text[a], "^([^ ]+) *[=]([%d.-]+)$")
		if node == nil then node = 'air' end
		if amount == nil then amount = 1 end
		for b=1, amount do blocks[#blocks+1] = node end
	end
	return blocks
end
