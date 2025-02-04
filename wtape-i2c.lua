-- wtape i2c
--
s = sequins
arp = s{0,3,7,6,0,5}
offsets = s{0,2,0}
speeds = {-1.3, -1, -0.5, 1, 0.5, 1.3}
loop_scales = {1, 1/2, 1/4, 1/8}
counter = 0

playing = true
armed = false
rec_loop = false
looping = false
loop_length = 8
timestamp = 0.0
prob_rec = 10
rec_level = 0.3

function init()
  ii.wtape.WARNING_clear_tape()
  ii.wtape.play(1)
  ii.wtape.record(0)
  ii.wtape.loop_active(0)
  ii.wtape.speed(1.0)
  ii.wtape.monitor_level(1)
  ii.wtape.rec_level(rec_level)

  ii.jf.mode(1)

  output[2].action = ar(dyn{attack = 0.01}, dyn{release = 0.4}, dyn{level = 8}, 'expo')
  output[3].action = lfo(dyn{time = 5},dyn{level = 1},'sine')
  output[4].action = lfo(dyn{time = 4},dyn{level = 1},'random')
  output[3]()
  output[4]()
  
  clock.run(seq)
  clock.tempo = 110                                                                                                                                                                                                                                                                        
end

function seq()
  while true do
    clock.sync(1/2)

    if prob_rec > math.random(100) and not armed and not rec_loop then
      armed = true
    end

    counter = counter + 1
    if counter % loop_length == 0 then
      if armed and not rec_loop and not looping then -- initial record
        print('starting loop')
        ii.wtape.record(1)
        ii.wtape.get('timestamp')
        ii.wtape.loop_start(timestamp)
        armed = false
        rec_loop = true
        looping = false
      elseif not armed and rec_loop and not looping then -- end initial record
        print('ending loop')
        ii.wtape.get('timestamp')
        ii.wtape.loop_end(timestamp)
        ii.wtape.record(0)
        armed = false
        rec_loop = false
        looping = true
      elseif not armed and not rec_loop and looping then -- looping
        print('looping')
      elseif armed and not rec_loop and looping then -- re-record
        print('re-recording')
        ii.wtape.record(1)
        armed = false
        rec_loop = true
      elseif rec_loop and looping then -- end re-record
        print('ending re-record')
        ii.wtape.record(0)
        local speed = speeds[math.random(#speeds)]
        ii.wtape.speed(speed)
        ii.wtape.loop_scale(loop_scales[math.random(#loop_scales)])
        armed = false
        rec_loop = false
      end
    end

    if playing then
      local note = (arp() + offsets()) / 12

      ii.jf.play_note(note, 2)
      if counter % 2 == 0 then
        output[1].volts = note
        output[2]()
      end
    end
  end
end

ii.wtape.event = function(e, value)
  if e.name == 'timestamp' then
    timestamp = value
  end
end
