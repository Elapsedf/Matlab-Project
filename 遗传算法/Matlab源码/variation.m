function X_1=variation(X_1,pm)
% 功能：变异
% 输入：需变异的序号数组，二进制数组
% 输出：变异后的结果
picked_index = randi([1,length(X_1)],round(pm*length(X_1)),1);  % 生成进行信息变异的下标（整数）
for i=1:length(picked_index)
    X_1_=char(X_1(picked_index(i))); % 转换为字符数组
    idx=picked_index(i);
    % 对最后一位变异
    if X_1_(length(X_1_))=='1'  % 若最后一位是1,变异为0
        X_1_(length(X_1_))='0';
        X_1(idx)=string(X_1_);
    else
        X_1_(length(X_1_))='1';
        X_1(idx)=string(X_1_);
    end
end


% function X_1=variation(X_1)
% % 功能：变异
% % 输入：变异对象
% % 输出：变异后的结果
% X_1=char(X_1); % 转换为字符数组
% % 对最后一位变异
% if X_1(length(X_1))=='1'  % 若最后一位是1,变异为0
%     X_1(length(X_1))='0';
% else
%     X_1(length(X_1))='1';
% end
