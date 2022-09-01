local benchtools = require(script.Parent.benchtools)

local benchs = game:GetService("ServerStorage").benchs:GetDescendants()
local BENCHMARK = false

local results = {}

task.wait(5)

if BENCHMARK then
    for _, benchscript in benchs do
        local content = require(benchscript)
    
        results[benchscript.Name] = {}
    
        for _, section in content do
            local _, result = benchtools.benchmark(section.calls, section.run, section.prerun or function() end) 
            results[benchscript.Name][section.title] = result
            task.wait()
        end
    
        task.wait(2)
    end
    
    print("benchmark results",results)
end
