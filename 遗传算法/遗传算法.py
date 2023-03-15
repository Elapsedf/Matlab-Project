import random
import copy
import matplotlib.pyplot as plt
import heapq
class heredity(object):
    def __init__(self, Gen,p_c,p_m,P_0,P):
        self.Gen=Gen
        self.p_c=p_c
        self.p_m=p_m
        self.P_0=P_0
        self.P=P
        self.numbers=[]
        self.codes=[]
    def encode(self,n):    #编码！
        n=str(round(n,2))
        n_=n.split(".")     #讲字符串在.号拆分
        n1=int(n_[0])       #取出整数位

        list1=list(n_[1])   #先将其转为列表
        list1.reverse()     #反转，因为后续输出是反转输出
        s1=(''.join(list1)) #转为字符串，方便后续转为int
        n2=int(s1)          #得到反转后数字形式
        code=[]

        def two(n):
            b = []  # 存储余数
            while n:  # 一直循环，商为0时利用break退出循环
                b.append(n%2)
                n = n // 2  # 商
            while len(b)<4:
                b.append(0)
            b.reverse()  # 使b中的元素反向排列
            b = [ str(i) for i in b ]
            b=(''.join(b))
            #print ('该数字转换为二进制后是：')
            #print(b)
            return b
        
        n1=two(n1).lstrip('0')  #除去前导0
        code.append(n1)         
        while n2!=0:    #对小数点后的数字进行转码
            remainder=n2%10
            code.append(two(remainder))
            n2=n2//10
        code = [ str(i) for i in code ]
        code=(''.join(code))
        #print("the code is :")
        #print(code)
        return code
    #def decode(self, code):

    def inputinit(self):   #输出初始种群
        for i in range(self.P_0):
            self.numbers.append(round(random.uniform(1,4),2))
            self.codes.append(self.encode(self.numbers[i]))      #是self.twocode
        
    def cross(self):
        #cron=int(self.P*self.p_m)
        p=self.P_0
        newcodes=[]
        while p<self.P:
            c=random.sample(range(self.P_0), 2)     #采样
            code1=self.codes[c[0]]
            code2=self.codes[c[1]]
            len1=len(code1)
            len2=len(code2)
            minlen=min(len1,len2)
            pos=random.randint(0,minlen-1)
            #print("pos is: " ,pos+1)
            str1=code1[pos:]
            str2=code2[pos:]
            newcode1=code1[0:pos]+str2
            newcode2=code2[0:pos]+str1
            newcodes.append(newcode1)
            newcodes.append(newcode2)
            p+=2
        while len(newcodes)>self.P-self.P_0:
            newcodes.pop()
            #print("after cross")
            #print(newcode1)
            #print(newcode2)
            #return newcode1,newcode2
        self.codes+=newcodes    #添加新对象
    def variation(self):
        varn=int(self.P*self.p_m)       #变异的数量
        sam=random.sample(range(self.P),varn)       #采样
        for i in range(varn):
            code=self.codes[sam[i]]     #取出对应index的code
            pos=random.randint(0,len(code)-1)
            #print(code)
            ls=list(code)
            #print("pos is: " ,pos+1)
            ls[pos]=str(int(not int(code[pos])))
            code=(''.join(ls))
            self.codes[sam[i]]=code
            #print("variation after ------")
            #print(code)
        #return code
    def decodes(self,code):
        len1=len(code)%4
        q=len(code)//4
        n1=int(code[0:len1],2)
        bit=0
        n2=0
        #每隔四位取出
        while q:
            n3=int(code[len1:len1+4],2)
            n2=n2*10+n3
            bit+=1
            len1+=4
            q-=1
        n2=n2/(10**bit)
        num=n1+n2
        return num
    def lossfunction(self, value):
        return (value-2)**2
    def choose(self):
        loss=[]
        numbers=[]
        for i in range(len(self.codes)):
            numbers.append(self.decodes(self.codes[i]))
        #self.numbers=copy.deepcopy(numbers)
        for i in range(self.P):
            loss.append(self.lossfunction(numbers[i]))
        def getListMinNumIndex(num_list,topk=self.P_0):
            #tmp_list=copy.deepcopy(num_list)
            #tmp_list.sort()
            #min_num_index=[num_list.index(one) for one in tmp_list[:topk]]  存在重复值，不可用！    
            #print ('min_num_index:',min_num_index)
            min_number = heapq.nsmallest(topk, num_list) 
            min_index = []
            for t in min_number:
                index = num_list.index(t)
                min_index.append(index)
                a=float('-inf')
                num_list[index] = a
            return min_index, min_number[0],min_index[0]
        index, min, best_index=getListMinNumIndex(loss)
        best_solution=numbers[best_index]
        #选择出来后，更新！
        #self.numbers=copy.deepcopy(numbers[index])
        self.numbers=[numbers[i] for i in index]  
        self.codes=[self.codes[i] for i in index]
        return min,best_solution        #返回每一轮的最小loss值和最优解
    def forward(self):
        #初始化
        self.inputinit()
        minlist=[]
        best_list=[]
        for i in range(self.Gen):
            #交叉
            self.cross()
            #变异
            self.variation()
            #选择优化
            min,best_solution=self.choose()
            best_list.append(best_solution)
            minlist.append(min)
        return minlist,best_list        #返回最后一次迭代numbers和每次迭代的最优解loss值
        
        
        
        
#n1 = input('请输入要转换进制的数值：')
#n2 = input('请输入要转换进制的数值：')
Gen=20
p_c=0.6
p_m=0.2
P_0=20
P=30
H1=heredity(Gen,p_c,p_m,P_0,P)
minlist,bestlist=H1.forward()

#print(numbers)

#输出最优解
print("最后一次最优解为: ",bestlist[-1])
#plt.plot(range(Gen), minlist)
fig=plt.figure()
ax1=fig.add_subplot(121)
ax1.plot(range(Gen), minlist)
plt.xlabel("epoch")
plt.ylabel("loss")
plt.title("Gen:20 pc:0.6 pm:0.2 P0:20 P:30")
ax2=fig.add_subplot(122)
ax2.plot(range(Gen), bestlist)
plt.xlabel("epoch")
plt.ylabel("best solution")
plt.show()
plt.title("Gen:20 pc:0.2 pm:0.2 P0:10 P:15")