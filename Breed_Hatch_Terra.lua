gg.toast("Searching..")

function speedUpTerra()
    gg.clearResults()
    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
    gg.searchNumber("279172875251", gg.TYPE_QWORD)
    local results = gg.getResults(1)
    if #results == 0 then
        gg.toast("Not found!")
        return
    end

    local base = results[1].address

    local is64Bit = gg.getTargetInfo().x64
    local addr1, addr2, addr3

    if is64Bit then
        addr1 = base + 0x34
        addr2 = base + 0x3C
    else
        addr1 = base + 0x2C
        addr2 = base + 0x30
    end

    local edits = {
        {address = addr1, flags = gg.TYPE_QWORD, value = 3},
        {address = addr2, flags = gg.TYPE_QWORD, value = 3}
    }

    gg.setValues(edits)
    gg.clearResults()
    gg.toast("Done")
    gg.toast("Thanks for Using My Script")
end

speedUpTerra()