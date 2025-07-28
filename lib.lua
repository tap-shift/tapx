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
    ["bitches"] = "ḅִ︭ἷִִִtcׂׂׂḥeʂ",
    ["booty"] = "ḅִ︭ooty︭",
    ["fuckass"] = "fมcׂׂׂᴋ︭aธธ",
    -- Newly added words
    ["molested"] = "mִִִὂִִִlִִִềִִִsִִִtִִִềִִִdִִִ",
    ["pee"] = "pềִִִềִִִ",
    ["pp"] = "pềִִִềִִ",
    ["butthole"] = "bมttћὂlề",
    ["sexy"] = "ธexγ",
    ["rapist"] = "rִִִสัpἷִִִรtִ",
    ["rape"] = "rสpề",
    ["cunt"] = "ͼִִִมทt",
    ["fucked"] = "ẝมͼִִִꞣִִִềִִִdִִִ",
    ["fucker"] = "ẝมͼִִִꞣִִِềִִִrִִִ",
    ["dickhead"] = "dִִִiͼִִִꞣִִִћִִִềִִสd",
    ["motherfucker"] = "mὂtћềrẝมͼꞣềr",
    ["bullshit"] = "ḅִִִมlִִlรћit",
    ["whore"] = "wִћִִִὂִִִrềִִ",
    ["slutty"] = "รlมttִִִγִ",
    ["slut"] = "รlมt",
    ["porn"] = "pִִִὂִִִrִִィท",
    ["pornhub"] = "pִִִὂִִָrִִִทҺมḅִִִ",
    ["fucking"] = "ẝมͼִִִꞣִִִἷִִญทǥִִí",
    ["retarded"] = "rִִِềtสrdềdִִ",
    ["retard"] = "rִềִִִtสัrdִִί",
    ["faggot"] = "ẝสǥǥὂִִtִִิ",
    ["jackass"] = "jaִִִcׂꞣaธธ",
    ["piss"] = "pềⴖἷธ",
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
