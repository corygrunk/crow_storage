--- tiptop one
-- here come the drums

-- in1: clock
-- out1: sequence 1
-- out2: trig 1
-- out3: sequence 2
-- out4: trig 2

local b = 0
local h = 4
local s = 8
local x = 666
seq1 = sequins{b,x,h,x,s,x,h,x,b,x,h,x,s,h,h,h}
seq2 = sequins{b,x,h,x}


function init()
    input[1].mode( 'change', 1, 0.02, 'rising' )
    output[2].action = pulse()
    output[4].action = pulse()
end

input[1].change = function()
    local drum1 = seq1()
    if drum1 ~= 666 then
        output[1].volts = drum1
        output[2]()
    end
    local drum2 = seq2()
    if drum2 ~= 666 then
        output[3].volts = drum2
        output[4]() 
    end  
end 
