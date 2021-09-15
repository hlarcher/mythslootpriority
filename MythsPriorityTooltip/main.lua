function getColor(class)
    class = class:gsub("druidferal", "|cFFFF7D0ADruid Feral|r")
    class = class:gsub("druidresto", "|cFFFF7D0ADruid Resto|r")
    class = class:gsub("druidbalance", "|cFFFF7D0ADruid Balance|r")
    class = class:gsub("hunter", "|cFFABD473Hunter|r")
    class = class:gsub("magefrost", "|cFF69CCF0Mage Frost|r")
    class = class:gsub("magefire", "|cFF69CCF0Mage Fire|r")
    class = class:gsub("magearcane", "|cFF69CCF0Mage Arcane|r")
    class = class:gsub("palaholy", "|cFFF58CBAPala Holy|r")
    class = class:gsub("palaprot", "|cFFF58CBAPala Prot|r")
    class = class:gsub("palaret", "|cFFF58CBAPala Ret|r")
    class = class:gsub("priestholy", "|cFFFFFFFFPriest Holy|r")
    class = class:gsub("priestshadow", "|cFFFFFFFFPriest Shadow|r")
    class = class:gsub("rogue", "|cFFFFF569Rogue|r")
    class = class:gsub("warlock", "|cFF9482C9Warlock|r")
    class = class:gsub("warriordps", "|cFFC79C6EWarrior dps|r")
    class = class:gsub("warriorprot", "|cFFC79C6EWarrior Prot|r")
    class = class:gsub("shamanresto", "|cFF0070DEShaman Resto|r")
    class = class:gsub("shamanelem", "|cFF0070DEShaman Elem|r")
    class = class:gsub("shamanenh", "|cFF0070DEShaman Enh|r")
    return class
end

function searchForItemInfo(id)
    for index, value in next, prioList do
        if value["id"] == id then
            return value["prio1"], value["prio2"], value["prio3"], value["prio4"], value["note"]
        end
    end
end

function showOnToolTip(tooltip)
    local itemName, itemLink = tooltip:GetItem()
    
    if itemLink then
        prio1, prio2, prio3, prio4, note = searchForItemInfo(itemLink:match("item:(%d+):"))
    end
  
    if prio1 then
        if prio1 ~= "" then
            prio1 = string.format("%s", prio1)
            prio1 = getColor(prio1)
            tooltip:AddLine("|cFFFF0000Prio 1|r: "..prio1, 1, 1, 1)
        end

        if prio2 ~= "" then
            prio2 = string.format("%s", prio2)
            prio2 = getColor(prio2)
            tooltip:AddLine("|cFFFF0000Prio 2|r: "..prio2, 1, 1, 1)
        end

        if prio3 ~= "" then
            prio3 = string.format("%s", prio3)
            prio3 = getColor(prio3)
            tooltip:AddLine("|cFFFF0000Prio 3|r: "..prio3, 1, 1, 1)
        end

        if prio4 ~= "" then
            prio4 = string.format("%s", prio4)
            prio4 = getColor(prio4)
            tooltip:AddLine("|cFFFF0000Prio 4|r: "..prio4, 1, 1, 1)
        end

        if note ~= "" then
            note = string.format("%s", note)
            note = getColor(note)
            tooltip:AddLine("|cFFFF0000Note|r: "..note, 1, 1, 1)
        end
    end
end

GameTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
    showOnToolTip(tooltip)
end)


ItemRefTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
    showOnToolTip(tooltip)
end)
