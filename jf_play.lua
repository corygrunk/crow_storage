--- jf play

-- in1: trig
-- in2: v/oct
-- out1: 
-- out2: 
-- out3: 
-- out4: 

function init()
  ii.jf.mode(1)
  input[1].mode('change',1,0.2,'rising')
end

input[1].change = function()
  local note = input[2].volts
  -- print('in1: ' .. input[1].volts .. '     in2: ' .. note)
  ii.jf.play_note(note,3)
end


