--- friday


s = sequins
mel = s{0,2,4,6,8,12}
counter = 0
tempo = 110

function init()
  output[2].action = ar(0.1,3,10)
  clock.run(clk)
  clock.tempo = tempo
end

function clk()
  while true do
    clock.sync(1/2)
    play_note()
  end
end

function play_note ()
  counter = counter + 1
  if counter % 2 == 0 then -- every 2
    mel:step(math.random(0,3))
  end
  if counter % 4 == 0 then -- every 4
    output[1].volts = mel()/12
    output[2]()
  end
  if counter % 9 == 0 then -- every 9
    delay(function()
      output[1].volts = mel()/12
      output[2]()
    end, 0.34, 2)
  end
end