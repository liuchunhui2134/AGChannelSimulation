clear all;
close all;
%场景设置
hA=3000;%飞机高度
hG=3;%地面天线高度
d=150000;%飞机-天线距离
fc=4e9;%载波频率
c=3e10;%光速
l=c/fc;%波长
Q=150;
rF=2.72;%表面粗糙因子
Dk=0.0018;%散度因子
TKF=0.875;%表面反射系数

%反射路径第一段分量
L1k=sqrt((hA)^2+(d-Q)^2);
%反射路径第二段分量
L2k=sqrt((hG)^2+Q^2);
%入射角正弦值
sin=hG/L2k;
%直射或LOS路径长度
R1k=sqrt((hA)^2+d^2);
%表面反射路径长度
R2k=L1k+L2k;
Rk=R2k-R1k;%路径差
b=zeros(80,8);
b(:,1)=1;
b(:,2)=0.8619759378265;
real1=zeros(80,8);
imag1=zeros(80,8);
real=zeros(80,8);
imag=zeros(80,8);
xishu=zeros(80,16);
for m=1:80
%多径信道模型
a=normrnd(-25,3,1,6);%随机功率
for k=3:8
    b(m,k)=sqrt(10^(a(k-2)/10));
end

c=6.18*rand(1,16);%生成随机相位
%imag1=zeros(1,9);
for k=1:8
    imag1(m,k)=b(m,k)*cos(pi/2-c(k));
    %imag1(k)=b(k)*sin(c(k));
    real1(m,k)=b(m,k)*cos(c(k));
end
end

A=imag1.^2;
B=real1.^2;
C=A+B;
sum=sum(C,2);

for m=1:80
real(m,:)=real1(m,:)/sqrt(sum(m,1));
imag(m,:)=imag1(m,:)/sqrt(sum(m,1));
for i=1:1:8
   xishu(m,i)=real(m,i);%实部在每行前面
   xishu(m,i+8)=imag(m,i); %虚部在每行后面
end
end
dlmwrite('2216.txt',xishu,'delimiter',' ','newline','pc'); %保存矩阵,中间空格



