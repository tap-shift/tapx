--!strict
local Bypasser = {}

-- Combined bypass dictionary
Bypasser.bypassDictionary = {
    ["test"] = "this word got patched. Please try bypassing a different word.",
    ["fuck"] = "fมcׂׂׂᴋ︭",
    ["shit"] = "ꜱִִִhἷt",
    ["ass"] = "⌝αִִִʂִִִʂִִִ⌝",
    ["discord"] = "⌝dỈִִִธcorִִִd⌝",
    ["nigga"] = "this word got patched. Please try bypassing a different word.",
    ["dick"] = "⌝dỈִִִcׂׂׂҡִִִ⌝",
    ["sex"] = "ธex",
    ["dumbass"] = "dมmbaธธ",
    ["pussy"] = "pมธธy",
    ["cum"] = "⌝cׂׂׂมmִִִ⌝",
    ["penis"] = "⌝peⴖῘִִִʂִִִ⌝",
    ["boobs"] = "ḅooḅʂ",
    ["bitch"] = "ḅἷtcḥ",
    ["asshole"] = "aִִִธธhởִִִlִִִe",
    ["cock"] = "cׂׂׂὂִִִcׂׂׂҡִִִ",
    ["bitches"] = "ḅִ︭ἷִִִtcׂׂׂḥeʂ",
    ["booty"] = "ḅִ︭ooty︭",
}

function Bypasser.bypassText(text: string): string
    local words = string.split(text, " ")
    local result = {}
    
    for _, word in ipairs(words) do
        local lowerWord = string.lower(word)
        table.insert(result, Bypasser.bypassDictionary[lowerWord] or word)
    end
    
    return table.concat(result, " ")
end

function Bypasser.copyToClipboard(text: string)
    if setclipboard then
        setclipboard(text)
    end
end

return Bypasser
