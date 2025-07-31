--!strict
local Bypasser = {}

function Bypasser.bypassText(text: string): string
	local result = {}

	for word in text:gmatch("%S+") do -- jedes Wort einzeln
		local bypassedWord = {}
		for i = 1, #word do
			table.insert(bypassedWord, word:sub(i, i))
			if i < #word then
				table.insert(bypassedWord, ".")
			end
		end
		table.insert(result, table.concat(bypassedWord))
	end

	return table.concat(result, " ")
end

return Bypasser
