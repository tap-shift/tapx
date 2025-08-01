--!strict
local Bypasser = {}

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

-- Callback, das gesetzt werden kann, wenn Text gebypasst wurde
Bypasser.OnBypassCallback = nil

function Bypasser.bypassText(text: string): string
    local words = string.split(text, " ")
    local result = {}

    for _, word in ipairs(words) do
        local lowerWord = string.lower(word)
        table.insert(result, Bypasser.bypassDictionary[lowerWord] or word)
    end

    local bypassed = table.concat(result, " ")

    -- Callback aufrufen, wenn gesetzt
    if Bypasser.OnBypassCallback then
        Bypasser.OnBypassCallback(bypassed)
    end

    return bypassed
end

return Bypasser
