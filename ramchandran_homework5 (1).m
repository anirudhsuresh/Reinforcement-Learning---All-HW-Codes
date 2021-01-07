clc
clear all
%initilizations
alpha=0.5; % as defined in the text book
gamma=1; %undiscounted
episodes=170;
Episodes=[];
row=7;
columns=10;
action=4;
Q=zeros(row,columns,action); % estimate of various actions for the gridworld
State=[];
step=0;
TimeStep=[];
path_taken=[];
tic;
for number=1:episodes
    
    Episodes=[Episodes,number];
    r=4;
    c=1;
    
    random=rand();
    if 0.9>random
        % exploitation
        %explore 10% of the time and 90% of the time we exploit
        [maximum_new,action] =max(Q(r,c,:));
    else
        action=randi([1,4]); %exploration
    end
    
    while(1)
        % change actions as someting else
        switch(action)
            case 1 %up action
                R_moved=r-1;
                C_moved=c;
            case 2 %down action
                R_moved=r+1;
                C_moved=c;
            case 3 %right action
                R_moved=r;
                C_moved=c+1;
            case 4 %left action
                R_moved=r;
                C_moved=c-1;
        end
        %State=[State;[i,j,action]]
        % we have upadted the new state according to the action
        %need to account for the wind blown
        switch(C_moved)
            case {1,2,3,10}
                R_moved=R_moved;
            case {4,5,6,9}
                R_moved=R_moved-1;
            case {7,8}
                R_moved=R_moved-2;
        end
        State=[State;[R_moved,C_moved,action]];
        
        if number==170
            path_taken=[path_taken;[R_moved,C_moved,action]];
        end
        
        %Defining boundaries of the gridworld
        %upper and lower boundaries
        if C_moved>10
            C_moved=10;
            fprintf("boundary reached ")
            State=[State;[R_moved,C_moved,action]];
            %             if number==170
            %                 path_taken=[path_taken;[R_moved,C_moved,action]];
            %             end
        elseif C_moved<1
            C_moved=1;
            fprintf("boundary reached ")
            State=[State;[R_moved,C_moved,action]];
            %             if number==170
            %                 path_taken=[path_taken;[R_moved,C_moved,action]];
            %             end
        end
        %right and left boundaries
        if R_moved>7
            R_moved=7;
            fprintf("boundary reached ")
            State=[State;[R_moved,C_moved,action]];
            %             if number==170
            %                 path_taken=[path_taken;[R_moved,C_moved,action]];
            %             end
        elseif R_moved<1
            R_moved=1;
            fprintf("boundary reached ")
            State=[State;[R_moved,C_moved,action]];
            %             if number==170
            %                 path_taken=[path_taken;[R_moved,C_moved,action]];
            %             end
        end
        
        % we need the next action according to the policy which basiclly selects
        % also we define the R as -1 for every state other than the terminal...
        
        Reward=-1;
        random_selection_N=rand();
        
        if 0.9>random_selection_N
            % exploitation
            [maximum_new,action_new] =max(Q(R_moved,C_moved,:));
        else
            action_new=randi([1,4]);
        end
        %from this next value we can use it in the SARSA TD...
        %policy iteration formula
        %given by
        % Q(S[t],A[t])<---(Q(S[t],A[t])+alpha*(R[t+1]+Q(S[t+1],At[t+1]))-Q(S[t],A[t]))
        TD_error=Reward+gamma*(Q(R_moved,C_moved,action_new)-Q(r,c,action));
        Q(r,c,action)=Q(r,c,action)+alpha*TD_error;
        
        %start the next step and assign the new indexes
        
        r=R_moved;
        c=C_moved;
        action=action_new;
        step=step+1;
        
        
        if r==4&&c==8
            Reward=0;
            TimeStep=[TimeStep;step];
            disp(State)
            break
        end
        
    end
    
end
toc;
%plot the required figure
figure(1)
plot(TimeStep,Episodes)
xlabel('TIme Steps')
ylabel('Episodes Taken')
