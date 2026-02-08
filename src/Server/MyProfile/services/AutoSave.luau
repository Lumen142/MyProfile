local module = {
	["reg_req"] = {}
}

local reg_req = module.reg_req

local packages = script.Parent.Parent.packages
local datamanager = require(packages.DataManager)

while true do
	if #reg_req > 0 then
		task.wait(2.5)
	else
		task.wait(5)
	end

	for _, v in pairs(reg_req) do
		datamanager:update(v.id, v.data)
		reg_req[v.id] = nil
	end
end

return module