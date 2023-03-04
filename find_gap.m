% helper for endstats: returns gap between resistors
function gap = find_gap(k, workwith, better_series)
if k == better_series(1)
    bt2 = better_series(2);
    gap = workwith(bt2, 6) - workwith(k+1, 6);
elseif k == better_series(end)
    btmin1 = better_series(end-1);
    gap = workwith(btmin1, 6) - workwith(k, 6);
end
end
