--- jf play chords

-- in1: trig
-- in2: v/oct
-- out1: 
-- out2: 
-- out3: 
-- out4: 

-- notes for minor 7th chord: {0, 3, 7, 10}

local root = 0
local three_flat = 3
local five = 7
local seven_flat = 10


function init()
  ii.jf.mode(1)
  input[1].mode('change',1,0.2,'rising')
end

input[1].change = function()
  local root = input[2].volts
  play_chord(root)
end

function play_chord(root_note)
  ii.jf.play_note(root_note/12,2)
  ii.jf.play_note(root_note + three_flat/12,2)
  ii.jf.play_note(root_note + five/12,2)
  ii.jf.play_note(root_note + seven_flat/12,2)
end


