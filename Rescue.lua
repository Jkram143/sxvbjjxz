gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
gg.searchNumber('1000~5600;-1;1~70;0~5::17', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.refineNumber('1000~5600;-1;1~70::10', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.refineNumber('1000~5600;1~70::10', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.getResults(10000)
gg.editAll('1011;1', gg.TYPE_DWORD)
gg.clearResults()

gg.alert("✅ Dragon Rescue Modification Completed!")