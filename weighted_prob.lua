--- weighted probability function
-- in1 = trigger
-- out1 = envelope


function init()
    input[1].mode( 'change', 0.1, 0.02, 'rising' )
    output[1].action = ar(0.01,2,10)
end

input[1].change = function()
    prob(90,play_note) -- example using function with 90% probability
end

function play_note()
    output[1]()
end


function prob(prob_val, func)
    if prob_val >= math.random(100) then
        func()
    end
end

