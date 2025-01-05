--- clock
--
-- output 1: clock pulse
-- output 2: clock pulse
-- output 3: clock pulse
-- output 4: clock pulse

local tempo = 120
local prob = 80

function init()
  output[1].action = pulse(0.1,5)
  output[2].action = pulse(0.1,5)
  output[3].action = pulse(0.1,5)
  output[4].action = pulse(0.1,5)
  clock.tempo = tempo
  clock.run(clk1)
  clock.run(clk2)
  clock.run(clk3)
  clock.run(clk4)
end

function clk1()
  while true do
    clock.sync(2)
    output[1]()
  end
end

function clk2()
  while true do
    clock.sync(1)
    output[2]()
  end
end

function clk3()
  while true do
    clock.sync(1/2)
    output[3]()
  end
end

function clk4()
  while true do
    clock.sync(1/4)
    local random = math.random(1,100)
    if prob > random then
      output[4]()
    end
  end
end



