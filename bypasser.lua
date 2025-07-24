--!strict
local Bypasser = {}

-- Combined bypass dictionary
local bypassDictionary = {
    ["test"] = "this word got patched. Please try bypassing a different word.",
    ["fuck"] = "⌝fษcׂׂׂk⌝",
    ["shit"] = "⌝ธhῘtִִִ⌝",
    ["ass"] = "⌝αִִִʂִִִʂִִִ⌝",
    ["discord"] = "⌝dỈִִִธcorִִִd⌝",
    ["nigga"] = "this word got patched. Please try bypassing a different word.",
    ["dick"] = "⌝dỈִִִcׂׂׂҡִִִ⌝",
    ["pussy"] = "⌝pษʂִִִʂִִִy⌝",
    ["sex"] = "⌝ʂִִִexִִׇﹺ⌝",
    ["dumbass"] = "⌝dษmbαִִִʂִִִʂִִִ⌝",
    -- Add more entries as: ["word"] = "bypassed_version"
}

function Bypasser.bypassText(text: string): string
    local words = string.split(text, " ")
    local result = {}
    
    for _, word in ipairs(words) do
        local lowerWord = string.lower(word)
        table.insert(result, bypassDictionary[lowerWord] or word)
    end
    
    return table.concat(result, " ")
end

function Bypasser.copyToClipboard(text: string)
    if setclipboard then
        setclipboard(text)
    end
end

return Bypasser
