--!strict
local Bypasser = {}

-- Combined bypass dictionary
Bypasser.bypassDictionary = {
    ["test"] = "this word got patched. Please try bypassing a different word.",
    ["fuck"] = "fมcׂׂׂᴋ︭",
    ["shit"] = "ꜱִִִhἷt",
    ["ass"] = "aֽ︣ꜱֽꜱֽ",
    ["discord"] = "⌝dỈִִִธcorִִִd⌝",
    ["nigga"] = "กἷֽꞡֽꞡֽαִִִ",
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
    ["fuckass"] = "fมcׂׂׂᴋ︭aธธ",
}

-- Init global TapXBypasser event
_G.TapXBypasser = _G.TapXBypasser or {
    OnNewBypass = Instance.new("BindableEvent")
}

function Bypasser.bypassText(text: string): string
    local words = string.split(text, " ")
    local result = {}

    for _, word in ipairs(words) do
        local lowerWord = string.lower(word)
        table.insert(result, Bypasser.bypassDictionary[lowerWord] or word)
    end

    local bypassed = table.concat(result, " ")

    -- Fire event with the bypassed result
    if _G.TapXBypasser and _G.TapXBypasser.OnNewBypass then
        _G.TapXBypasser.OnNewBypass:Fire(bypassed)
    end

    return bypassed
end

function Bypasser.copyToClipboard(text: string)
    if setclipboard then
        setclipboard(text)
    end
end

return Bypasser
