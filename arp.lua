--- random notes
--
-- output 1: pitch cv
-- output 2: envelope

s = sequins
arp = s{0,2,4,6,9,12}
jf = 0

function init()
  -- ii.jf.mode(1)
  output[2].action = ar(0.02,3,10)
  clock.run(clk)
  clock.tempo = 120
end

function clk()
  while true do
    clock.sync(1/2)
    play_note()
  end
end

function play_note()
  local n = arp()/12
  if jf == 1 then
    ii.jf.play_note(n,5)
  else
    output[1].volts = n
    output[2]()
  end
end



