%gradient method - gold section search
%minimize the following
%z1 = @(x,y) x.^2+y.^2
%z2 = @(x,y) 1000*x.^2+y.^2
%z3 = @(x,y) 100000*x.^2+y.^2
%z4 = @(x,y) 100*x.^2+y.^2
%z5 = @(x,y) 100000*x.^2+y.^2
%z6 = @(x,y) 100*(x.^2-y).^2+(1-x).^2
%z7 = @(x,y) x.^3 + y.^3
%z8 = @(x,y) 1/3*(x + 1).^3 + y
%z9 = @(x,y) sin(x + y) + (x - y).^2 - 1.5 .* x + 2.5 .* y + 1
clear
clc
close all

phi = (1 + sqrt(5))/2; %golden ratio

z = @(x,y) 100*(x.^2 - y).^2+(1-x).^2; %function

grad_z = @(x,y) [x.*2000 y.*2]; %function gradient
r1 = [10200 63]; %inicital points
norma = abs(grad_z(r1(1),r1(2)));
r3 = r1 - r1.*phi.* grad_z(r1(1),r1(2)).*[1/norma(1), 1/norma(2)]; 
tol = norm(r1 - r3);

iter = 0;

while tol > 0.0001
    r2 = (r3 + phi.*r1)./(phi+1);
    
    fr1 = z(r1(1),r1(2));
    fr2 = z(r2(1),r2(2));
    fr3 = z(r3(1),r3(2));
    
    while tol > 0.0001
        if fr2 < fr1 && fr2 < fr3
            r4 = (r2 .* (phi + 1) - r1)./phi;
            fr4 = z(r4(1),r4(2));
            if fr4 > fr2
                r3 = r4;
                r2 = (r3 + phi.*r1)./(phi+1);
            else
                r1 = r2;
                r2 = (r3 + phi.*r1)./(phi+1);
            end
        elseif fr2 < fr3 && fr2 > fr1
            r3 = r2;
            r2 = (r3 + phi.*r1)./(phi+1);
        elseif fr2 > fr3 && fr2 > fr1
            r3 = r2;
            r2 = (r3 + phi.*r1)./(phi+1);
        elseif fr2 > fr3 && fr2 < fr1
            r1 = r2;
            r2 = (r3 + phi.*r1)./(phi+1);
        end
        tol = norm(r1 - r3);
        fr1 = z(r1(1),r1(2));
        fr2 = z(r2(1),r2(2));
        fr3 = z(r3(1),r3(2));
    end
    r3 = r1 - r1.*phi.* grad_z(r1(1),r1(2)).*[1/norma(1), 1/norma(2)]; 
    tol = norm(r1 - r3);
    iter = iter + 1;
end

x = linspace(-100,100,50);
y = x;
[X,Y] = meshgrid(x,y);
figure (1)
contour(X,Y,z(X,Y));
colormap jet 
xlabel('x')
ylabel('y')
zlabel('z')
hold on
plot(r4(1), r4(2), 'x', 'LineWidth', 3, 'MarkerSize', 18)
title(['função=' func2str(z)])
legend('função','mínimo')
hold off
figure (2)
surf(X,Y,z(X,Y));
colormap jet 
xlabel('x')
ylabel('y')
zlabel('z')
hold on
plot(r4(1), r4(2), 'x', 'LineWidth', 3, 'MarkerSize', 18)
title(['função=' func2str(z)])
legend('função','mínimo')
disp(['c1 = ' num2str(c(1))])
disp(['c2 = ' num2str(c(2))])
disp(['min = ' num2str(r4)])
disp(['iter = ' num2str(iter)])
