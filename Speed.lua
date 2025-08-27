gg.setVisible(false)
gg.setVisible(true)
-- Global variables
local speed_addresses = {}
local speed_edits = {}
local speed_backup = {}
local status_speed = false
local original_value = nil

-- Speed hack function
function ch1()
    local initOptions = {
        "🚀 Activate Speedhack",
        "🔄 Revert Speedhack",
        "⬅️ Return"
    }
    
    local initChoice = gg.choice(initOptions, nil, "⏩ Speedhack Status: " .. (status_speed and "Active 🟢" or "Inactive 🔴"))

    if initChoice == nil then
        gg.sleep(100)
        gg.setVisible(false)
        return
    end

    if initChoice == 3 then
        L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/DC.lua').content
        if not L then 
            gg.alert('🌐 Server: Please enable internet connection...')
        else
            pcall(load(L))
        end
        return
    end

    if initChoice == 2 then
        -- Reset speed hack
        if #speed_backup == 0 or #speed_edits == 0 or original_value == nil then
            gg.toast("⚠️ Not enough data to reset speed hack!")
            return
        end
        gg.setValues(speed_backup)
        gg.removeListItems(speed_edits)
        speed_edits = {}
        speed_backup = {}
        speed_addresses = {}
        status_speed = false
        original_value = nil
        gg.clearResults()
        gg.toast("✅ Speed hack reverted!")
        return
    end

    -- Activate speed hack
    if not status_speed then
        -- If not previously searched
        if #speed_addresses == 0 then
            gg.clearResults()
            gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
            gg.searchNumber("8295", gg.TYPE_DWORD)
            local paneyoi = gg.getResults(50000)

            if #paneyoi == 0 then
                gg.clearResults()
                gg.toast("❌ Error: No results found!")
                return
            end

            for i = 1, #paneyoi do
                paneyoi[i].address = paneyoi[i].address + 0x60
            end

            gg.loadResults(paneyoi)
            gg.refineNumber("5", gg.TYPE_DWORD)
            local fix = gg.getResults(10000)

            if #fix == 0 then
                gg.clearResults()
                gg.toast("❌ Error: No data found!")
                return
            end

            for i = 1, #fix do
                fix[i].address = fix[i].address + 0x18
            end

            gg.loadResults(fix)

            -- List of values to check sequentially with corresponding revert values
            local values_to_check = {
                { search = "1065353216", revert = 1.0 }, -- x1
                { search = "1073741824", revert = 1.0 }, -- x2
                { search = "1077936128", revert = 1.0 }, -- x3
                { search = "1082130432", revert = 1.0 }, -- x4
                { search = "1084227584", revert = 1.0 }, -- x5
                { search = "1086324736", revert = 1.0 }, -- x6
                { search = "1092616192", revert = 1.0 }, -- x10
                { search = "1097859072", revert = 1.0 }, -- x15
                { search = "1101004800", revert = 1.0 }, -- x20
                { search = "1103626240", revert = 1.0 } -- x25
            }

            local found = {}
            -- Try each value one by one until valid results are found
            for _, entry in ipairs(values_to_check) do
                gg.clearResults()
                gg.loadResults(fix)
                gg.refineNumber(entry.search, gg.TYPE_DWORD)
                found = gg.getResults(100)

                if #found > 0 then
                    -- Check offset -8 for value 0 (validation)
                    local valid = {}
                    for i, v in ipairs(found) do
                        local check = {
                            { address = v.address - 0x8, flags = gg.TYPE_DWORD }
                        }
                        local checkValues = gg.getValues(check)
                        if checkValues[1].value == 0 then
                            table.insert(valid, {
                                address = v.address,
                                flags = gg.TYPE_FLOAT
                            })
                        end
                    end

                    if #valid > 0 then
                        speed_addresses = valid
                        original_value = entry.revert -- Store the revert value
                        break -- Exit loop if valid results are found
                    end
                end
            end

            if #speed_addresses == 0 then
                gg.clearResults()
                gg.toast("❌ Error: No time data found!")
                return
            end
        end

        -- Speed selection menu
        local speedOptions = {
            "⚡ Speed x2",
            "⚡ Speed x4",
            "⚡ Speed x5",
            "⚡ Speed x6",
            "⚡ Speed x10",
            "⚡ Speed x15",
            "⚡ Speed x20",
            "⚡ Speed x25",
            "⬅️ Back to menu"
        }
        
        local speedChoice = gg.choice(speedOptions, nil, "✨Choose Speed:")
        
        if speedChoice == nil or speedChoice == 9 then
            return -- Back to main menu
        end

        -- Set speed value based on choice
        local selected = 1
        if speedChoice == 1 then
            selected = 2
        elseif speedChoice == 2 then
            selected = 4
        elseif speedChoice == 3 then
            selected = 5
        elseif speedChoice == 4 then
            selected = 6
        elseif speedChoice == 5 then
            selected = 10
        elseif speedChoice == 6 then
            selected = 15
        elseif speedChoice == 7 then
            selected = 20
        elseif speedChoice == 8 then
            selected = 25
        end

        -- Set new values and freeze
        local edits = {}
        local backup = {}
        for i, v in ipairs(speed_addresses) do
            table.insert(edits, {
                address = v.address,
                name = "Speedhack",
                flags = gg.TYPE_FLOAT,
                value = selected,
                freeze = true
            })
            table.insert(backup, {
                address = v.address,
                flags = gg.TYPE_FLOAT,
                value = original_value, -- Revert to the mapped value
                freeze = false
            })
        end

        gg.setValues(edits)
        gg.addListItems(edits)

        -- Save to global variables
        speed_edits = edits
        speed_backup = backup
        status_speed = true
        gg.clearResults()
        gg.toast("🚀 Speed hack activated! Speed Sucessfully Changed to: x" .. selected)
    else
        -- If speed hack is already on, allow changing speed
        local speedOptions = {
            "⚡ Speed x2",
            "⚡ Speed x4",
            "⚡ Speed x5",
            "⚡ Speed x6",
            "⚡ Speed x10",
            "⚡ Speed x15",
            "⚡ Speed x20",
            "⚡ Speed x25",
            "⬅️ Back to menu"
        }
        
        local speedChoice = gg.choice(speedOptions, nil, "✨ Change Speed:")
        
        if speedChoice == nil or speedChoice == 9 then
            return -- Back to main menu
        end

        local selected = 1
        if speedChoice == 1 then
            selected = 2
        elseif speedChoice == 2 then
            selected = 4
        elseif speedChoice == 3 then
            selected = 5
        elseif speedChoice == 4 then
            selected = 6
        elseif speedChoice == 5 then
            selected = 10
        elseif speedChoice == 6 then
            selected = 15
        elseif speedChoice == 7 then
            selected = 20
        elseif speedChoice == 8 then
            selected = 25
        end

        local edits = {}
        for i, v in ipairs(speed_addresses) do
            table.insert(edits, {
                address = v.address,
                name = "Speed Hack",
                flags = gg.TYPE_FLOAT,
                value = selected,
                freeze = true
            })
        end

        gg.setValues(edits)
        gg.addListItems(edits)
        speed_edits = edits
        gg.clearResults()
        gg.toast("⚡ Speed hack updated! Speed Successfully Changed to: x" .. selected)
    end
end

-- Main loop
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        ch1()
    end
end