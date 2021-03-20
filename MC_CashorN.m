clear
clc
clf

Rate = 0.05;
Price = 10;
Strike = 10;
Time = 1;
sigma = 0.35;
% mu= 0.03;
Cash=1;

for i=1:11
    M(i) = 2^(i+9);
    Exp(i) = i+9;
    [CallPrice(i), PutPrice, Delta(i)] = BSCashCall(Rate, Price, Strike, Time, sigma, Cash);
end


for i=1:11
   for j=1:M(i)
       
       %%% Generate stock price path
       S(j) = Price * exp((- 0.5 * sigma * sigma ) * Time + sigma * sqrt(Time) * randn);
       
       %%% Take payoff
       if (S(j)>Strike) V(j) = exp(-Rate * Time) * Cash;
       else V(j)=0;
       end
       
   end
   
   V_ave(i) = mean(V);
   V_se(i) = std(V)/sqrt(M(i));
    
end


plot(Exp, V_ave, '--rs')
hold on
plot(Exp, V_ave - 1.96 * V_se, '*b')
hold on
plot(Exp, V_ave + 1.96 * V_se, '*m')
hold on
plot(Exp, Delta(i), 'LineWidth', 1.5)
xlabel('The number of samples 2^x')
legend('MC mean', 'MC upper interval', 'MC lower interval', 'Black-Scholes value')
title('Cash-Or-Nothing Call Delta')

V_ave
