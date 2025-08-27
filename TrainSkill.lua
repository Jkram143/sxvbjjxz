-- TestSkillMod.lua
-- This file contains only the Test/Skill Mod features and its minimal dependencies.
gg.setVisible(false)
--------------------------------------------------
-- Shared Helper Functions & Dragon Data Management
--------------------------------------------------
local function waitForResume()
  gg.toast("Script paused. Click GG icon to resume", true)
  while not gg.isVisible() do
    gg.sleep(100)
  end
  gg.setVisible(false)
end

local function safePromptSearch(prompts, defaults, types)
  local input = gg.prompt(prompts, defaults, types)
  while not input do
    gg.toast("Script paused. Tap GG icon to resume.", true)
    waitForResume()
    -- Wait until GG is not visible anymore before re-prompting.
    while gg.isVisible() do
      gg.sleep(100)
    end
    gg.sleep(1000)  -- Extra delay may help to reset the prompt state.
    input = gg.prompt(prompts, defaults, types)
  end
  return input
end

local function safeChoiceSearch(items, default, title)
  local choice = gg.choice(items, default, title)
  if choice == nil then
    gg.toast("Returning to main menu...", true)
    waitForResume()
    return nil
  end
  return choice
end

local function safePromptLoop(prompts, defaults, types)
  local input = gg.prompt(prompts, defaults, types)
  while input == nil do
    gg.toast("Script paused. Click GG icon to resume", true)
    waitForResume()
    input = gg.prompt(prompts, defaults, types)
  end
  return input
end

local function fetchDragonData()
  local response = gg.makeRequest("https://dunggcomet.github.io/DC-Script/Website/Dragon")
  if not response or not response.content then
    gg.alert("Failed to download dragon data!")
    return nil
  end
  local data = {}
  for match in response.content:gmatch("<div class='dragon%-item'>(.-)</div>") do
    local cleaned = match:gsub("<[^>]+>", ""):gsub("-", ""):gsub("^%s+", ""):gsub("%s+$", "")
    if cleaned:match("^%d") then
      local code, name = cleaned:match("^(%d+)%s+(.+)$")
      if code and name then
        table.insert(data, {code = code, name = name})
      end
    end
  end
  return #data > 0 and data or nil
end

local globalDragonData = fetchDragonData()

local function getDragonNameFromCode(code)
  if not globalDragonData then return "Undefined Dragon" end
  for _, dragon in ipairs(globalDragonData) do
    if dragon.code == tostring(code) then
      return dragon.name
    end
  end
  return "Undefined Dragon"
end

local function searchDragonCode()
  if not globalDragonData then
    globalDragonData = fetchDragonData()
    if not globalDragonData then return nil end
  end

  local input = safePromptSearch({"Enter dragon name:"}, {""}, {"text"})
  if input == nil then return nil end
  
  local searchTerm = input[1]:lower()
  local matches, codes = {}, {}
  for _, dragon in ipairs(globalDragonData) do
    if dragon.name:lower():find(searchTerm, 1, true) then
      table.insert(matches, "📋 " .. dragon.code .. " - " .. dragon.name)
      table.insert(codes, dragon.code)
    end
  end
  
  if #matches == 0 then
    gg.alert("No dragons found for: " .. searchTerm)
    return nil
  end
  
  local choice = nil
  repeat
    choice = gg.choice(matches, nil, "Select Dragon")
    if choice == nil then
      gg.toast("Selection paused. Tap GG icon to resume.", true)
      waitForResume()
    end
  until choice ~= nil
  
  return codes[choice]
end

local function searchDragonCodeLoop()
  if not globalDragonData then
    globalDragonData = fetchDragonData()
    if not globalDragonData then return nil end
  end

  local input = safePromptLoop({"Enter dragon name:"}, {""}, {"text"})
  local searchTerm = input[1]:lower()
  local matches, codes = {}, {}
  for _, dragon in ipairs(globalDragonData) do
    if dragon.name:lower():find(searchTerm, 1, true) then
      table.insert(matches, "📋 " .. dragon.code .. " - " .. dragon.name)
      table.insert(codes, dragon.code)
    end
  end

  if #matches == 0 then
    gg.alert("No dragons found for: " .. searchTerm)
    return nil
  end

  local choice = nil
  repeat
    choice = gg.choice(matches, nil, "Select Dragon")
    if choice == nil then
      gg.toast("Selection paused. Tap GG icon to resume.", true)
      waitForResume()
    end
  until choice ~= nil

  return codes[choice]
end

--------------------------------------------------
-- Test/Skill Mod Functions & Variables
--------------------------------------------------
local copiedAllValues = {}  
local copiedValues = {}
local validResultsTest = {}
local originalCodeTest = nil
local changedCodeTest  = nil
local baseAddress = nil
-- Backup table to store original values before pasting.
local backupPastedValuesTest = {}

local function processMemorySearchTest(selectedCode)
  gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
  gg.searchNumber(selectedCode..";0;-1::150", gg.TYPE_DWORD)
  gg.refineNumber(selectedCode..";0::15", gg.TYPE_DWORD)
  gg.refineNumber(selectedCode, gg.TYPE_DWORD)
  local results = gg.getResults(100)
  validResultsTest = {}
  for _, v in ipairs(results) do
    local offsets = {}
    for i = 1, 15 do
      offsets[i] = gg.getValues({{address = v.address + (i * 4), flags = gg.TYPE_DWORD}})[1].value
    end
    if offsets[1] ~= -1 and offsets[1] ~= 0 and
       offsets[2] ~= -1 and
       offsets[3] ~= -1 and offsets[3] ~= 0 and
       offsets[4] ~= -1 and offsets[4] ~= 0 and
       offsets[5] ~= -1 and offsets[5] ~= 0 and
       offsets[6] ~= -1 and offsets[6] ~= 0 and
       offsets[7] ~= 0 and offsets[7] ~= -1 and
       offsets[8] ~= 0 and
       offsets[9] ~= -1 and offsets[9] ~= 0 and
       offsets[10] ~= -1 and offsets[10] ~= 0 and
       offsets[11] ~= -1 and offsets[11] ~= 0 and
       offsets[12] ~= -1 and offsets[12] ~= 0 and
       offsets[13] ~= -1 and offsets[13] ~= 0 and
       offsets[14] ~= -1 and offsets[14] ~= 0 and
       offsets[15] ~= -1 and offsets[15] ~= 0 and offsets[15] ~= 8 then
      table.insert(validResultsTest, v)
    end
  end
  if #validResultsTest > 0 then
    baseAddress = validResultsTest[1].address
    if #validResultsTest == 1 then
      local single = validResultsTest[1]
      single.name = single.value .. " - " .. getDragonNameFromCode(single.value)
      gg.addListItems(validResultsTest)
    elseif #validResultsTest > 1 and #validResultsTest < 109 then
      for i, v in ipairs(validResultsTest) do
        v.value = 1038 + i
        v.name = v.value .. " - " .. getDragonNameFromCode(v.value)
      end
      gg.setValues(validResultsTest)
      gg.addListItems(validResultsTest)
    elseif #validResultsTest > 108 then
      for _, v in ipairs(validResultsTest) do
        v.value = 1011
        v.name = v.value .. " - " .. getDragonNameFromCode(v.value)
      end
      gg.setValues(validResultsTest)
      gg.addListItems(validResultsTest)
    end
    return true
  end
  return false
end

local function copyOffsetTest()
  local srcChoice = nil
  repeat
    srcChoice = gg.choice({
      'From 1st skill/attack (Base)', 'From 2nd skill/attack (Base)',
      'From 3rd skill/attack (Base)', 'From 4th skill/attack (Base)',
      'From 1st skill/attack (Training center)', 'From 2nd skill/attack (Training center)',
      'From 3rd skill/attack (Training center)', 'From 4th skill/attack (Training center)',
      'Return'
    }, nil, "Copy 1 Source Skill/Attack from ALL Results")
    if srcChoice == nil then
      gg.toast("Paused. Tap GG icon to resume.", true)
      waitForResume()
    end
  until srcChoice ~= nil
  if srcChoice > 8 then return end
  local srcOffset = ({0x20, 0x24, 0x28, 0x2C, 0x30, 0x34, 0x38, 0x3C})[srcChoice]
  copiedValues = {}
  for _, result in ipairs(validResultsTest) do
    local addr = result.address + srcOffset
    local val = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})[1].value
    copiedValues[result.address] = val
  end
end

local function copyAllOffsetTest()
  if not validResultsTest or #validResultsTest == 0 then
    gg.alert("❗ No valid results to copy from!")
    return
  end
  copiedAllValues = {}
  local offs = {0x30, 0x34, 0x38, 0x3C}
  for _, result in ipairs(validResultsTest) do
    local addr = result.address
    local vals = {}
    for _, off in ipairs(offs) do
      vals[off] = gg.getValues({{ address = addr + off, flags = gg.TYPE_DWORD }})[1].value
    end
    copiedAllValues[addr] = vals
  end
end

local function pasteOffsetTest()
  if not next(copiedValues) then
    gg.alert("❗ No copied values! Copy first.")
    return
  end
  local targets = {0x20, 0x24, 0x28, 0x2C}
  for _, result in ipairs(validResultsTest) do
    for _, offset in ipairs(targets) do
      local addr = result.address + offset
      if backupPastedValuesTest[addr] == nil then
         local origVal = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})[1].value
         backupPastedValuesTest[addr] = origVal
      end
      gg.setValues({{address = addr, flags = gg.TYPE_DWORD, value = copiedValues[result.address]}})
    end
  end
end

local function pasteSingleOffsetTest()
  if not next(copiedValues) then
    gg.alert("❗ No copied values! Copy first.")
    return
  end
  local choice = nil
  repeat
    choice = gg.choice({
      'To 1st skill/attack (Base)', 'To 2nd skill/attack (Base)', 
      'To 3rd skill/attack (Base)', 'To 4th skill/attack (Base)',
      'To 1st skill/attack (Training center)', 'To 2nd skill/attack (Training center)',
      'To 3rd skill/attack (Training center)', 'To 4th skill/attack (Training center)',
      'Return'
    }, nil, "Select Target Spot In Training Center for ALL Results")
    if choice == nil then
      gg.toast("Paused. Tap GG icon to resume.", true)
      waitForResume()
    end
  until choice ~= nil
  if choice > 8 then return end
  local targetOffset = ({0x20, 0x24, 0x28, 0x2C, 0x30, 0x34, 0x38, 0x3C})[choice]
  for _, result in ipairs(validResultsTest) do
    local addr = result.address + targetOffset
    if backupPastedValuesTest[addr] == nil then
      local origVal = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})[1].value
      backupPastedValuesTest[addr] = origVal
    end
    gg.setValues({{address = addr, flags = gg.TYPE_DWORD, value = copiedValues[result.address]}})
  end
end

local function pasteAllOffsetTest()
  if not copiedAllValues or next(copiedAllValues) == nil then
    gg.alert("❗ No bulk‑copied values to paste!")
    return
  end
  local mapping = {
    {src=0x30, dst=0x20},
    {src=0x34, dst=0x24},
    {src=0x38, dst=0x28},
    {src=0x3C, dst=0x2C},
  }
  for baseAddr, vals in pairs(copiedAllValues) do
    local ops = {}
    for _, m in ipairs(mapping) do
      table.insert(ops, {
        address = baseAddr + m.dst,
        flags   = gg.TYPE_DWORD,
        value   = vals[m.src]
      })
    end
    gg.setValues(ops)
  end
end

local function revertPastedValuesTest()
   if not next(backupPastedValuesTest) then
      gg.alert("No pasted values to revert!")
      return
   end
   local revertItems = {}
   for addr, origVal in pairs(backupPastedValuesTest) do
       table.insert(revertItems, {address = addr, flags = gg.TYPE_DWORD, value = origVal})
   end
   gg.setValues(revertItems)
   backupPastedValuesTest = {}  -- Clear backup after revert
   gg.toast("Reverted pasted values")
end

local function testSkillMenu()
  while true do
    local menuItems = {
      "🔄 Change Dragon Code",
      "📋 Copy one skill/attack",
      "📚 Copy all skills/attacks",
      "🎨 Apply to All attacks (Mod: One by Four)",
      "🌐 Apply to All attacks (Mod: Four by Four)",
      "🎯 Apply to Single Attack (Train)",
      "🔄 Revert Pasted Values",   -- New option for reverting pasted changes
      "🔍 New Search",
      "⏮ Restore Original Dragon",
      "⏭ Restore Modified Dragon",
      "👋 Exit Test Skill"
    }
    local choice = safeChoiceSearch(menuItems, nil,
      string.format("Base: 0x%X | Current: %s", baseAddress, getDragonNameFromCode(originalCodeTest))
    )
    if choice == 1 then
      local newCode = searchDragonCode()
      if newCode then
        changedCodeTest = newCode
        for _, v in ipairs(validResultsTest) do
          v.value = tonumber(newCode)
          v.name = newCode.." - "..getDragonNameFromCode(newCode)
        end
        gg.setValues(validResultsTest)
        gg.addListItems(validResultsTest)
        gg.toast("Changed to: "..getDragonNameFromCode(newCode))
      end
    elseif choice == 2 then
      copyOffsetTest()
    elseif choice == 3 then
      copyAllOffsetTest()
    elseif choice == 4 then
      pasteOffsetTest()
    elseif choice == 5 then
      pasteAllOffsetTest()
    elseif choice == 6 then
      pasteSingleOffsetTest()
    elseif choice == 7 then
      revertPastedValuesTest()
    elseif choice == 8 then
      gg.clearResults()
      return true  -- New search: return to re-run test skill search
    elseif choice == 9 then
      for _, v in ipairs(validResultsTest) do
        v.value = tonumber(originalCodeTest)
        v.name = originalCodeTest.." - "..getDragonNameFromCode(originalCodeTest)
      end
      gg.setValues(validResultsTest)
      gg.addListItems(validResultsTest)
      gg.toast("Reverted to original dragon")
    elseif choice == 10 then
      if changedCodeTest then
        for _, v in ipairs(validResultsTest) do
          v.value = tonumber(changedCodeTest)
          v.name  = changedCodeTest.." - "..getDragonNameFromCode(changedCodeTest)
        end
        gg.setValues(validResultsTest)
        gg.addListItems(validResultsTest)
        gg.toast("Reverted to changed dragon")
      else
        gg.alert("No changed code to revert to!")
      end
    elseif choice == 11 then
      gg.clearResults()
      gg.toast("Returning To Main Menu..")
      return false
    end
  end
end

local function pickTestSkillResult()
  local choices = {}
  for i, v in ipairs(validResultsTest) do
    table.insert(choices, v.name)
  end

  local chosenIndex = nil
  repeat
    chosenIndex = gg.choice(choices, nil, "Select a dragon entry (only one will be kept).")
    if chosenIndex == nil then
      gg.toast("Selection paused. Tap GG icon to resume.", true)
      waitForResume()  -- Waits until the GG icon is tapped.
    end
  until chosenIndex ~= nil

  -- Revert values for all items, including the selected one.
  for i, v in ipairs(validResultsTest) do
    gg.setValues({{address = v.address, flags = gg.TYPE_DWORD, value = tonumber(originalCodeTest)}})
    v.value = tonumber(originalCodeTest)
  end

  local chosenItem = validResultsTest[chosenIndex]
  validResultsTest = { chosenItem }
  -- keep only items whose value is 1011 or 0; remove all others
  do
    local allItems = gg.getListItems()
    local toRemove = {}
    for _, item in ipairs(allItems) do
      if item.value ~= 1011 and item.value ~= 1 and item.value ~= 0 then
        table.insert(toRemove, item)
      end
    end
    if #toRemove > 0 then
      gg.removeListItems(toRemove)
    end
  end

  gg.addListItems(validResultsTest)
  gg.toast("Selected and reverted: " .. chosenItem.name)
  return chosenItem
end

-- Modified testSkill function integrating pickTestSkillResult.
local function testSkill()
  if not globalDragonData then
    globalDragonData = fetchDragonData()
    if not globalDragonData then
      gg.alert("Failed to load dragon data")
      return
    end
  end
  while true do
    validResultsTest = {}
    originalCodeTest = searchDragonCode()
    if not originalCodeTest then break end
    if processMemorySearchTest(originalCodeTest) then
      local chosen = pickTestSkillResult()
      if not chosen then break end  -- If no selection, exit to main menu.
      local needRestart = testSkillMenu()
      if not needRestart then break end
    else
      gg.alert("No valid memory found")
    end
  end
  do
    local allItems = gg.getListItems()
    local toRemove = {}
    for _, item in ipairs(allItems) do
      if item.value ~= 1011 and item.value ~= 1 and item.value ~= 0 then
        table.insert(toRemove, item)
      end
    end
    if #toRemove > 0 then
      gg.removeListItems(toRemove)
    end
  end

  gg.toast("Returning to main menu...", true)
  gg.sleep(1500)
end
--------------------------------------------------
-- Run the Test Skill Mod
--------------------------------------------------
testSkill()