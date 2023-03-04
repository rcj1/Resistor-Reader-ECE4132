% helper for endstats
function wid = find_width(k, workwith)
wid = workwith(k+1, 6) - workwith(k, 6);
end