function [new_strat] = reduced_matrix(dom_strat, CA, player)

len = length(dom_strat);

if strcmp(player, 'xa1')
    strat = CA{1};
end

if strcmp(player, 'xa2')
    strat = CA{2};
end

if strcmp(player, 'xd')
    strat = CA{3};
end

x = 1;
y = 1;

for x=1:len
    if dom_strat(1,x) == 0
        new_strat(y,:) = strat(x,:);
        y = y + 1;
    end
end
