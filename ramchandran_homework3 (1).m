random_policy = zeros(9,9);
for i=1:9
    for j=1:9
        if i>=j
            random_policy(i,j) = 1/i;
        end
    end
end
policy_evaluation(policy_random);
value_iteration_algo(policy_random);

function [Value_obtained, policy_used] = policy_evaluation(policy_used)
    V_p = zeros(1,9);
    theta = 0.00001;
    while true
        delta = 0;
        for s =1:9
            v_old = 0;
            for a =1:9
                action_prob = policy_used(s,a);
                reward = a;
                if s+reward<10 && s-reward>0
                    v_old=v_old+action_prob*(0.9*(reward + V_p(s+reward)) + 0.1*(V_p(s-reward) - reward));
                elseif s+reward>=10 && s-reward>0
                    v_old=v_old+action_prob*(0.9*(reward) + 0.1*(V_p(s-reward) - reward));
                elseif s+reward<10 && s-reward<=0
                    v_old=v_old+action_prob*(0.9*(reward + V_p(s+reward)) + 0.1*(0 - reward));
                elseif s+reward>=10 && s-reward<=0
                    v_old=v_old+action_prob*(0.9*(reward) + 0.1*(0 - reward));
                end
            end
            delta = max(delta, abs(v_old-V_p(s)));
            V_p(s) = v_old;
        end
        if delta<theta
            break;
        end
    end
    [policy_used, policy_stable] = policy_improvement(policy_used, V_p);
    disp(policy_stable);
    if policy_stable ==0
        policy_evaluation(policy_used);
    else
        policy_used=policy_used
        Value_obtained = V_p
    end   
end

function [new_policy_final, policy_stable] = policy_improvement(policy_u, V_o)
    policy_stable = 1;
    new_policy_obtained = zeros(9,9);
    for s =1:9
        v_n = 0;
        action = [];
        for a =1:s
            reward = a;
            if s+reward<10 && s-reward>0
                v_n=(0.9*(reward + V_o(s+reward)) + 0.1*(V_o(s-reward) - reward));
            elseif s+reward>=10 && s-reward>0
                v_n=(0.9*(reward) + 0.1*(V_o(s-reward) - reward));
            elseif s+reward<10 && s-reward<=0
                v_n=(0.9*(reward + V_o(s+reward)) + 0.1*(0 - reward));
            elseif s+reward>=10 && s-reward<=0
                v_n=(0.9*(reward) + 0.1*(0 - reward));
            end
            action = [action v_n];
        end
         [maxed_value, Index] = max(action);
         max_action = find(action==maxed_value);
         new_policy_obtained(s,max_action) = 1/length(max_action)
     end
     if isequal(policy_u,new_policy_obtained)
         policy_stable = 1;
     else
         policy_stable = 0;
     end
     new_policy_final = new_policy_obtained;
end
%%

function [Value_ob, policy] = value_iteration_algo(policy)
    V_s = zeros(1,9);
    theta = 0.00001;
    while true
        delta = 0;
        for state =1:9
            v_used = 0;
            action = [];
            for a =1:9
               % action_prob = policy(s,a);
                reward = a;
                if state+reward<10 && state-reward>0
                    v_used=(0.4*(reward + V_s(state+reward)) + 0.6*(V_s(state-reward) - reward));
                elseif state+reward>=10 && state-reward>0
                    v_used=(0.4*(reward) + 0.6*(V_s(state-reward) - reward));
                elseif state+reward<10 && state-reward<=0
                    v_used=(0.4*(reward + V_s(state+reward)) + 0.6*(0 - reward));
                elseif state+reward>=10 && state-reward<=0
                    v_used=(0.4*(reward) + 0.6*(0 - reward));
                end
                action = [action v_used];
            end
            [v1, i1] = max(action);
            delta = max(delta, abs(v1-V_s(state)));
            V_s(state) =v1;
        end
        new_policy = zeros(9,9);
        for state =1:9
            v_used = 0;
            action = [];
            for a =1:state
                reward = a;
                if state+reward<10 && state-reward>0
                    v_used=(0.4*(reward + V_s(state+reward)) + 0.6*(V_s(state-reward) - reward));
                elseif state+reward>=10 && state-reward>0
                    v_used=(0.4*(reward) + 0.6*(V_s(state-reward) - reward));
                elseif state+reward<10 && state-reward<=0
                    v_used=(0.4*(reward + V_s(state+reward)) + 0.6*(0 - reward));
                elseif state+reward>=10 && state-reward<=0
                    v_used=(0.4*(reward) + 0.6*(0 - reward));
                end
                action = [action v_used];
            end
             [ma, I] = max(action);
             max_action_u = find(action==ma);
             new_policy(state,max_action_u) = 1/length(max_action_u);
        end
        if delta<theta
            break;
        end
    end
    policy= new_policy;
    Value_ob = V_s
end