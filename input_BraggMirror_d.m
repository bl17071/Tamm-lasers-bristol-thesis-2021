%Original main code by Laurent Nevou
%Github repository link: https://github.com/LaurentNevou
%Link for specific code:
%https://github.com/LaurentNevou/Light_WaveTransmission1D_dispersion
%All material values for refractive index and extinction coefficient is
%taken from refractiveindex.info
%Modifications from source code:
%Added dispersion for AlN, GaN, ZnS, MgF2 for comparison
%Changed the values of input parameter for central wavelength and number of pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Bragg Mirror structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nL=1; %nL and nR parameters are for TMM function use, 1 is the boundary condition of air on both left and right spacer
nR=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% import dispersion

M      = importdata('index_data/GaAs.csv',',');
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);%real
kM     = interp1(M(:,1),M(:,3),lambda);%imaginary
nkGaAs = nM + kM*1i;

M      = importdata('index_data/AlAs.csv',',');
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);
kM     = interp1(M(:,1),M(:,3),lambda);
nkAlAs = nM + kM*1i;

M      = importdata('index_data/AlN.csv',','); 
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);%real
kM     = interp1(M(:,1),M(:,3),lambda);%imaginary
nkAlN = nM + kM*1i;

M      = importdata('index_data/GaN.csv',',');%k value limited to 1000nm, not 1300nm
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);
kM     = interp1(M(:,1),M(:,3),lambda);
nkGaN = nM + kM*1i;

M      = importdata('index_data/ZnS.csv',',');
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);
kM     = interp1(M(:,1),M(:,3),lambda);
nkZnS = nM + kM*1i;

M      = importdata('index_data/MgF2.csv',',');
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);
kM     = interp1(M(:,1),M(:,3),lambda);
nkMgF2 = nM + kM*1i;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,1,1)
hold on;grid on;box on;
plot(lambda*1e9, real(nkGaAs) ,'r-')
plot(lambda*1e9, real(nkAlAs) ,'b-')
title('Reflection coefficient n and Extinction coefficient k of GaAs/AlAs')
xlabel('lambda (nm)')
ylabel('Reflection coefficient')
legend('real-GaAs','real-AlAs')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,1,2)
hold on;grid on;box on;
plot(lambda*1e9, imag(nkGaAs),'r-')
plot(lambda*1e9, imag(nkAlAs),'b-')
% plot(lambda*1e9, imag(nkGaN) ,'m-') %GaN doesn't cover 1300nm 
% plot(lambda*1e9, imag(nkAlN) ,'k-')
% plot(lambda*1e9, imag(nkZnS) ,'g-')
% plot(lambda*1e9, imag(nkMgF2) ,'y-')
xlabel('lambda (nm)')
ylabel('Extinction coefficient')
legend('imag-GaAs','imag-AlAs')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


n1=nkGaAs; %Refractive index and extinction coefficient of GaAs
n2=nkAlAs; %Refractive index and extinction coefficient of AlAs
lambda0=1300e-9;      % Central wavelength
l1=1*lambda0/(4*abs(mean(n1)));   % thickness at lambda/4
l2=1*lambda0/(4*abs(mean(n2)));   % thickness at lambda/4

%structure
layer=[
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
];
