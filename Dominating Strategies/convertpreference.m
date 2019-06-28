function [ newmatrix ] = convertpreference( matrix, player )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 [sz_1,sz_2,sz_3] = size(matrix);
    
 
 newmatrix = zeros(sz_1,sz_2,sz_3);

    for x = 1:sz_1
        for y = 1:sz_2
            for z = 1:sz_3
                newmatrix(x,y,z) = agentpreference(player, matrix(x,y,z));
            end
        end
    end

end

