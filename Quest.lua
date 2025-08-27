--------------------------------------------------
-- Shared Functions and Dragon Data Management 🐉
--------------------------------------------------
local function waitForResume()
  gg.toast("⏸️ Script paused. Tap GG icon to continue!", true)
  while not gg.isVisible() do
    gg.sleep(100)
  end
  gg.setVisible(false)
end

-- For search steps: if cancelled, return to main menu.
local function safePromptSearch(prompts, defaults, types)
  local input = gg.prompt(prompts, defaults, types)
  if input == nil then
    gg.toast("↩️ Returning to main menu...", true)
    waitForResume()
    return nil
  end
  return input
end

local function safeChoiceSearch(items, default, title)
  local choice = gg.choice(items, default, title)
  if choice == nil then
    gg.toast("↩️ Returning to main menu...", true)
    waitForResume()
    return nil
  end
  return choice
end

-- For numeric input steps: loop until valid input is provided.
local function safePromptLoop(prompts, defaults, types)
  local input = gg.prompt(prompts, defaults, types)
  while input == nil do
    gg.toast("⏸️ Script paused. Tap GG icon to continue!", true)
    waitForResume()
    input = gg.prompt(prompts, defaults, types)
  end
  return input
end

local function fetchDragonData()
  local response = gg.makeRequest("https://dunggcomet.github.io/DC-Script/Website/Dragon")
  if not response or not response.content then
    gg.alert("⚠️ Failed to load dragon data from server!")
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

  local input = safePromptSearch({"🔍 Enter dragon name to search:"}, {""}, {"text"})
  if input == nil then
    return nil
  end
  
  local searchTerm = input[1]:lower()
  local matches, codes = {}, {}
  for _, dragon in ipairs(globalDragonData) do
    if dragon.name:lower():find(searchTerm, 1, true) then
      table.insert(matches, "📋 " .. dragon.code .. " - " .. dragon.name)
      table.insert(codes, dragon.code)
    end
  end
  
  if #matches == 0 then
    gg.alert("⚠️ No dragons found for: " .. searchTerm)
    return nil
  end
  
  local choice = nil
  repeat
    choice = gg.choice(matches, nil, "Select Your Dragon:")
    if choice == nil then
      gg.toast("⏸️ Selection paused. Tap GG icon to continue!", true)
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

  local input = safePromptLoop({"🔍 Enter 1st dragon name:"}, {""}, {"text"})
  local searchTerm = input[1]:lower()
  local matches, codes = {}, {}
  for _, dragon in ipairs(globalDragonData) do
    if dragon.name:lower():find(searchTerm, 1, true) then
      table.insert(matches, "📋 " .. dragon.code .. " - " .. dragon.name)
      table.insert(codes, dragon.code)
    end
  end

  if #matches == 0 then
    gg.alert("⚠️ No dragons found for: " .. searchTerm)
    return nil
  end

  local choice = nil
  repeat
    choice = gg.choice(matches, nil, "Select 1st Dragon:")
    if choice == nil then
      gg.toast("⏸️ Selection paused. Tap GG icon to continue!", true)
      waitForResume()
    end
  until choice ~= nil

  return codes[choice]
end

local function searchDragonCodeLooop()
  if not globalDragonData then
    globalDragonData = fetchDragonData()
    if not globalDragonData then return nil end
  end

  local input = safePromptLoop({"🔍 Enter 2nd dragon name:"}, {""}, {"text"})
  local searchTerm = input[1]:lower()

  local matches, codes = {}, {}
  for _, dragon in ipairs(globalDragonData) do
    if dragon.name:lower():find(searchTerm, 1, true) then
      table.insert(matches, "📋 " .. dragon.code .. " - " .. dragon.name)
      table.insert(codes, dragon.code)
    end
  end

  if #matches == 0 then
    gg.alert("⚠️ No dragons found for: " .. searchTerm)
    return nil
  end

  local choice
  repeat
    choice = gg.choice(matches, nil, "Select 2nd Dragon:")
    if choice == nil then
      gg.toast("⏸️ Selection paused. Tap GG icon to continue!", true)
      waitForResume()
    end
  until choice ~= nil

  return codes[choice]
end

local function searchDragonCodeLoooop()
  if not globalDragonData then
    globalDragonData = fetchDragonData()
    if not globalDragonData then return nil end
  end

  local input = safePromptLoop({"🔍 Enter 3rd dragon name:"}, {""}, {"text"})
  local searchTerm = input[1]:lower()

  local matches, codes = {}, {}
  for _, dragon in ipairs(globalDragonData) do
    if dragon.name:lower():find(searchTerm, 1, true) then
      table.insert(matches, "📋 " .. dragon.code .. " - " .. dragon.name)
      table.insert(codes, dragon.code)
    end
  end

  if #matches == 0 then
    gg.alert("⚠️ No dragons found for: " .. searchTerm)
    return nil
  end

  local choice
  repeat
    choice = gg.choice(matches, nil, "Select 3rd Dragon:")
    if choice == nil then
      gg.toast("⏸️ Selection paused. Tap GG icon to continue!", true)
      waitForResume()
    end
  until choice ~= nil

  return codes[choice]
end

local function searchDragonCodeLooooop()
  if not globalDragonData then
    globalDragonData = fetchDragonData()
    if not globalDragonData then return nil end
  end

  local input = safePromptSearch({"🔍 Enter final dragon name:"}, {""}, {"text"})
  if input == nil then
    return nil
  end
  
  local searchTerm = input[1]:lower()
  local matches, codes = {}, {}
  for _, dragon in ipairs(globalDragonData) do
    if dragon.name:lower():find(searchTerm, 1, true) then
      table.insert(matches, "📋 " .. dragon.code .. " - " .. dragon.name)
      table.insert(codes, dragon.code)
    end
  end
  
  if #matches == 0 then
    gg.alert("⚠️ No dragons found for: " .. searchTerm)
    return nil
  end
  
  local choice = nil
  repeat
    choice = gg.choice(matches, nil, "Select Final Dragon:")
    if choice == nil then
      gg.toast("⏸️ Selection paused. Tap GG icon to continue!", true)
      waitForResume()
    end
  until choice ~= nil
  
  return codes[choice]
end

local backupRankUpValues = {}       -- { [address] = {value = originalValue, flags = TYPE} }
local rankUpBaseAddresses = {}      -- list of base addresses modified by doRankUp

local function revertAllRankUp()
  if next(backupRankUpValues) == nil then
    gg.alert("ℹ️ No previous modifications to revert.")
    return
  end

  local restoredCount = 0
  for addr, entry in pairs(backupRankUpValues) do
    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
    gg.setValues({{
      address = addr,
      flags   = entry.flags,
      value   = entry.value
    }})
    restoredCount = restoredCount + 1
    backupRankUpValues[addr] = nil
  end

  gg.toast(string.format("✅ Restored %d original values!", restoredCount), true)
  rankUpBaseAddresses = {}
end

local function featureChangeFinalDragon()
  if #rankUpBaseAddresses == 0 then
    gg.alert("⚠️ Quest Mod (RankUp) not yet executed. Run it first!")
    return
  end

  local newCodeStr = searchDragonCode()
  if not newCodeStr then
    gg.alert("⚠️ No dragon selected. Operation cancelled.")
    return
  end
  local newCode = tonumber(newCodeStr)
  if not newCode then
    gg.alert("⚠️ Invalid dragon code selected.")
    return
  end

  local savedCount = 0
  local toSave = {}
  for _, baseAddr in ipairs(rankUpBaseAddresses) do
    local targetAddr = baseAddr + 0xA0  -- Updated to use 0xA0 offset
    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
    gg.setValues({{address = targetAddr, flags = gg.TYPE_DWORD, value = newCode}})

    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
    local curr = gg.getValues({{address = targetAddr, flags = gg.TYPE_DWORD}})
    if curr and curr[1] then
      table.insert(toSave, {
        address = targetAddr,
        flags   = gg.TYPE_DWORD,
        value   = curr[1].value
      })
      savedCount = savedCount + 1
    end
  end

  if #toSave > 0 then
    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
    gg.addListItems(toSave)
    gg.toast(string.format("✅ Updated %d dragon codes successfully!", savedCount), true)
  else
    gg.alert("⚠️ Failed to update dragon codes.")
  end
end

local function doRankUp()
  gg.setVisible(false)
  gg.clearResults()
  rankUpBaseAddresses = {}        -- reset from any prior run

  local selectedCode = searchDragonCodeLoop()
  if not selectedCode then return end
  local extraCode = searchDragonCodeLooop()
  if not extraCode then return end
  local bonusCode = searchDragonCodeLoooop()
  if not bonusCode then return end

  local IDRong  = safePromptLoop({'🔎 1st Dragon Level', '🌟 1st Dragon Grade'}, {nil, nil}, {'number', 'number'})
  local IDRong2 = safePromptLoop({'🔎 2nd Dragon Level', '🌟 2nd Dragon Grade'}, {nil, nil}, {'number', 'number'})
  local IDRong3 = safePromptLoop({'🔎 3rd Dragon Level', '🌟 3rd Dragon Grade'}, {nil, nil}, {'number', 'number'})

  local finalDragonCode = nil
  while finalDragonCode == nil do
    gg.toast("🐲 Select final dragon to proceed.", true)
    finalDragonCode = searchDragonCodeLooooop()
    if not finalDragonCode then
      gg.toast("⏸️ Script paused. Tap GG icon to continue!", true)
      gg.setVisible(true)
      while not gg.isVisible() do
        gg.sleep(100)
      end
      gg.setVisible(false)
    end
  end
  finalDragonCode = tonumber(finalDragonCode)
  if not finalDragonCode then
    gg.alert("⚠️ Invalid final dragon code selected.")
    return
  end

  ---- Phase 1: Search & Collect Modifications ----
  gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
  gg.searchNumber(
    selectedCode .. ";" ..
    IDRong[1]  .. ";" ..
    IDRong[2]  .. ";" ..
    extraCode .. ";" ..
    IDRong2[1] .. ";" ..
    IDRong2[2] .. ";" ..
    bonusCode .. ";" ..
    IDRong3[1] .. ";" ..
    IDRong3[2] .. "::221",
    gg.TYPE_DWORD
  )
  gg.refineNumber(
    selectedCode .. ";" ..
    IDRong[1]  .. ";" ..
    IDRong[2]  .. ";" ..
    extraCode .. ";" ..
    IDRong2[1] .. ";" ..
    IDRong2[2] .. "::110",
    gg.TYPE_DWORD
  )
  gg.refineNumber(
    selectedCode .. ";" ..
    IDRong[1]  .. ";" ..
    IDRong[2]  .. "::55",
    gg.TYPE_DWORD
  )
  gg.refineNumber(selectedCode, gg.TYPE_DWORD)

  local gat = gg.getResults(1000)
  if not gat or #gat == 0 then
    gg.alert("⚠️ No matching entries found for Quest Mod.")
    return
  end

  -- Determine if any offset+4 > 0
  local hasPositiveValue = false
  for _, v in ipairs(gat) do
    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
    local offsetValue1 = gg.getValues({{address = v.address + 0x4, flags = gg.TYPE_DWORD}})
    if offsetValue1 and offsetValue1[1] and offsetValue1[1].value > 0 then
      hasPositiveValue = true
      break
    end
  end

  -- Gather instructions per entry
  local modifications = {}
  for _, v in ipairs(gat) do
    local baseAddr = v.address

    -- Read multiple values at once for better validation
    local offsets = gg.getValues({
        {address = baseAddr + 0x4, flags = gg.TYPE_DWORD},  -- off1
        {address = baseAddr + 0x8, flags = gg.TYPE_DWORD},  -- off2
        {address = baseAddr + 0xC, flags = gg.TYPE_DWORD},  -- Additional check
        {address = baseAddr + 0x10, flags = gg.TYPE_DWORD}  -- Additional check
    })

    -- Validate all values exist
    if not offsets[1] or not offsets[2] or not offsets[3] or not offsets[4] then
        gg.toast(string.format("Skipped entry at 0x%X: Invalid offset values", baseAddr), true)
        goto skip_entry
    end

    local off1 = offsets[1].value
    local off2 = offsets[2].value
    local off3 = offsets[3].value
    local off4 = offsets[4].value

    local offsetsToBackup, writeInstructions

    -- 1. Check for the special case first (most specific)
    if off1 == IDRong[1] and off2 == 0 then
        offsetsToBackup = {0x0, 0x4, 0x10, 0x3C, 0x40, 0x50, 0x78, 0x7C, 0x88, 0x90}
        writeInstructions = {
            {0x0,  1011}, {0x4, 1},   {0x10, 0},
            {0x3C, 1011}, {0x40, 1},  {0x50, 0},
            {0x78, finalDragonCode}, {0x7C, 999},
            {0x88, 5},   {0x90, 500}
        }
    
    -- 2. Check for the -1 pattern (specific)
    elseif not hasPositiveValue and off1 == -1 then
        offsetsToBackup = {0x0, 0x8, 0x10, 0x50, 0x58, 0x60, 0xA0, 0xA8, 0xB0, 0xB8}
        writeInstructions = {
            {0x0,  1011}, {0x8, 1},   {0x10, 0},
            {0x50, 1011}, {0x58, 1},  {0x60, 0},
            {0xA0, finalDragonCode}, {0xA8, 999},
            {0xB0, 5},   {0xB8, 500}
        }
    
    -- 3. Check for matching level pattern
    elseif off1 > 0 and off2 == IDRong[1] then
        offsetsToBackup = {0x0, 0x8, 0x10, 0x50, 0x58, 0x60, 0xA0, 0xA8, 0xB0, 0xB8}
        writeInstructions = {
            {0x0,  1011}, {0x8, 1},   {0x10, 0},
            {0x50, 1011}, {0x58, 1},  {0x60, 0},
            {0xA0, finalDragonCode}, {0xA8, 999},
            {0xB0, 5},   {0xB8, 500}
        }
    
    -- 4. Check for non-matching level pattern
    elseif off1 > 0 and off2 ~= IDRong[1] then
        offsetsToBackup = {0x0, 0x4, 0x10, 0x50, 0x54, 0x60, 0xA0, 0xA4, 0xB0, 0xB8}
        writeInstructions = {
            {0x0,  1011}, {0x4, 1},   {0x10, 0},
            {0x50, 1011}, {0x54, 1},  {0x60, 0},
            {0xA0, finalDragonCode}, {0xA4, 999},
            {0xB0, 5},   {0xB8, 500}
        }
    
    -- 5. Fallback for zero pattern (least specific)
    elseif

 off2 == 0 then
        offsetsToBackup = {0x0, 0x4, 0x8, 0xC, 0x10, 0x50, 0x54, 0x58, 0x5C, 0x60}
        writeInstructions = {
            {0x0,  1011}, {0x4, 1},   {0x10, 0},
            {0x50, 1011}, {0x54, 1},  {0x60, 0},
            {0xA0, finalDragonCode}, {0xA4, 999},
            {0xB0, 5},   {0xB8, 500}
        }
    
    else
        gg.toast(string.format("Skipped entry at 0x%X: off1=%d, off2=%d", 
                              baseAddr, off1, off2), true)
        goto skip_entry
    end

    table.insert(modifications, {
        baseAddr = baseAddr,
        offsetsToBackup = offsetsToBackup,
        writeInstructions = writeInstructions
    })

    ::skip_entry::
  end

  if #modifications == 0 then
    gg.alert("⚠️ No valid Quest Mod entries to modify.")
    return
  end

  ---- Phase 1b: Backup originals (all entries) ----
  local backupCount = 0
  for _, mod in ipairs(modifications) do
    table.insert(rankUpBaseAddresses, mod.baseAddr)

    for _, off in ipairs(mod.offsetsToBackup) do
      local addrToBackup = mod.baseAddr + off
      gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
      local orig = gg.getValues({{address = addrToBackup, flags = gg.TYPE_DWORD}})
      if orig and orig[1] then
        if not backupRankUpValues[addrToBackup] then
          backupRankUpValues[addrToBackup] = { value = orig[1].value, flags = gg.TYPE_DWORD }
          backupCount = backupCount + 1
        end
      end
    end
  end

  if backupCount == 0 then
    gg.alert("⚠️ Failed to back up original values. Quest Mod aborted.")
    return
  end
  gg.toast(string.format("✅ Backed up %d values successfully!", backupCount), true)

  ---- Phase 2: Apply writes & save new values (no freeze) ----
  local savedCount = 0
  for _, mod in ipairs(modifications) do
    local baseAddr = mod.baseAddr

    for _, inst in ipairs(mod.writeInstructions) do
      gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
      gg.setValues({{address = baseAddr + inst[1], flags = gg.TYPE_DWORD, value = inst[2]}})
    end

    local valuesToSave = {}
    for _, inst in ipairs(mod.writeInstructions) do
      local addrToSave = baseAddr + inst[1]
      gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
      local current = gg.getValues({{address = addrToSave, flags = gg.TYPE_DWORD}})
      if current and current[1] then
        table.insert(valuesToSave, {
          address = addrToSave,
          flags   = gg.TYPE_DWORD,
          value   = current[1].value
        })
        savedCount = savedCount + 1
      end
    end

    if #valuesToSave > 0 then
      gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
      gg.addListItems(valuesToSave)
    end
  end

  gg.toast(string.format("🎉 Quest Mod completed! Saved %d values.", savedCount), true)
  gg.sleep(1500)
end

local function featureRankUpMenu()
  while true do
    local choice = gg.choice(
      {'🚀 Run Quest Mod (RankUp)',
       '🔄 Revert All Quest Mod Changes',
       '🐉 Update Final Dragon Code',
       '↩️ Back to Main Menu'},
      nil,
      'Quest Script Made By Comet💫💗\n🔧 Quest Mod (RankUp) Options:'
    )
    if choice == nil then
      gg.toast('⏸️ Resuming Quest Mod menu...', true)
      waitForResume()
    elseif choice == 1 then
      doRankUp()
    elseif choice == 2 then
      revertAllRankUp()
    elseif choice == 3 then
      featureChangeFinalDragon()
    elseif choice == 4 then
      return
    end
  end
end
--- End Quest Mod (RankUp) ---
featureRankUpMenu()