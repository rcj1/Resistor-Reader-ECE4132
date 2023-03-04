% takes an endstats matrix, and returns 1 if row 1 has the tolerance band
% and 2 if row 2 has the tolerance band`
function wtol = which_tol(myendstats)
% 1 is the first one , and 2 is the second one
percent_diffs = zeros(1, 2);
for k=1:2
    percent_diffs(k) = abs(myendstats(1, k)-myendstats(2, k))/min(myendstats(1, k), myendstats(2, k));
end
big_col = find( percent_diffs == max(percent_diffs));
[wtol, ~] = find(myendstats(:, big_col) == max(myendstats(:, big_col)));
end