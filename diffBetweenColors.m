% helper function: takes a "path" through the adjacency matrix and commpute
% its "weight", the lower the weight the more similar the colors are
function acc = diffBetweenColors(adj, ind)
    combs = combntns(ind, 2);
    acc = 0;
    lcombs = size(combs);
    lcombs = lcombs(1);
    for k=1:lcombs
        acc = acc + adj(combs(k, 1), combs(k, 2));
    end
    acc = acc./lcombs;
end