gg.setVisible(true)
fin_busc = 1
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
gg.refineNumber("9288798", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)

-- Helper Function for Safe Prompt
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
    while gg.isVisible() do
      gg.sleep(100)
    end
    gg.sleep(1000)
    input = gg.prompt(prompts, defaults, types)
  end
  return input
end

-- Dragon Data Fetching and Search Functions
local function fetchDragonData()
  local response = gg.makeRequest("https://dunggcomet.github.io/DC-Script/Website/Dragon")
  if not response or not response.content then
    gg.alert("⚠️ Failed to download dragon data!")
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
  local input = safePromptSearch({"🐉 Enter 1st Dragon name:"}, {""}, {"text"})
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
    gg.alert("⚠️ No dragons found for: " .. searchTerm)
    return nil
  end
  local choice = gg.choice(matches, nil, "Select Dragon")
  if choice == nil then return nil end
  return codes[choice]
end

-- Main execution starts automatically
local function main()
  local dragonCode = searchDragonCode()
  if dragonCode == nil then 
    gg.alert("⚠️ Dragon selection cancelled!")
    os.exit()
  end
  
  -- Prompt for 1st dragon level and stars
  local input1 = safePromptSearch({
    "🔎 1st Dragon Level",
    "🌟 1st Dragon Stars"
  }, {nil, nil}, {"number", "number"})
  
  if input1 == nil or not input1[1] or not input1[2] then 
    gg.alert('⚠️ Invalid input for 1st dragon!')
    os.exit()
  end
  
  -- Prompt for 2nd dragon level and stars only after valid 1st dragon input
  local input2 = safePromptSearch({
    "🔎 2nd Dragon Level",
    "🌟 2nd Dragon Stars"
  }, {nil, nil}, {"number", "number"})
  
  if input2 == nil or not input2[1] or not input2[2] then 
    gg.alert('⚠️ Invalid input for 2nd dragon!')
    os.exit()
  end
  
  local datos = {input1[1], input1[2]}
  local data = {input2[1], input2[2]}
  gg.clearResults()
  gg.searchNumber(dragonCode .. ";" .. datos[1] .. ";" .. datos[2] .. ";" .. data[1] .. ";" .. data[2] .. "::500", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.refineNumber(dragonCode .. ";" .. datos[1] .. ";" .. datos[2] .. ";" .. data[1] .. "::250", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.refineNumber(dragonCode .. ";" .. datos[1] .. ";" .. datos[2] .. "::125", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.refineNumber(dragonCode .. ";" .. datos[1] .. "::60", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.refineNumber(dragonCode, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  point = gg.getResults(500)
  
  if not point or #point == 0 then
    gg.alert('⚠️ No results found for the dragon code!')
  end
  
  gg.addListItems(point)
  gg.clearResults()
  fin_busc = 0
  change_yisus(datos, data)
end

function change_yisus(datos, data)
  if not point or #point == 0 then
    gg.alert('⚠️ No search results found to modify!')
  end

  -- Prepare addresses for condition check
  local checkAddresses = {}
  for i, v in ipairs(point) do
    table.insert(checkAddresses, {address = v.address + 0x24, flags = gg.TYPE_DWORD})
    table.insert(checkAddresses, {address = v.address + 0x84, flags = gg.TYPE_DWORD})
  end
  local checkResults = gg.getValues(checkAddresses)

  -- Configuration sets
  local configSet1 = {  -- When 0x24 ≠ datos[2] AND 0x84 ≠ data[2]
    {offset = 0x0,  value = 1011},
    {offset = 0x4,  value = 1},
    {offset = 0x8,  value = 0},
    {offset = 0x18, value = 0},
    {offset = 0x44, value = 1011},
    {offset = 0x48, value = 1},
    {offset = 0x4C, value = 0},
    {offset = 0x5C, value = 0},
    {offset = 0x88, value = 1011},
    {offset = 0x8C, value = 1},
    {offset = 0x90, value = 0},
    {offset = 0xA0, value = 0}
  }

  local configSet2 = {  -- Original configuration (when condition fails)
    {offset = 0x0,  value = 1011},
    {offset = 0x4,  value = 1},
    {offset = 0x8,  value = 0},
    {offset = 0x24, value = 0},
    {offset = 0x60, value = 1011},
    {offset = 0x64, value = 1},
    {offset = 0x68, value = 0},
    {offset = 0x84, value = 0},
    {offset = 0xC0, value = 1011},
    {offset = 0xC4, value = 1},
    {offset = 0xC8, value = 0},
    {offset = 0xE4, value = 0}
  }

  -- Prepare modifications
  local modifyList = {}
  local freezeList = {}

  for i, v in ipairs(point) do
    local base = v.address
    local idx24 = (i-1)*2 + 1
    local idx84 = (i-1)*2 + 2
    
    -- Get current values at offsets
    local current24 = checkResults[idx24].value
    local current84 = checkResults[idx84].value
    
    -- Select configuration based on values
    local config = configSet2  -- Default to Set2
    if current24 ~= datos[2] and current84 ~= data[2] then
      config = configSet1
    end
    
    -- Apply selected configuration
    for _, item in ipairs(config) do
      local addr = base + item.offset
      table.insert(modifyList, {
        address = addr,
        flags = gg.TYPE_DWORD,
        value = item.value
      })
      table.insert(freezeList, {
        address = addr,
        flags = gg.TYPE_DWORD,
        value = item.value,
        freeze = true
      })
    end
  end

  -- Apply changes in chunks
  local CHUNK_SIZE = 100
  for i = 1, #modifyList, CHUNK_SIZE do
    local chunk = {}
    local endIdx = math.min(i + CHUNK_SIZE - 1, #modifyList)
    for j = i, endIdx do
      table.insert(chunk, modifyList[j])
    end
    gg.setValues(chunk)
  end

  -- Apply freezing in chunks
  for i = 1, #freezeList, CHUNK_SIZE do
    local chunk = {}
    local endIdx = math.min(i + CHUNK_SIZE - 1, #freezeList)
    for j = i, endIdx do
      table.insert(chunk, freezeList[j])
    end
    gg.addListItems(chunk)
  end

  -- Make request to DC.lua
  local L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/DC.lua').content
  if not L then
    gg.alert('SERVER: Allow Internet Connection...')
  else
    pcall(load(L))
  end

  gg.toast('🎉 Battle Arena modification completed!', true)
  gg.sleep(1500)
  gg.toast('💖 Thanks for using my script!', true)
end

-- Start the script automatically
main()