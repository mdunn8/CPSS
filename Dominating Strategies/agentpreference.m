function [ newvalue ] = agentpreference( agent, value )
%agentpreference coverts payoff values to newvalues based on player
%   This is done to allow interger comparisions to identy dominant
%   strategies for each player
    
    if strcmp(agent, 'xd')
        if value == -1
            newvalue = 0;
        elseif value == 0
            newvalue = 1;
        else 
            newvalue = 2;
        end
    elseif strcmp(agent, 'xa2')
        if value == 0
            newvalue = 1;
        elseif value == 1
            newvalue = 0;
        else
            newvalue = value;
        end
    elseif strcmp(agent, 'xa1') 
        newvalue = value; %xa1's perfered strategies are already in decending order
    else
        error('agentpreference: Invalid agent')
    end
        
        


end

