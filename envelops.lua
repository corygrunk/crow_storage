--- envlopes

-- in1: envelope trigger
-- in2: decay time - neg values reverse envelope
-- outs: envelops gradually getting longer 1 > 4

decay = {0.5,1.5,3,4}
attack = {0.02,1,3,4}

function init()
    input[1].mode('change', 1.0, 0.1, 'rising')
    output[1].action = ar(dyn{att1 = attack[1]}, dyn{dec1 = decay[1]}, 10, 'log')
    output[2].action = ar(dyn{att2 = attack[1]}, dyn{dec2 = decay[2]}, 10, 'log')
    output[3].action = ar(dyn{att3 = attack[1]}, dyn{dec3 = decay[3]}, 10, 'log')
    output[4].action = ar(dyn{att4 = attack[1]}, dyn{dec4 = decay[4]}, 10, 'log')
end

input[1].change = function()
    local volts = input[2].volts
    if volts > 0 then
        output[1].dyn.att1 = attack[1]
        output[1].dyn.dec1 = volts * 1
        output[2].dyn.att2 = attack[1]
        output[2].dyn.dec2 = volts * 2
        output[3].dyn.att3 = attack[1]
        output[3].dyn.dec3 = volts * 4
        output[4].dyn.att4 = attack[1]
        output[4].dyn.dec4 = volts * 5

        print(volts)
    else 
        output[1].dyn.att1 = volts * -0.05
        output[1].dyn.dec1 = decay[1]

        output[2].dyn.att2 = volts * -0.1
        output[2].dyn.dec2 = decay[2]

        output[3].dyn.att3 = volts * -0.3
        output[3].dyn.dec3 = decay[3]

        output[4].dyn.att4 = volts * -0.5
        output[4].dyn.dec4 = decay[4]
    end
    output[1]()
    output[2]()
    output[3]()
    output[4]()
end 