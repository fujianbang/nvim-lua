local loadDirectoryModules = function ()
    require('core.options')
    require('mapping')
    require('core.pack')
end

local initialize = function ()
    loadDirectoryModules()
end


--initialize
initialize()
