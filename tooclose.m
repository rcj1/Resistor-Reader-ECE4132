% de duplicates the lines
function [newlines] = tooclose(current) 
    sz = size(current);
    sz = sz(1);
    adj = zeros(sz);
    for l=1:sz(1) % filling the adjacency matrix
        for m=1:sz(1)
            v = (current(l, 6) - current(m, 6))/(current(l, 5)-current(m, 5));
            th2 = atand(v);
            if m > l
                vals = [abs(th2 - current(l, 7)) abs(th2-current(m, 7))]; % I probably don't need the if branch but I don't have time to remove it now
            else
                vals = [abs(th2-current(m, 7)) abs(th2-current(l, 7))];
            end
            m1 = tand(current(m, 7));
            m2 = tand(current(l, 7));
            b1 = current(m, 2)-m1*current(m, 1);
            b2 = current(l, 2)-m2*current(l, 1);
            x0 = (b2-b1)/(m1-m2);
            inbetween = ((current(m, 1)-10<x0)&&(x0<current(m, 3)+10)) || ((current(l, 1)-10<x0)&&(x0<current(l, 3)+10));
            vals(vals>90) = 180-vals(vals>90);
            [subsz1, subsz2] = size(polyxpoly([current(l, 1) current(l, 3)], [current(l, 2) current(l, 4)], [current(m, 1) current(m, 3)], [current(m, 2) current(m, 4)]));
            if (subsz1 > 0 || (vals(1) < 10 && vals(2) < 10) || inbetween) % if the lines intersect or are side by side
                adj(m, l) = 1;
            end
        end
    end
    % now we make a graph where the nodes are the hough lines and the edges
    % are whether the hough lines are duplicates of each other
    gnew = graph(adj, 'omitselfloops');
    eid = [];
    mybins = conncomp(gnew);
    for p=1:length(mybins)
        if (degree(gnew, p) == 1) && (length(find(mybins == mybins(p))) > 4) % remove weak connections between parts
            eid = [eid outedges(gnew, p)]; % so we remove it by adding it to eid and removing these edges later
        end
    end
    gnew = rmedge(gnew, eid); % remove weakly connected components
    idx2keep = [];
    mybins = conncomp(gnew);
    for n = 1:max(mybins)
        idx = find(mybins == n);
        idx2keep = [idx2keep idx(1)];% take one from each connected component and add it to idx2keep
    end

    newlines = current(idx2keep, :);

end