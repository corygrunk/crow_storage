--- pod_sturment


s = sequins
mel = s{0,2,4,6,8,12,0,6,0,2,4,8,12}
tempo = 95
counter = 0
cv_2_flip = 0

function init()
    ii.jf.mode(1)
    ii.ansible.cv_slew(2,2000)
    output[2].action = ar(0.1,3,10)
    clock.run(clk)
    clock.tempo = tempo
end

function clk()
  while true do
    clock.sync(1)
    play_note()
  end
end

function play_note ()
    counter = counter + 1
    if counter % 8 == 0 then -- every
        mel:step(math.random(1,2))
    end
    if counter % 4 == 0 then -- every
        if cv_2_flip == 0 then
            ii.ansible.cv(2,2)
            cv_2_flip = 1
        else
            ii.ansible.cv(2,0)
            cv_2_flip = 0
        end
    end
    ii.jf.play_note(mel()/12,3)
end