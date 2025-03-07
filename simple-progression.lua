--- simple progression
--
-- requires ansible
-- trigger 4 of ansible is a clock

s = sequins
arp = s{0,4,5}
drum_pattern = s{0,5}
offsets = s{0,12,0,0}
counter = 0
current_tempo = 120
cold_mac = 0

function init()
  input[1].mode('stream', 0.25)
  output[2].action = pulse()
  output[4].action = pulse()
  note = arp()

  clock.run(seq)
  clock.tempo = current_tempo
end

-- get the value from the first input
input[1].stream = function(v)
  cold_mac = v
end

function linlin(in_min, in_max, out_min, out_max, value)
  -- Clamp input value to range
  if value < in_min then value = in_min end
  if value > in_max then value = in_max end
  
  return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

function seq()
  while true do
    clock.sync(1)
    counter = counter + 1

    -- tempo setting
    tempo = math.floor(linlin(-5, 5, 50, 200, cold_mac))
    if tempo ~= current_tempo then
      current_tempo = tempo
      clock.tempo = current_tempo
    end

    if counter == 4 then
      note = arp()
      counter = 0
    end
    output[1].volts = (note + offsets()) /12
    output[2]()
    output[3].volts = drum_pattern()
    output[4]()
    ii.ansible.trigger_pulse(4) 
  end
end

