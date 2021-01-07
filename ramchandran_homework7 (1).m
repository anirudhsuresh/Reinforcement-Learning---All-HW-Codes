clc
clf
clear all
alpha=2*10^-5;
Gamma=1;
w=zeros(1,10);
tic;
for h=1:100000
    current_state=500;
    traversed_states=[];
    traversed_states=[traversed_states;current_state];
    while(1)
        x=rand(1);
        if x<=0.5
            p=randi([1,100]);
            current_state=current_state+p;
            if current_state>1000 %terminal state on the right hand side
                current_state=1001;
                traversed_states=[traversed_states;1001];
                break
            end
            traversed_states=[traversed_states;current_state];
        else
            p=randi([1,100]);
            current_state=current_state-p;
            if current_state<1 %terminal state on the left  hand side
                current_state=0;
                traversed_states=[traversed_states;0];
                break
            end
            traversed_states=[traversed_states;current_state];
        end
    end
    R=0;
    G_t=0;
    [r,c]=size(traversed_states);
    if traversed_states(r,1)==0
        R=-1;
        G_t=-1;
    else
        R=1;
        G_t=1;
    end
    for i=1:r-1
        if (traversed_states(i,1)>=1)&&(traversed_states(i,1)<=100)
            w(1,1)=w(1,1)+alpha*(G_t-w(1,1));
        elseif (traversed_states(i,1)>=101)&&(traversed_states(i,1)<=200)
            w(1,2)=w(1,2)+alpha*(G_t-w(1,2));
        elseif (traversed_states(i,1)>=201)&&(traversed_states(i,1)<=300)
            w(1,3)=w(1,3)+alpha*(G_t-w(1,3));
        elseif (traversed_states(i,1)>=301)&&(traversed_states(i,1)<=400)
            w(1,4)=w(1,4)+alpha*(G_t-w(1,4));
        elseif (traversed_states(i,1)>=401)&&(traversed_states(i,1)<=500)
            w(1,5)=w(1,5)+alpha*(G_t-w(1,5));
        elseif (traversed_states(i,1)>=501)&&(traversed_states(i,1)<=600)
            w(1,6)=w(1,6)+alpha*(G_t-w(1,6));
        elseif (traversed_states(i,1)>=601)&&(traversed_states(i,1)<=700)
            w(1,7)=w(1,7)+alpha*(G_t-w(1,7));
        elseif (traversed_states(i,1)>=701)&&(traversed_states(i,1)<=800)
            w(1,8)=w(1,8)+alpha*(G_t-w(1,8));
        elseif (traversed_states(i,1)>=801)&&(traversed_states(i,1)<=900)
            w(1,9)=w(1,9)+alpha*(G_t-w(1,9));
        elseif (traversed_states(i,1)>=901)&&(traversed_states(i,1)<=1000)
            w(1,10)=w(1,10)+alpha*(G_t-w(1,10));
        else
            fprint()
        end
    end
end
W=zeros(1,1000)
for i=1:101
    W(1,i)=w(1,1);
end
for i=101:200
    W(1,i)=w(1,2);
end
for i=201:300
    W(1,i)=w(1,3);
end
for i=301:400
    W(1,i)=w(1,4);
end
for i=401:500
    W(1,i)=w(1,5);
end
for i=501:600
    W(1,i)=w(1,6);
end
for i=601:700
    W(1,i)=w(1,7);
end
for i=701:800
    W(1,i)=w(1,8);
end
for i=801:900
    W(1,i)=w(1,9);
end
for i=901:1000
    W(1,i)=w(1,10);
end

%----------------------------------------%
%TD zero
w_1=zeros(1,10);
current_state=501;
for loop=1:100000
    traversed_states=[];
    current_state=501;
    traversed_states=[traversed_states;current_state];
    while(1)
        x=rand(1);
        if x<=0.5%right
            p=randi([1,100]);
            next_state=current_state+p;
            if next_state>1001
                next_state=1002;
            end
            traversed_states=[traversed_states;next_state];
        else
            p=randi([1,100]);
            next_state=current_state-p;
            if next_state<2
                next_state=1;
            end
            traversed_states=[traversed_states;next_state];
        end
        if next_state==1
            R=-1;
        elseif next_state==1002
            R=1;
        else
            R=0;
        end
        if (next_state>=2)&&(next_state<=101)
            val=w_1(1,1);
        elseif (next_state<=201) 
            val=w_1(1,2);
        elseif (next_state<=301)
            val=w_1(1,3);
        elseif (next_state<=401) 
            val=w_1(1,4);
        elseif (next_state<=501)
            val=w_1(1,5);
        elseif (next_state<=601) 
            val=w_1(1,6);
        elseif (next_state<=701) 
            val=w_1(1,7);
        elseif (next_state<=801) 
            val=w_1(1,8);
        elseif (next_state<=901) 
            val=w_1(1,9);
        elseif (next_state<=1001)
            val=w_1(1,10);
        end
        % current_state=[];
        if (current_state>=2)&&(current_state<=101)
            w_1(1,1)=w_1(1,1)+alpha*(R+val-w_1(1,1));
        elseif (current_state<=201)
            w_1(1,2)=w_1(1,2)+alpha*(R+val-w_1(1,2));
        elseif (current_state<=301)
            w_1(1,3)=w_1(1,3)+alpha*(R+val-w_1(1,3));
        elseif (current_state<=401) 
            w_1(1,4)=w_1(1,4)+alpha*(R+val-w_1(1,4));
        elseif (current_state<=501) 
            w_1(1,5)=w_1(1,5)+alpha*(R+val-w_1(1,5));
        elseif (current_state<=601) 
            w_1(1,6)=w_1(1,6)+alpha*(R+val-w_1(1,6));
        elseif (current_state<=701) 
            w_1(1,7)=w_1(1,7)+alpha*(R+val-w_1(1,7));
        elseif (current_state<=801) 
            w_1(1,8)=w_1(1,8)+alpha*(R+val-w_1(1,8));
        elseif (current_state<=901) 
            w_1(1,9)=w_1(1,9)+alpha*(R+val-w_1(1,9));
        elseif (current_state<=1001) 
            w_1(1,10)=w_1(1,10)+alpha*(R+val-w_1(1,10));
        end
        
        
        if next_state<=1
            break
        elseif next_state>=1002
            break
        end
        
        current_state=next_state;
    end
end
W_1=zeros(1,1000);
for i=1:100
    W_1(1,i)=w_1(1,1);
end
for i=101:200
    W_1(1,i)=w_1(1,2);
end
for i=201:300
    W_1(1,i)=w_1(1,3);
end
for i=301:400
    W_1(1,i)=w_1(1,4);
end
for i=401:500
    W_1(1,i)=w_1(1,5);
end
for i=501:600
    W_1(1,i)=w_1(1,6);
end
for i=601:700
    W_1(1,i)=w_1(1,7);
end
for i=701:800
    W_1(1,i)=w_1(1,8);
end
for i=801:900
    W_1(1,i)=w_1(1,9);
end
for i=901:1000
    W_1(1,i)=w_1(1,10);
end

%-----------------------------------------%
%True value
theta_constant=0.00001;
array = zeros(1,1002);
policy_a=1/2;
prob_matrix=zeros(1002,1002);
for i = 2:101
    sum=0;
    for j = 2:i-1
        prob_matrix(i,j)=0.01;
        sum=sum+prob_matrix(i,j);
    end
    prob_matrix(i,1)=1-sum;
    for j=i+1:i+100
        prob_matrix(i,j)=0.01;
    end
end
for i=102:901
    for j=i-100:i-1
        prob_matrix(i,j)=0.01;
    end
    for j=i+1:i+100
        prob_matrix(i,j)=0.01;
    end
end
for i=902:1001
    sum=0;
    for j = i+1:1001
        prob_matrix(i,j)=0.01;
        sum=sum+prob_matrix(i,j);
    end
    prob_matrix(i,1002)=1-sum;
    for j = i-100:i-1
        prob_matrix(i,j)=0.01;
    end
end

while(1)
    delta=0;
    for start_state=2:1001
        V_s = 0;
        for next_state=1:1002
            switch(next_state)
                case 1
                    V_s = V_s + (policy_a*(prob_matrix(start_state,next_state)*(-1+array(next_state))));
                case 1002
                    V_s = V_s + (policy_a*(prob_matrix(start_state,next_state)*(1+array(next_state))));
                otherwise
                    V_s = V_s + (policy_a*(prob_matrix(start_state,next_state)*(array(next_state))));
            end
        end
        abs_value=abs(V_s - array(start_state));
        delta=max(delta,abs_value);                                           
        array(start_state)=V_s;                                
    end
    if(delta<theta_constant)
        break; 
    end
end
toc;
W_2=array(:,2:1001);
figure(1)
plot(1:1000,W,'b')
hold on
plot(1:1000,W_1,'black')
hold on
plot(1:1000,W_2,'r')
