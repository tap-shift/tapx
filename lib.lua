--!strict
local Bypasser = {}

-- Homoglyphen / Zero-Width-Mix Tabelle
local charSubstitutions = {
	a = { "ą", "ḁ", "aธ", "aั", "ᴀ", "ส", "ạ", "à" },
	b = { "ƀ", "ḅ", "bม", "ɓ", "฿" },
	c = { "cׂׂׂ", "ç", "cׂꞣ", "cׂ", "ͼ", "¢" },
	d = { "đ", "dִִִ", "ď", "ḓ", "ḍ", "ɗ" },
	e = { "ė", "ề", "eִִִ", "ɛ", "є", "ẹ" },
	f = { "fม", "ƒ", "ғ", "fͼ", "f͟" },
	g = { "ǥ", "gִ", "ɠ", "ģ" },
	h = { "ĥ", "ћ", "hִִִ", "ḥ", "ђ", "Ħ" },
	i = { "į", "iͼ", "ί", "ỉ" },
	j = { "jִ", "ʝ" },
	k = { "ᴋ", "ķ", "ḳ", "kׂ", "ꞣ" },
	l = { "lề", "ḽ", "lִִִ", "ł", "ḽ", "lส" },
	m = { "mִִִ", "ṃ", "mม", "ɱ" },
	n = { "ň", "ภ", "и" },
	o = { "ὂ", "ö", "ọ" },
	p = { "ṕ", "pἷ", "pề", "ῤ" },
	q = { "qִ", },
	r = { "ṛ", "rִ", "ґ" },
	s = { "ş", "şִ", "şִִִ", "ş︭", "ş︤", "şִ", "şִִ", "ş์", "ร", "ş̇" },
	t = { "ṭ", "tִ", "ṭ︭", "ṭ︤", "tส", "т" },
	u = { "ǘ", "ú", "ü", "ų", "บ" },
	v = { "vִ", "v͟" },
	w = { "ẅ", "ฬ", "ฬִ" },
	x = { "χ", "ҳ" },
	y = { "ÿ", "ý" },
	z = { "zִ", "ʐ", "ž" },
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
