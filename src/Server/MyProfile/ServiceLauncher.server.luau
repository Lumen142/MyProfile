local services = script.Parent.services

for _,v in pairs(services:GetChildren()) do
    require(v)
end
