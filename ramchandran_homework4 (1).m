%initilizations
states=[];
T=0;
R=0;
G=0;
gamma=1;
number_episodes=500000;
dealer_card=zeros(1,20);
player_card=zeros(1,20);
non_usable_ace=0;
usable_ace=0;
% % returns_hit=double.empty(21,10,0);
% returns_stick=double.empty(21,10,0);
returns_hit=zeros(21,10);
returns_stick=zeros(21,10);
%player policy
player_policy=zeros(21,10);
for i=1:21
    for j=1:10
        if i<20
            player_policy(i,j)=1;
        else
            player_policy(i,j)=0;
        end
    end
end

%dealer policy
dealer_policy=zeros(1,21);

for i=1:21
    if i<17
        dealer_policy(1,i)=1;
    else
        dealer_policy(1,i)=0;
    end
end


for n=1:number_episodes
  states=[];  
%generating cards for player and checking for aces
for i=1:2
    player_card(1,i)=randi([2,11]);
    if player_card(1,i)==11
        usable_ace=usable_ace+1;
    end
end
player_sum=sum(player_card);
if player_sum==22
    usable_ace=usable_ace-1;
    player_card(1,2)=1;
    player_sum=sum(player_card);
    non_usable_ace=non_usable_ace+1;
end

% generate two cards for dealer
for i=1:2
    dealer_card(1,i)=randi(10);% changed torandi(10)
end
dealer_sum=sum(dealer_card);

% dealer_sum=22;
i=3;
j=3;

%%%loops for the game

    T=0;
    while(1)
        %player game
        while(1)
            if player_sum>=22
                break
            end
            k=player_policy(player_sum,dealer_card(1,1));
            if k==1
                action=1;
                player_card(1,i)=randi([2,11]);
                
                if player_sum>10 && player_card(1,i)==11
                    non_usable_ace=non_usable_ace+1;
                    player_card(1,i)=1;
                    
                    fprintf("\n non usable ace")
                elseif player_sum<=10 && player_card(1,i)==11
                    usable_ace=usable_ace+1;
                end
                
                states=[states;[player_sum,dealer_card(1,1),action,dealer_sum]];
                T=T+1;
                %disp(states)
                player_sum=player_sum+player_card(1,i);
                
            elseif k==0
                action=0;
                states=[states;[player_sum,dealer_card(1,1),action,dealer_sum]];
                T=T+1;
                break
            end
            i=i+1;
        end
        if player_sum>=22
            break
            %BREAK is there to not execute dealer game 
        end
        
        %dealer game
       
% %             
% %             if dealer_card(1,1)==1
% %                 dealer_card(1,1)=11;
% %                 dealer_sum=sum(dealer_card);
% %             end
% %        
        
        while(1)
            if dealer_sum>=22
                break
            end
            
            p=dealer_policy(1,dealer_sum);
            if p==1
                dealer_card(1,j)=randi([2,11]);
                dealer_sum=dealer_sum+dealer_card(1,j);
            elseif p==0
                break
            end
            j=j+1;
        end
        break
        
    end
    
    %%%checks for various condtions
    if dealer_sum>player_sum && dealer_sum<=21 && player_sum<=21
        fprintf("\n the dealer wins ")
        action=0;
        states=[states;[player_sum,dealer_card(1,1),action,dealer_sum]];
        T=T+1;
        R=-1;
    elseif player_sum>dealer_sum && player_sum<=21 && player_sum<=21
        fprintf("\n the player wins")
        action=0;
        states=[states;[player_sum,dealer_card(1,1),action,dealer_sum]];
        T=T+1;
        R=1;
    elseif dealer_sum==player_sum && dealer_sum<=21 && player_sum<=21
        fprintf("\n draw")
        action=0;
        states=[states;[player_sum,dealer_card(1,1),action,dealer_sum]];
        T=T+1;
        R=0;
    elseif dealer_sum<player_sum && dealer_sum<=21 && player_sum>21
        fprintf("\n the dealer wins ")
        action=0;
        states=[states;[player_sum,dealer_card(1,1),action,dealer_sum]];
        T=T+1;
        R=-1;
    elseif player_sum<dealer_sum && player_sum<=21 && dealer_sum>21
        action=0;
        states=[states;[player_sum,dealer_card(1,1),action,dealer_sum]];
        T=T+1;
        fprintf("\n the player wins")
        R=1;
    end
    
    
     for t=1:T-1
        G=G*gamma+R;
     end
     
    for t=1:T-1
        if states(t,3)==1
           returns_hit(states(t,1),states(t,2),:)=G;
        elseif states(t,3)==0
            returns_stick(states(t,1),states(t,2),:)=G;
        end
    end
     
     returns=returns_hit+returns_stick;
   [q_hit,i_hit]=max(returns_hit);
       [q_s,i_s]=min(returns_stick);  
        
end
