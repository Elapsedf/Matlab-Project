function result=Optimize(P0,X)
% 功能：从种群中选择一些较优个体，保留进入下一代规模为 P0 种群
% 输入：选择出的规模，种群
% 输出：选优结果
X_=[];
for i=1:length(X)
    X_=[X_,two2ten(X(i))];  % 转换十进制
end

X_=reshape(X_,length(X_),1);
Y=reshape(round((X_-2).^2,2),length(X_),1);

res=[X_,Y];
res2=sortrows(res,2);  % 按照距离大小排序
result=res2(1:P0,1);  % 保留P0进入下一代                                                              % 10*1 string
end


  