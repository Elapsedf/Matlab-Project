function result=match(L,final_L)
% 功能：产生两两配对的L*2维匹配结果（是index）
% 输入：需要进行配对的数的个数
% 输出：L*2维匹配结果（是index）
%记录配对结果，n*2维的矩阵
if rem(L,2)~=0
   L=L-1;  % 转为偶数
end
result = zeros(L/2,2);

%matlab的索引是从1开始的
i = 1; 
%记录已经出现过的下标
index = zeros(L,1);

while i<=L/2  %直到生成所有交叉对
    %生成进行交叉操作的二者下标序号
    x = randi(L);
    y = randi(L);

    %保证不与先前的随机序号重复
    while ~all(ismember(index,[x,y])==0)  % index中是否x,y已经匹配过
        x = randi(L);
        y = randi(L);
    end

    %在x和y不相等的条件下进行配对结果的更新
    if(x~=y)
        result(i,:)=[x,y];
        i=i+1;
        index(x)=x;
        index(y)=y;
    end
end
if rem(final_L,2)~=0
   final_L=final_L-1;  % 转为偶数
end
result=result(1:final_L/2,:);


