--- jf geode exploration

counter = 0
tempo = 110

function init()
  input[1].mode('change', 1.0, 0.1, 'rising')
  ii.jf.mode(1)
  clock.run(clk)
  clock.tempo = tempo
end

input[1].change = function ()
  ii.jf.play_voice(0,1,1)
end


function clk()
  while true do
    clock.sync(1/2)
    -- ii.jf.play_voice(0,1,1)
  end
end
