clc
clf
clear all
alpha=0.01;
gamma=0.99;
num_states=[1,2,3,4,5,6,7];
w=[1,1,1,1,1,1,10,1];
W1=[1];
W2=[1];
W3=[1];
W4=[1];
W5=[1];
W6=[1];
W7=[10];
W8=[1];
reward=0;
probability_solid=1/7;
delta_constant=0;
temp_const=[];
feature_vector=zeros(7 ,8);% 7 rows of states and 8 columns of weights
for i=1:7
    switch(i)
        case {1,2,3,4,5,6}
            feature_vector(i,i)=2;
            feature_vector(i,8)=1;
        otherwise
            feature_vector(i,i)=1;
            feature_vector(i,8)=2;
    end
end

current_state=randi([1,7]); % choose a state randomly from 1 to 7
tic;
for i=1:1000
    x=binornd(1,probability_solid);
    
    switch(x)
        case 1 %solid
            next_state=7;
            rho_t=1/probability_solid;
        otherwise %dashed
            next_state=randi([1,6]);
            rho_t=0;
    end
    
    v_hat= dot(feature_vector(current_state,:),w);
    
    v_hat_1= dot(feature_vector(next_state,:),w);
    
    delta_constant=reward+gamma*v_hat_1-v_hat;
    
    constant=delta_constant*alpha*rho_t;
    
    temp_const= constant*feature_vector(current_state,:);
    
    w=w+temp_const;
    
    W1=[W1;w(1)];
    W2=[W2;w(2)];
    W3=[W3;w(3)];
    W4=[W4;w(4)];
    W5=[W5;w(5)];
    W6=[W6;w(6)];
    W7=[W7;w(7)];
    W8=[W8;w(8)];
    
    current_state=next_state;
    
end
toc;
figure(1)
plot(0:1000,W8,'k');
hold on
plot(0:1000,W7,'r');
hold on
plot(0:1000,W6,'b');
hold on
plot(0:1000,W5,'k');
hold on
plot(0:1000,W4,'g');
hold on
plot(0:1000,W3,'y');
hold on
plot(0:1000,W2,'m');
hold on
plot(0:1000,W1,'c');