function result=exchange_info(matched_pair,Y_2)
% 功能：两两交叉
% 输入：需交叉的序号数组，二进制数组
% 输出：交叉后的结果
result=[];
[row,col]=size(matched_pair);  % 保存行列数，一行代表一组配对数
for i=1:row
    a=matched_pair(i,1);  % 需要交换的idx
    b=matched_pair(i,2);

    needed_1=Y_2(a); % 需要交换的两个字符串
    needed_2=Y_2(b);

    char1=char(needed_1);  % 转为char型
    char2=char(needed_2);
    
    result_1=string(char1(1:5))+string(char2(6:11)); % 交叉拼接
    result_2=string(char2(1:5))+string(char1(6:11));
    result=[result,result_1,result_2];
end


% function result=exchange_info(code1,code2)
% % 功能：两两交叉
% % 输入：二进制编码（字符串）
% % 输出：交叉后的结果
% 
% % 转换为char型
% char1=char(code1);  
% char2=char(code2);
% 
% % 交叉拼接
% result_1=string(char1(1:4))+string(char2(5:9));
% result_2=string(char2(1:4))+string(char1(5:9));
% result=[result_1,result_2];
% end
% 
