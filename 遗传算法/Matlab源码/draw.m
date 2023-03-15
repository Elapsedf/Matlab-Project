function draw(answer)
% 功能：画最优解变化趋势曲线
% 输入：最优解
t=1:1:length(answer);
plot(t,answer,'-o');
title("Curve of optimal solution changing with iteration number(Gen=20,pc=0.2,pm=0.2,P0=10,P=15)");
ylim([1,3]);
xlabel("iteration");
ylabel("Optimal solution");
for i=1:length(answer)
    text(i,answer(i),['(',num2str(i),',',num2str(answer(i)),')'])
end