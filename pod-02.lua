--- pod 02 - ansible envelope and lfos

-- in1: envelope short trigger
-- in2: envelope med trigger
-- out1: envelope
-- out2: envelope
-- out3: lfo 2sec
-- out4: lfo 5sec

decay_short = 0.3
decay_med = 2

ramp1_time = 2
ramp1_skew = 1 -- triangle (half of time)
ramp1_level = 1.5

lfo2_time = 3
lef3_time = 5

lfo2_level = 1.5
lfo3_level = 2

lfo1_shape = 'sine'
lfo2_shape = 'sine'
lfo3_shape = 'sine'

function init()
    input[1].mode('change', 1.0, 0.1, 'rising')
    input[2].mode('change', 1.0, 0.1, 'rising')
    output[1].action = ar(0.01, dyn{dec = decay_short}, 10, 'log')
    output[2].action = ar(0.01, dyn{dec = decay_med}, 10, 'log')
    output[3].action = lfo(lfo2_time, lfo2_level, lfo2_shape) -- time, level, shape
    output[4].action = lfo(lfo3_time, lfo3_level, lfo3_shape) -- time, level, shape
    output[3]()
    output[4]()
end

input[1].change = function()
    output[1]()
end

input[2].change = function()
    output[2]()
end