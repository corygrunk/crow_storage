-- timeline, hotswap + sequins

-- hotswap melody, eg:
-- hs.m = s{12,14,7,-7}

-- patch crow outputs 1 + 2 to control JF parameters
-- eg. INTONE, RAMP, or TIME

tl = timeline
s = sequins
hs = hotswap

function init()
  ii.jf.mode(1)
end

function play(ch, pitch, vel)
  vel = vel == nil and 5.0 or vel
  ii.jf.play_voice(ch, pitch/12, vel)
end

p1 = function() output[1](pulse()) end
p2 = function() output[2](pulse(0.3)) end

pings = {0.2, p1, s{2,0.4,0.3,0.1}, p2, 0.5, p1, 0.3, p1, 0.2, p2}
tl.loop(pings)

function first()
  print('first')
  hs.t = s{0.4,1.2,s{0.7,0.3,0.1}}
  hs.m = s{0,s{4,-7},7,11}
  hs.ch = s{1,2,3}
  hs.seq = tl.loop{ hs.t, {play, hs.ch, hs.m} }
end

function second()
  print('second')
  hs.t = s{0.3,0.5,0.4, 0.7}
  hs.m = s{-12,4,19,11,7}
  hs.ch = s{1,2,3,2,3,1,3}
end

function third()
  print('third')
  hs.t = s{0.7,0.5,0.4}
  hs.m = s{s{0,2,-12,-7},7,4,s{-12,19},11}
  hs.ch = s{1,3}
end

function fourth()
  print('fourth')
  hs.t = s{0.7,0.5,0.02,0.4,0.7,0.1,0.04}
  hs.m = s{s{-24,-7,0,2},4,7,11,s{19,12,-7}}
  hs.ch = s{2,3,1}
end

tl.score{
  0, first,
  4, second,
  12, third,
  19, fourth,
  33, s{third,second,'reset'},
  45, 'reset'
}