return function(className : string)
    return function (props : {[any] : any})
        local instance = Instance.new(className)
    
        local Parent = props.Parent or nil

        for PropName, PropValue in props do
            if PropName == "Parent" then
            elseif PropName == "Children" then
                for _, child in PropValue do
                    child.Parent = instance
                end    
            else
                instance[PropName] = PropValue        
            end

            

        end

        instance.Parent = Parent

        return instance

    end
end