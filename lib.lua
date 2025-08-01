--!strict
local Bypasser = {}

-- Combined bypass dictionary
Bypasser.bypassDictionary = {
    ["test"] = "this word got patched. Please try bypassing a different word.",
    ["fuck"] = "fมcׂׂׂᴋ︭",
    ["shit"] = "şִִִĥִִִіִִִṭִִִ",
    ["ass"] = "ḁִִִśִ︭︤śִִִ",
    ["discord"] = "⌝dỈִִִธcorִִִd⌝",
    ["nigga"] = "กἷֽꞡֽꞡֽαִִִ",
    ["dick"] = "đִִִіִִִçִִִḳִִִ",
    ["sex"] = "ธex",
    ["dumbass"] = "đִִִǘִִִmִִִƀִִִąִִִşִִִşִִִ",
    ["pussy"] = "ṕִǘִşִִִşִִִyִִִ",
    ["cum"] = "cׂׂׂǘִִִmִִ",
    ["penis"] = "ṕִִִėִִִņִִִіִִִşִִִ",
    ["boobs"] = "ƀִִִὂִִִὂִִִƀִִִşִִִ",
    ["bitch"] = "ƀִִִіִִṭִִִcׂׂׂĥִִִ",
    ["asshole"] = "ąִִִşִִִşִִĥִִִὂִִִlִִִềִִִ",
    ["cock"] = "cׂׂׂὂִִ︭cׂׂḳ",
    ["bitches"] = "ƀִִִіִִִṭִִִcׂׂׂĥִִִềִִִşִִ",
    ["booty"] = "ƀ︭︤ὂִִ︭ὂִִ︭ṭ︭︤ÿִ︭︤",
    ["fuckass"] = "fมcׂׂׂᴋ︭aธธ",
    -- Newly added words
    ["molested"] = "mִִִὂִִִlִִִềִִִsִִִtִִִềִִd",
    ["butthole"] = "bมttћὂlề",
    ["sexy"] = "ธexγ",
    ["rapist"] = "rִִִสัpἷִִִรtִ",
    ["rape"] = "rสpề",
    ["cunt"] = "ͼִִִมทt",
    ["fucked"] = "ẝมͼִִִꞣִִִềִִִdִִִ",
    ["fucker"] = "ẝมͼִִִꞣִִِềִִrִִִ",
    ["dickhead"] = "dִִִiͼִִִꞣִִִћִִִềִִสd",
    ["motherfucker"] = "mὂtћềrẝมͼꞣềr",
    ["bullshit"] = "ḅִִִมlִִlรћit",
    ["whore"] = "ẅִִִĥִִִὂִִִṛִִִềִִִ",
    ["slutty"] = "รlมttִִִγִ",
    ["slut"] = "รlมt",
    ["porn"] = "ṕִִִὂִִִṛִִִňִִִ",
    ["pornhub"] = "ṕִִִὂִִִṛִִִňִִĥִִִǘִִִƀִִ",
    ["fucking"] = "ẝมͼִִִꞣִִִἷִִญทǥִִí",
    ["retarded"] = "rִִِềtสrdềdִִ",
    ["retard"] = "rִềִִִtสัrdִִί",
    ["faggot"] = "ẝสǥǥὂִִtִִิ",
    ["jackass"] = "jaִִִcׂꞣaธธ",
    ["piss"] = "ṕִִִėִִִņִִִіִִִşִִִ",
}

function Bypasser.bypassText(text: string): string
    local words = string.split(text, " ")
    local result = {}

    for _, word in ipairs(words) do
        local lowerWord = string.lower(word)
        table.insert(result, Bypasser.bypassDictionary[lowerWord] or word)
    end

    local bypassed = table.concat(result, " ")

    -- Fire event if available
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

-- Global TapXBypasser init
_G.TapXBypasser = _G.TapXBypasser or {
    OnNewBypass = Instance.new("BindableEvent")
}

return Bypasser
