
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function inputs()
local input = {}
local configFile = gg.EXT_CACHE_DIR .. '/' .. 
gg.getFile():match('') .. 'Battle-Dragons-Speed.text'
local data = loadfile(configFile)
if data ~= nil then
  data = data()
end
  input = gg.prompt({
    '🏃‍5min to 0s Speed ( Buggy )',
    '🏃‍15min to 0s Speed ( Buggy )',
    '🏃‍30min to 0s Speed',
    '🏃‍1h to 0s Speed',
    '🏃‍1h 20min to 0s Speed',
    '🏃‍3h to 0s Speed',
    '🏃‍6h 40min to 0s Speed',
    '🏃‍8h to 0s Speed',
    '🚫 Anti Reload',
    '⬅️ Return to Main Menu'
  }, data, {'checkbox','checkbox','checkbox','checkbox','checkbox','checkbox','checkbox','checkbox','checkbox','checkbox'})
  if input == nil then
  else
	gg.saveVariable(input, configFile)
    if input[1] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
	  gg.sleep(5000)
      gg.setRanges(gg.REGION_C_ALLOC)
      gg.setVisible(false)
      gg.searchNumber('2;300;0::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('2;300::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('300', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.getResults(10000)
      gg.editAll('0', gg.TYPE_DWORD)
      gg.setVisible(false)
      gg.clearResults()
      gg.setVisible(true)
    end
    if input[2] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
	  gg.sleep(5000)
      gg.setRanges(gg.REGION_C_ALLOC)
      gg.setVisible(false)
      gg.searchNumber('2;900;0::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('2;900::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('900', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.getResults(10000)
      gg.editAll('0', gg.TYPE_DWORD)
      gg.setVisible(false)
      gg.clearResults()
      gg.setVisible(true)
    end
    if input[3] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
	  gg.sleep(5000)
	  gg.setRanges(gg.REGION_C_ALLOC)
      gg.setVisible(false)
      gg.searchNumber('2;1800;0::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('2;1800::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('1800', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.getResults(10000)
      gg.editAll('0', gg.TYPE_DWORD)
      gg.setVisible(false)
      gg.clearResults()
      gg.setVisible(true)
    end
    if input[4] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
	  gg.sleep(5000)
      gg.setRanges(gg.REGION_C_ALLOC)
      gg.setVisible(false)
      gg.searchNumber('2;3600;0::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('2;3600::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('3600', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.getResults(10000)
      gg.editAll('0', gg.TYPE_DWORD)
      gg.setVisible(false)
      gg.clearResults()
      gg.setVisible(true)
    end
    if input[5] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
	  gg.sleep(5000)
      gg.setRanges(gg.REGION_C_ALLOC)
      gg.setVisible(false)
      gg.searchNumber('2;4800;0::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('2;4800::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('4800', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.getResults(10000)
      gg.editAll('0', gg.TYPE_DWORD)
      gg.setVisible(false)
      gg.clearResults()
      gg.setVisible(true)
    end
    if input[6] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
	  gg.sleep(5000)
      gg.setRanges(gg.REGION_C_ALLOC)
      gg.setVisible(false)
      gg.searchNumber('2;10800;0::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('2;10800::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('10800', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.getResults(10000)
      gg.editAll('0', gg.TYPE_DWORD)
      gg.setVisible(false)
      gg.clearResults()
      gg.setVisible(true)
    end
    if input[7] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
	  gg.sleep(5000)
      gg.setRanges(gg.REGION_C_ALLOC)
      gg.setVisible(false)
      gg.searchNumber('2;24000;0::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('2;24000::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('24000', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.getResults(10000)
      gg.editAll('0', gg.TYPE_DWORD)
      gg.setVisible(false)
      gg.clearResults()
      gg.setVisible(true)
    end
    if input[8] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
	  gg.sleep(5000)
      gg.setRanges(gg.REGION_C_ALLOC)
      gg.setVisible(false)
      gg.searchNumber('2;28800;0::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('2;28800::', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.refineNumber('28800', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.setVisible(false)
      gg.getResults(10000)
      gg.editAll('0', gg.TYPE_DWORD)
      gg.setVisible(false)
      gg.clearResults()
      gg.setVisible(true)
    end
    if input[9] then
      gg.setRanges(gg.REGION_CODE_APP)
      gg.setVisible(false)
      gg.searchNumber(':error', gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
      gg.setVisible(false)
      gg.getResults(100000)
      gg.editAll('0', gg.TYPE_BYTE)
      gg.setVisible(false)
      gg.clearResults()
      gg.toast("Waiting for 20 seconds...")
      gg.sleep(20000)
      gg.setVisible(true)
    end
    if input[10] then
      gg.toast("Returning To Main Menu...")
		L = gg.makeRequest('https://raw.githubusercontent.com/Jkram143/sxvbjjxz/refs/heads/main/DC.lua').content
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
