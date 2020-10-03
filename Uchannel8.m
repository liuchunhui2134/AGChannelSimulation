clear all;
close all;
%��������
hA=3000;%�ɻ��߶�
hG=3;%�������߸߶�
d=150000;%�ɻ�-���߾���
fc=4e9;%�ز�Ƶ��
c=3e10;%����
l=c/fc;%����
Q=150;
rF=2.72;%����ֲ�����
Dk=0.0018;%ɢ������
TKF=0.875;%���淴��ϵ��

%����·����һ�η���
L1k=sqrt((hA)^2+(d-Q)^2);
%����·���ڶ��η���
L2k=sqrt((hG)^2+Q^2);
%���������ֵ
sin=hG/L2k;
%ֱ���LOS·������
R1k=sqrt((hA)^2+d^2);
%���淴��·������
R2k=L1k+L2k;
Rk=R2k-R1k;%·����
b=zeros(80,8);
b(:,1)=1;
b(:,2)=0.8619759378265;
real1=zeros(80,8);
imag1=zeros(80,8);
real=zeros(80,8);
imag=zeros(80,8);
xishu=zeros(80,16);
for m=1:80
%�ྶ�ŵ�ģ��
a=normrnd(-25,3,1,6);%�������
for k=3:8
    b(m,k)=sqrt(10^(a(k-2)/10));
end

c=6.18*rand(1,16);%���������λ
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
   xishu(m,i)=real(m,i);%ʵ����ÿ��ǰ��
   xishu(m,i+8)=imag(m,i); %�鲿��ÿ�к���
end
end
dlmwrite('2216.txt',xishu,'delimiter',' ','newline','pc'); %�������,�м�ո�



