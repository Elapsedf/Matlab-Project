% function X_2=ten2two(X_)
% % 功能：十进制转换二进制
% % 输入：十进制的二位小数
% % 输出：二进制的字符串
% X=X_*100;  % X_是一个二位小数 令其变为三位数整数
% X1=rem(X,10);  % 个位s
% X2=rem(floor(X/10),10);  % 十位 取整函数
% X3=rem(floor(X/100),10);  % 百位
% X_2=string(sprintf('%03s',dec2bin(X3)))+string(sprintf('%04s',dec2bin(X2)))+string(sprintf('%04s',dec2bin(X1))); % 转为二进制 不足位数的补零
% X_2=string(X_2);
% end

function X_2=ten2two(X_)
% 功能：十进制转换二进制
% 输入：十进制的二位小数
% 输出：二进制的字符串
X=X_*100;  % X_是一个二位小数 令其变为三位数整数
X1=rem(X,10);  % 个位
X2=rem(floor(X/10),10);  % 十位 
X3=rem(floor(X/100),10);  % 百位
X_2=string(sprintf(dec2bin(X3)))+string(sprintf('%04s',dec2bin(X2)))+string(sprintf('%04s',dec2bin(X1))); % 转为二进制 不足位数的补零
X_2=string(X_2);
end