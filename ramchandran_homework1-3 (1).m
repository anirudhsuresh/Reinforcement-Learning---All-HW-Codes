clc;
close all;
UCB_constant_c = 2;
tic;%for timing the progam
%starts the timer
%Define q*(a)
for n=1:2000
    A= zeros(10,1000);% Action register
    R=zeros(10,1000); %Reward register
    Q= zeros(10,1000); %Value estimate register
    A_UCB= zeros(10,1000);% Action register for UCB
    R_UCB=zeros(10,1000); %Reward register for UCB
    Q_UCB= zeros(10,1000); %Value estimate register for UCB
    for i=1:10
        value_function(i)= normrnd(0,1);  %value function is q*(a)
    end
    %Inital
    banditSlot= randi(10);
    A(banditSlot,1)=1;
    R(banditSlot,1)= normrnd(value_function(banditSlot),1);
    
    A_UCB(banditSlot,1)=1;
    R_UCB(banditSlot,1)= normrnd(value_function(banditSlot),1);
    
    
    %After initial 
    for t=2:1000
        %Determine Action Value estimate using sample average method
        %formula from text book
        for i=1:10
            if nnz(A(i,:))~=0
                Q(i,t)= sum(R(i,:))/nnz(A(i,:));%Sample Average till t-1
            else
                Q(i,t)=0;
            end
            if nnz(A_UCB(i,:))~=0
                Q_UCB(i,t) = (sum(R_UCB(i,:))/nnz(A_UCB(i,:))) + UCB_constant_c*sqrt(log(t)/nnz(A_UCB(i,:)));
            else
                Q_UCB(i,t)=0;
            end
            
        end
        [Max,Index]= max(Q(:,(t-1)));
        GreedyA= find(Q(:,(t-1))==Max);
        bestGreddy= randi(length(GreedyA));
        BestGreedyA= GreedyA(bestGreddy);
        if (0.9>=rand())
            A(BestGreedyA,t)=1;
            R(BestGreedyA,t)= normrnd(value_function(BestGreedyA),1);  
            A_UCB(BestGreedyA,t)=1;
            R_UCB(BestGreedyA,t)= normrnd(value_function(BestGreedyA),1); 
            
        else
            choosen_slot = randi(10);
            A(choosen_slot,t)=1;
            R(choosen_slot,t)= normrnd(value_function(choosen_slot),1); 
            
            Q_UCB(BestGreedyA,:) = [];
            [Max_UCB,Index_Ucb] =  max(Q_UCB(:,(t-1)));
            MaxUCB = find(Q_UCB(:,(t-1))==Max_UCB);
            Len_MAX_UCB = randi(length(MaxUCB));
            MAX_UCB_A = MaxUCB(Len_MAX_UCB);
            A_UCB(MAX_UCB_A,t)=1;%Action Register
            R_UCB(MAX_UCB_A,t)= normrnd(value_function(MAX_UCB_A),1); %Reward register
            
        end
        
    end
    
%Total reward for both algorithms
RewardGreedy(n,:)=sum(R);
RewardUCB(n,:) = sum(R_UCB);
end
%we find the average 
for t=1:1000
    meanReward(t)= mean(RewardGreedy(:,t));
    meanRewardUCB(t) = mean(RewardUCB(:,t));
end
%we plot the differnt graphs 
t=1:1000;
plot(t,meanReward)
hold on;% to enabe both graphs in the same plot
plot(t,meanRewardUCB)
toc;%stop timer
