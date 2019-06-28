function [ output ] = dominatingstrategies( matrix, player )
%DOMINATINGSTRATIGIES Summary of this function goes here
%   Detailed explanation goes here

% Defender minimizes, attackers maximize

    [sz_d,sz_a1,sz_a2] = size(matrix);
    
    matrix = convertpreference(matrix,player);
        
    if strcmp(player, 'xd')
        output = zeros(1,sz_d);
        for x = 1:sz_d
            for y = x+1:sz_d
                if all( all( matrix(x,:,:) >= matrix(y,:,:) ))
                    output(1,x) = 1;
                elseif all( all( matrix(x,:,:) <= matrix(y,:,:) ))
                    output(1,y) = 1;
                end
            end
        end
    elseif strcmp(player, 'xa2')
        output = zeros(1,sz_a2);
         for x = 1:sz_a2
            for y = x+1:sz_a2
                if all( all( matrix(:,:,x) >= matrix(:,:,y) ))
                    output(1,y) = 1;
                elseif all( all( matrix(:,:,x) <= matrix(:,:,y) ))
                     output(1,x) = 1; 
                end
            end
        end      
    elseif strcmp(player, 'xa1') 
        output = zeros(1,sz_a1);
        for x = 1:sz_a1
            for y = x+1:sz_a1
                if all( all( matrix(:,x,:) >= matrix(:,y,:) ))
                    output(1,y) = 1;
                elseif all( all( matrix(:,x,:) <= matrix(:,y,:) ))
                    output(1,x) = 1;   
                end
            end
        end
    else
        error('dominatingstratigies: Invalid agent')
    end
       
    

    


end

