%设置参数
Gen=10;
pc=0.6;
pm=0.2;
P0=10;
P=15;

% 设置参数
% Gen=20;
% pc=0.2;
% pm=0.2;
% P0=10;
% P=15;

X=round(1+3*rand(P0,1),2);  % 随机生成范围在（0，2）的P0个数
Y=round((X-2).^2,2);  % 四舍五入
X_2=[];

% 转换为二进制编码
for i=1:P0
    X_2=[X_2,ten2two(X(i))];
end
answer=[];  % 存历次遍历结果

for i=1:Gen
    L=pc*P0;  % 生成个体的个数
    matched_pair = match(P0,L);  % 两两配对的序号数组
    result=exchange_info(matched_pair,X_2);  % 进行交叉

    X_try1=[X_2,result];
    if length(X_try1)<P  % 若交叉后个体数目未达到P 则从原样本中复制
        X_try1=[X_try1,X_2];
    end
    X_try1=X_try1(1:P);  % 使之规模达到 P

    X_try2=variation(X_try1,pm);  % 以概率 pm在种群中执行变异操作
    X_try3=Optimize(P0,X_try2);  % 选择操作
    answer=[answer,X_try3(1)];  % 将最优个体保存
    
    % 为下一轮的X做准备
    X_try=[];
    for j=1:P0
        X_try=[X_try,ten2two(X(j))];  % 转换二进制
    end
    X_2=X_try;
end

draw(answer)  % 绘图

% % 设置参数
% Gen=20;
% pc=0.2;
% pm=0.2;
% P0=10;
% P=15;
% 
% X=round(1+3*rand(P0,1),2);  % 随机生成范围在（0，2）的P0个数
% Y=round((X-2).^2,2);  % 四舍五入
% X_2=[];
% 
% % 转换为二进制编码
% for i=1:P0
%     X_2=[X_2,ten2two(X(i))];
% end
% answer=[];  % 存历次遍历结果
% 
% for i=1:Gen
%     L=pc*P0;  % 生成个体的个数
%     matched_pair = match(P0,L);  % 两两配对的序号数组
%     result=exchange_info(matched_pair,X_2);  % 进行交叉
% 
%     X_try1=[X_2,result];
%     if length(X_try1)<P  % 若交叉后个体数目未达到P 则从原样本中复制
%         X_try1=[X_try1,X_2];
%     end
%     X_try1=X_try1(1:P);  % 使之规模达到 P
% 
%     X_try2=variation(X_try1,pm);  % 以概率 pm在种群中执行变异操作
%     X_try3=Optimize(P0,X_try2);  % 选择操作
%     disp(X_try3(1));  % 输出当前最优个体
%     
%     % 为下一轮的X做准备
%     X_try=[];
%     for j=1:P0
%         X_try=[X_try,ten2two(X(j))];  % 转换二进制
%     end
%     X_2=X_try;
% end

