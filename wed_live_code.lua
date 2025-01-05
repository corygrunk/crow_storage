--- wednesday live code

s = sequins
seq = s{s{0,6},3,6,9}
alt_seq = s{5,0,7,0,0}
prob = s{100,50,80,60}
attack = 0.1
release = 1


function init()
  input[1].mode('change', 1.0, 0.1, 'rising')
  output[2].action = ar(dyn{att = attack},dyn{rel = release},8)
  output[4].action = pulse()
end

input[1].change = function()
  if prob() > math.random(100) then
    play_note(seq(),attack,release)
    if 20 > math.random(100) then
      delay( del, 0.02)
    end 
  end
  output[4]()
end

function del()
  play_note(seq(),math.random(0.5)/10,math.random(0.5)/10)
end

function play_note(note,att,rel)
  local n = note + alt_seq()
  output[1].volts = n/12
  output[2].dyn.att = att
  output[2].dyn.rel = rel
  output[2]()
end