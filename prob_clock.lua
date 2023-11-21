--- prob clock
-- in1 = clock
-- in2 = probability cold mac 0 - 5v
-- out1 = cv
-- out2 = trig
-- jf will be put in synth mode

arp = sequins{0,3,5,8,10}

function init()
    ii.jf.mode(1)
    input[1].mode( 'change', 0.1, 0.02, 'rising' )
    output[2].action = pulse()

end

input[1].change = function()
    if input[2].volts > 0 then
        local prob = scaleValue(math.floor(input[2].volts))
        if prob >= math.random(100) then
            ii.jf.play_note(arp()/12,3)
            output[1].volts = arp()/12
            output[2]()
        end
    end
end

-- chatGPT did this
function scaleValue(value)
    -- Ensure the input value is within the valid range [0, 5]
    value = math.min(5, math.max(0, value))
    -- Scale the value from the range [0, 5] to [0, 100]
    local scaledValue = (value / 5) * 100
    return scaledValue
end
