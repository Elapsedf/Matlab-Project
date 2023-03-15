function X_2=two2ten(X_)
% 功能：十进制转换二进制
% 输入：十进制的二位小数
% 输出：二进制的字符串

X=char(X_);
% 分别保留各位对应的二进制数
X1=X(1:3);  
X2=X(4:7);
X3=X(8:11);
X_2=floor(bin2dec(X1))+floor(bin2dec(X2))*0.1+floor(bin2dec(X3))*0.01;  % 转为十进制

end
