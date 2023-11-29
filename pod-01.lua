--- pod 01 - ansible envelope and lfos

-- in1: envelope trigger
-- in2: voltage for decay
-- out1: envelope
-- out2: lfo 1sec
-- out3: lfo 2sec
-- out4: lfo 5sec

decay = 0.7

ramp1_time = 2
ramp1_skew = 1 -- triangle (half of time)
ramp1_level = 1.5

lfo1_time = 1
lfo2_time = 3
lef3_time = 5

lfo1_level = 1
lfo2_level = 1.5
lfo3_level = 2

lfo1_shape = 'sine'
lfo2_shape = 'sine'
lfo3_shape = 'sine'

function init()
    ii.jf.mode(1)
    input[1].mode('change', 1.0, 0.1, 'rising')
    output[1].action = ar(0.01, dyn{dec = decay}, 10, 'log')
    output[2].action = ramp(ramp1_time, ramp1_skew, ramp1_level) -- time, skew, level
    -- output[2].action = lfo(lfo1_time, lfo1_level, lfo1_shape) -- time, level, shape
    output[3].action = lfo(lfo2_time, lfo2_level, lfo2_shape) -- time, level, shape
    output[4].action = lfo(lfo3_time, lfo3_level, lfo3_shape) -- time, level, shape
    output[2]()
    output[3]()
    output[4]()
end

input[1].change = function()
    if input[2].volts > 0 then
        decay = input[2].volts
    end
    output[1].dyn.dec = decay
    output[1]()
    output[2]()
end