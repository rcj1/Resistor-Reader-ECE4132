function tol = findToleranceSide(bandColors, toleranceMap, dedupLines, r_series, horizColors)
% The pattern reader reads from beginning to end, so if the tolerance is at
% the start the sequence will have to be flipped. The variable tol keeps
% track of this; if tol==1 the tolerance band is at the start.
if bandColors(1) == "gold" && bandColors(end) ~="gold"
    tol = 1;
elseif bandColors(end) == "gold" && bandColors(1) ~="gold"
    tol = 0;
elseif bandColors(1) == "gray" && length(bandColors) == 4
    tol = 1;
elseif bandColors(end) == "gray" && length(bandColors) == 4
    tol = 0;
elseif ~isKey(toleranceMap, bandColors(1)) && isKey(toleranceMap, bandColors(end))
    tol = 0;
elseif isKey(toleranceMap, bandColors(1)) && ~isKey(toleranceMap, bandColors(end))
    tol = 1;
elseif bandColors(end-1) == "gray"
    tol = 1;
elseif bandColors(2) == "gray"
    tol = 0;
elseif isKey(toleranceMap, bandColors(1)) && isKey(toleranceMap, bandColors(end))
    myendstats2 = myendstats(dedupLines, r_series, horizColors.keys);
    ind = which_tol(myendstats2);
    if (ind == 1)
        tol = 1;
    else
        tol = 0;
    end
end
end
