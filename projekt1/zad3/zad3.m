l_z=[0,0.509,-0.0738,0.0267];
m_z=[1,-2.6472, 2.0564,-0.4966];

[A,B,C,D]=tf2ss(l_z, m_z);
A=A.';
B1=C.';
C1=B.';
C=C1;
B=B1;

clear u;
clear x1;
clear x2;
clear x3;
clear y;
for i = -0.5
z1=i;
z2 = z1;
z3 = z1;
K=acker(A,B,[z1 z2 z3]);

%z1=0.1;
%z2=i;
%z3=i;
%K=acker(A,B,[z1 z2 z3]);

k_konc=40;
x1(1)=1; 
x2(1)=-1; 
x3(1)=3;
x1(k_konc)=0; 
x2(k_konc)=0; 
x3(k_konc)=0;
u(1)=-(K(1,1)*x1(1)+K(1,2)*x2(1)+K(1,3)*x3(1));
y(1)=C(1,1)*x1(1)+C(1,2)*x2(1)+C(1,3)*x3(1);  

for k=2:k_konc;
    x1(k)=A(1,1)*x1(k-1)+A(1,2)*x2(k-1)+A(1,3)*x3(k-1)+B(1)*u(k-1);
    x2(k)=A(2,1)*x1(k-1)+A(2,2)*x2(k-1)+A(2,3)*x3(k-1)+B(2)*u(k-1);
    x3(k)=A(3,1)*x1(k-1)+A(3,2)*x2(k-1)+A(3,3)*x3(k-1)+B(3)*u(k-1);
    y(k)=C(1,1)*x1(k)+C(1,2)*x2(k)+C(1,3)*x3(k);
    u(k)=-(K(1,1)*x1(k)+K(1,2)*x2(k)+K(1,3)*x3(k));
 end;

subplot(2,2,1);
stairs(x1,'m'); 
title('x1'); 
xlabel('k');

subplot(2,2,2);
stairs(x2,'m'); 
title('x2'); 
xlabel('k');

subplot(2,2,3);
stairs(x3,'m'); 
title('x3'); 
xlabel('k');

subplot(2,2,4);
stairs(u); 
ylabel('u');
xlabel('k');
hold on;
subplot(2,2,4);
stairs(y); 
ylabel('y');
xlabel('k');
legend('u(k)','y(k)');
hold off;

print(['z1=', num2str(z1), 'z2=', num2str(z2), 'z3=', num2str(z3), '.png'],'-dpng');
end