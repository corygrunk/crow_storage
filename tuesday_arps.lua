--- tuesday arps
-- connect a just friends
-- in1: clock
-- out1: cv notes
-- out4: clock output


-- REFERENCE
-- dorian_scale {0,2,3,5,7,9,10} -- C D D# F G A A#

s = sequins
arp = s{0,3,0,0,5,0,8}
arp_alt = s{5,0,0,0}

function init()
    ii.jf.mode(1)
    input[1].mode( 'change', 0.1, 0.02, 'rising' )
    output[4].action = pulse()
end

input[1].change = function()
    local note = arp() + arp_alt()
    ii.jf.play_note(note/12,3)
    output[1].volts = note/12
    output[4]() -- pulse    
end 
