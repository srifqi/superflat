-- Modify layers in parameter.lua !

-----------------
-- Text Parser --
-----------------

-- Minetest library
function string:split(sep) local sep, fields = sep or ",", {} local pattern = string.format("([^%s]+)", sep) self:gsub(pattern, function(c) fields[#fields+1] = c end) return fields end

function sflat.parsetext(text)
	local text, blocks = text:split(","), {}
	for a=1, #text do
		local node, amount = string.match(text[a], "^([^ ]+) *[=]([%d.-]+)$")
		if node == nil then node = 'air' end
		if amount == nil then amount = 1 end
		for b=1, amount do blocks[#blocks+1] = node end
	end
	return blocks
end
