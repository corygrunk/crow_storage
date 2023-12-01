--- pod simple env

-- in1: envelope trigger
-- out2: envelope

decay = 3.0

function init()
    input[1].mode('change', 1.0, 0.1, 'rising')
    output[2].action = ar(0.01, dyn{dec = decay}, 10, 'log')
end

input[1].change = function()
    output[2].dyn.dec = decay
    output[2]()
end 