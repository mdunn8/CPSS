function [matrix] = Gamebuild2(nc,CA,A,Cost,V)
%% Three player game matrix based on blotto resource combinations
p = 1; 
z = 0;
Ca1 = CA{1};    Ca2 = CA{2};    Cd = CA{3};
d = size(Cd);    a1 = size(Ca1);  a2 = size(Ca2);
Ld = d(1);       La1 = a1(1);     La2 = a2(1);
% 
% matrix = zeros(Ld,La1,La2);
% i = 1; j = 1; k = 1;

% For each strategy set in player 2 combinations
for kk = 1:La2
    % For each strategy set in player 1 combinations 
    for jj = 1:La1
        % For each strategy set in defenders combinations
        for ii = 1:Ld
        %Check if combined strategies takes over a node
            for ll = 1:nc
                if Ca1(jj,ll)+Ca2(kk,ll) <= Cd(ii,ll)
                    H = 0;
                elseif Ca1(jj,ll)+Ca2(kk,ll) > Cd(ii,ll)
                    H = 1;
                end
                % z contains success or failure of each c-nodes attacks from combined
                % efforts
                z(ll) = H;
            end
            % A helps relate interconnectivity of physical nodes. 
        % If y(1) = 2; physical node 1 suffered 2 cyber node losses this combo
                  y = A*z';
            for b = 1:length(y) % Compare nodes with threshold values
                if y(b) >= V(b)
                    Y(b) = 1;
                else
                    Y(b) = 0;
                end
        %Y now contains 1 if p-node is taken down and 0 if not
            end         
% Each player values physical nodes differently
% If player mm is an attacker, reward nodes being down.(Y(ii) = 1)
            for mm = 1:size(Cost,2)
                if sum(Cost(:,mm)) > 0
                  C(mm) = Y*Cost(:,mm); 
                else
 %  Otherwise a defender gets rewarded when cyber nodes are not
 %  successfully taken down.
                    for b = 1:length(Y)
                        if Y(b) == 0
                            C10(b) = abs(Cost(b,mm));
                        elseif Y(b) == 1
                            C10(b) = 0;
                        end
                    end
                 C(mm) = sum(C10);
                end
            end
            
          
        % Build cost matrix.  
                matrix(p,:) = C;
                p = p+1;
        end
    end
   
end
end