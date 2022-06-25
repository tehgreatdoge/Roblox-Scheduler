local Scheduler = {}
local Tasks = {}

local RunService = game:GetService("RunService")
local Task = require(script.Task)

Scheduler.Task = script.Task

RunService.Heartbeat:Connect(function(deltaT)
    for index,task in pairs(Tasks) do
        task.elapsedTime += deltaT * 1000
        if (task.canceled) then
            table.remove(Tasks,table.find(Tasks,task))
            continue
        end
        if (task.elapsedTime >= task.interval) then
            task.elapsedTime -= task.interval
            local success,err = pcall(task.callback)
            if not success then
                warn(err)
            end
            if task.repeats == -1 then
                continue
            elseif task.repeats == 0 then
                table.remove(Tasks,table.find(Tasks,task))
                continue
            else
                task.repeats -= 1
                continue
            end
        end
    end
end)
function Scheduler.setInterval(interval,callback)
    local task = Task.new(interval,-1,callback)
    table.insert(Tasks,task)
    return(task)
end
function Scheduler.setTimeout(timeout,callback)
    local task = Task.new(timeout,0,callback)
    table.insert(Tasks,task)
    return(task)
end
function Scheduler.addTask(task)
    table.insert(Tasks,task)
end

return Scheduler
