--- ASR
--
-- input 1: trigger
-- output 2: envelope

function init()
  input[1].mode('change', 1.0, 0.1, 'both')
  output[2].action = adsr()
end

input[1].change = function(s)
  output[2](s)
end
