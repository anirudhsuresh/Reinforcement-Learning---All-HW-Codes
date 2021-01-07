
% First we define the various policy matrixes 
matrix = [1 1 1 1 1 1 1 1 1];
aggressive_policy = diag(matrix);
conservative_policy = zeros(9,9);
for i=1:9
    conservative_policy(i,1) = 1;
end
random_policy = zeros(9,9);
for i=1:9
    for j=1:9
        if i>=j
            random_policy(i,j) = 1/i;
        end
    end
end
% we define the different policies that we need and call them
fprintf('aggressive policy is :')
policy_evaluation_algorithm(aggressive_policy);
fprintf('conservative policy is :')
policy_evaluation_algorithm(conservative_policy);
fprintf('random policy is :')
policy_evaluation_algorithm(random_policy);

function Value_function_for_game = policy_evaluation_algorithm(policy_used)
    Value = zeros(1,9);
    theta_constant = 0.00001;
    while true
        delta_constant = 0;
        for state =1:9
            array_buffer = 0;
            for action =1:9
                action_probabilty_pi = policy_used(state,action);
                reward = action;
                if state+reward<10 && state-reward>0
                    array_buffer=array_buffer+action_probabilty_pi*(0.9*(reward + Value(state+reward)) + 0.1*(Value(state-reward) - reward));
                elseif state+reward>=10 && state-reward>0
                    array_buffer=array_buffer+action_probabilty_pi*(0.9*(reward) + 0.1*(Value(state-reward) - reward));
                elseif state+reward<10 && state-reward<=0
                    array_buffer=array_buffer+action_probabilty_pi*(0.9*(reward + Value(state+reward)) + 0.1*(0 - reward));
                elseif state+reward>=10 && state-reward<=0
                    array_buffer=array_buffer+action_probabilty_pi*(0.9*(reward) + 0.1*(0 - reward));
                end
            end
            delta_constant = max(delta_constant, abs(array_buffer-Value(state)));
            Value(state) = array_buffer;
        end
        if delta_constant<theta_constant
            break;
        end
    end
    Value_function_for_game = Value
   end
