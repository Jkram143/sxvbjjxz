-- Combined Dragon City Ultimate Mod with Test Skill Integration & Revert Paste Feature
gg.setVisible(false)

local path = "/storage/emulated/0/Download/2.0.txt"
local oldPath = "/storage/emulated/0/Download/1.9.txt"
local file = io.open(path, "r")

if file then
    file:close()
else
    gg.alert("🚀 A new update (Version 2.0) is available! Please install it now!\n✨ What's New:\n-Fixed Arena And Quest Feature Completely!\nQuest only works with permanently quest currently\nNote: Please install Dragon City to the latest version before using!", "Update")

    gg.toast("Installing update...")
    gg.searchNumber(":updateversion", gg.TYPE_AUTO)
    gg.sleep(2000)

    -- Remove old version file
    os.remove(oldPath)

    local newFile = io.open(path, "w")
    if newFile then
        newFile:write("Version 20")
        newFile:close()
        gg.alert("Update installed successfully!")
    else
        gg.alert("An error occurred during the update process.")
    end
end

gg.clearResults()
gg.setVisible(false)
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local MD5 = gg.makeRequest('').content
function Main()
    menu = gg.choice({
        '⚔️ Battle Arena Feature', --1
        '🔓 Unlock Frozen Values', --2
        '🔎 High Level Dragon', --3
        '🐲 Force Recall Dragon', --4
        '🔑 Dragon Rescue Feature', --5
        '➡️ Test & Train Dragon/Skill Feature', --6
        '🏁 Event Race', --7
        '🏔️ Move Habitat', --8
        ' 🏝️ Expand all Unlocked 🔓', --9
        '⚡ Speedhack Feature',
        '🗡️ Quest Feature ( Rankup )',
        '💬 Join Our Discord Community'
    }, nil, '✨Dragon City Script Version 1.9\n💫Script Made By Jkram143 💗\nDragon City ( 25.10.1 )')
    if menu == 1 then DragonCityHack1() end
    if menu == 2 then DragonCityHack2() end
    if menu == 3 then DragonCityHack10() end
    if menu == 4 then DragonCityHack4() end
    if menu == 5 then DragonCityHack5() end
    if menu == 6 then DragonCityHack6() end
    if menu == 7 then DragonCityHack7() end
    if menu == 8 then DragonCityHack8() end
    if menu == 9 then DragonCityHack12() end
    if menu == 10 then DragonCityHack9() end
    if menu == 11 then DragonCityHack3() end
    if menu == 12 then DragonCityHack11() end
    if menu == nil then NoSelect() end
end

function DragonCityHack1()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/Arena.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack2()
    gg.setVisible(false)
    local frozenItems = gg.getListItems()
    if #frozenItems > 0 then
        gg.removeListItems(frozenItems)
        gg.toast('All values have been unfrozen!')
    else
        gg.toast('No frozen values found!')
    end
end

function DragonCityHack3()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/Quest.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack4()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/Recall.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack5()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/Rescue.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack6()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/TrainSkill.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack7()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/HeroicChoose.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack10()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/maxlvl.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack8()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/Habitat.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack9()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/Speed.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack11()
    L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/Help.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end

function DragonCityHack12()
L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/Expand.lua').content
    if not L then gg.alert('SERVER: Allow Internet Connection...') else
        pcall(load(L)) end
end
function NoSelect()
    gg.sleep(100)
    gg.toast('Script Made By Jkram143💗')
end

-------------------------------------------------------------------------
        gg.setVisible(true)
        while true do
        if gg.isVisible() then
        gg.setVisible(false)
        Main()
    end
end
-------------------------------------------------------------------------
