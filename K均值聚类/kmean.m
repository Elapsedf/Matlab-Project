% 使用内置函数法
data=xlsread("sonar.xls");
global m n;
[m,n]=size(data);
global label alpha;   %声明为全局变量，方便后续使用
label=data(:, n);

X=data(:, 1:n-1);   %注意是n-1列
% [idx,C]=kmeans(X, 4);
% prec=0;
% for i =1:m
%     if idx(i)==label(i)
%         prec=prec+1;
%     end
% end
% acc=prec/m;
% str1=sprintf("五类准确率为：%d %%", acc*100);
% disp(str1);

% 自己实现
%初始化选择向量,尽量选择相距较大的，方便后续聚类
beta=3;
while 1
    a=randperm(m,2);
    k1=X(a(1), :);
    k2=X(a(2), :);
    if dist(k1,k2)>beta
        break
    end
end


%设置参数
epoch=50;
prec=zeros(epoch);
pred=zeros(m);
alpha=0.000000001;
%每次迭代
for i =1:epoch
    sumk1=zeros([1,n-1]);
    sumk2=zeros([1,n-1]);
    num1=0;
    num2=0;
    %遍历所有向量
    for j=1:m
        dis1=dist(X(j, :), k1);  
        dis2=dist(X(j, :), k2);
        if(dis1>dis2)
            pred(j)=2;
            sumk2=sumk2+X(j, :);
            num2=num2+1;
        else
            pred(j)=1;
            sumk1=sumk1+X(j, :);
            num1=num1+1;
        end
    end
    %计算当前准确率
    prec(i)=acc(pred);  
    %更新参数（更新k1，k2）
    k_1=sumk1/num1;
    k_2=sumk2/num2;
%     k1=k_1;
%     k2=k_2;
%     判断是否达到阈值
%     即两次中心的距离变化不超过阈值
    if norm(k_1-k1)<alpha && norm(k_2-k2)<alpha
        k1=k_1;
        k2=k_2;
        break
    else
        k1=k_1;
        k2=k_2;
    end
end
%由于前面初始化为0，所以此处负责清除0
prec(prec==0)=[];
%设置x并画图
x=1:size(prec,2);
plot(x, prec, 'r');
legend("acc vs epoch",'Location', 'NorthWest');
xlabel("epoch")
ylabel("acc");

%输出最后的中心点
str1=sprintf("x1:%f , x2: %f ", k1, k2);
disp("final center");
disp(str1);
%计算两个向量距离
function y=dist(x1, x2, n)
d=0;
global n;
for i =1:n-1        %n表示向量维度！总共n-1列！
    d=d+(x1(i)-x2(i))^2;
end
d=sqrt(d);
y=d;        %返回两个向量间的距离
end
%计算单次迭代的acc
function y=acc(pred, m)
y=0;
global label m;     %使用全局变量
for i =1:m
    if pred(i)==label(i)
        y=y+1;
    end
end
y=y/m;  %返回单次迭代acc
end