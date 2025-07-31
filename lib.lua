--!strict
local Bypasser = {}

-- Homoglyphen / Zero-Width-Mix Tabelle
local charSubstitutions = {
	a = { "а", "ᴀ", "ⓐ", "𝗮" }, -- kyrillisch, lateinisch fett, etc.
	b = { "Ƅ", "ᛒ", "𝖇" },
	c = { "ϲ", "ƈ", "ᴄ" },
	d = { "ԁ", "𝖉", "ɗ" },
	e = { "е", "ɛ", "𝖊" },
	f = { "ƒ", "ғ", "𝖋" },
	g = { "ɡ", "𝗀", "𝖌" },
	h = { "һ", "𝖍", "𝘩" },
	i = { "і", "𝗂", "𝖎" },
	j = { "ј", "𝖏", "ʝ" },
	k = { "𝗄", "𝖐", "ҡ" },
	l = { "ⅼ", "𝖑", "ʟ" },
	m = { "𝗆", "𝖒", "ʍ" },
	n = { "ո", "𝖓", "ռ" },
	o = { "о", "օ", "𝗈", "𝖔" },
	p = { "ρ", "𝗉", "𝖕" },
	q = { "զ", "𝖖", "𝗊" },
	r = { "𝗋", "𝖗", "ṛ" },
	s = { "ѕ", "𝗌", "𝖘" },
	t = { "т", "𝗍", "𝖙" },
	u = { "υ", "𝗎", "𝖚" },
	v = { "ν", "ѵ", "𝗏", "𝖛" },
	w = { "ѡ", "𝗐", "𝖜" },
	x = { "х", "𝗑", "𝖝" },
	y = { "у", "𝗒", "𝖞" },
	z = { "ᴢ", "𝗓", "𝖟" },
}

-- Zero-width chars (versteckt zwischen Buchstaben)
local zeroWidthChars = {
	"\226\128\139", -- \u200b (Zero-width space)
	"\226\128\140", -- \u200c (Zero-width non-joiner)
	"\226\128\141", -- \u200d (Zero-width joiner)
}

-- Basierend auf Text zufällig Zeichen ersetzen & zero-width injizieren
function Bypasser.bypassText(text: string): string
	local newText = {}

	for c in text:gmatch(".") do
		local lower = string.lower(c)
		if charSubstitutions[lower] then
			local subs = charSubstitutions[lower]
			local picked = subs[math.random(1, #subs)]
			-- Random chance auf zero-width char danach
			local zw = math.random() < 0.7 and zeroWidthChars[math.random(1, #zeroWidthChars)] or ""
			-- Behalte Groß-/Kleinschreibung
			if c == string.upper(c) then
				table.insert(newText, string.upper(picked) .. zw)
			else
				table.insert(newText, picked .. zw)
			end
		else
			table.insert(newText, c)
		end
	end

	return table.concat(newText)
end

-- Clipboard Support
function Bypasser.copyToClipboard(text: string)
	if setclipboard then
		setclipboard(text)
	end
end

return Bypasser
