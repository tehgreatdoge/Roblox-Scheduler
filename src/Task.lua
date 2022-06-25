local Task = {}
Task.__index = Task

function Task.new(interval,repeats,callback)
    local newTask = {}
    setmetatable(newTask,Task)
    newTask.interval = interval
    newTask.repeats = repeats
    newTask.elapsedTime = 0
    newTask.callback = callback
    print(newTask.Cancel)
    return newTask
end
function Task:Cancel()
    if (self) then
        self.canceled = true
    end
end

return Task
