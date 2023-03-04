% width and gap of resistor bands, for when color alone does not tell you
% which one is the tolerance band
% |width(band1) gap(band1)|
% |width(band2) gap(band2)|
function endstats = myendstats(workwith, good_series, c2k)
better_series = cell2mat(c2k(good_series));
endstats = zeros(2, 2);
for k= [better_series(1) better_series(end)]
    endstats(ceil((k+0.01)/better_series(end)), 1) = find_width(k, workwith);
    endstats(ceil((k+0.01)/better_series(end)), 2) = find_gap(k, workwith, better_series);
end
end