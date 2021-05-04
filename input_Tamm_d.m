%Original main code by Laurent Nevou
%Github repository link: https://github.com/LaurentNevou
%Link for specific code:
%https://github.com/LaurentNevou/Light_WaveTransmission1D_dispersion
%All material values for refractive index and extinction coefficient is
%taken from refractiveindex.info
%Modifications from source code: 
%Added data dispersion for silver and gold and their respective plot
%Added a spacer layer, length of metal and spacer layer were also added
%Changed the arrangement of the structure from VCSEL to Tamm



nL=1; %default value 1
nR=3; %default value 3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% import dispersion

M      = importdata('index_data/GaAs.csv',',');
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);
kM     = interp1(M(:,1),M(:,3),lambda);
nkGaAs = nM + kM*1i;

M      = importdata('index_data/AlAs.csv',',');
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);
kM     = interp1(M(:,1),M(:,3),lambda);
nkAlAs = nM + kM*1i;

M      = importdata('index_data/Au.csv',','); %Gold
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);
kM     = interp1(M(:,1),M(:,3),lambda);
nkAu = nM + kM*1i;

M      = importdata('index_data/Ag.csv',','); %Silver
M      = M.data;
M(:,1) = M(:,1)*1e-6;
nM     = interp1(M(:,1),M(:,2),lambda);
kM     = interp1(M(:,1),M(:,3),lambda);
nkAg = nM + kM*1i;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('color','w')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,1,1)
hold on;grid on;box on;
plot(lambda*1e9, real(nkGaAs) ,'b-')
plot(lambda*1e9, real(nkAlAs) ,'g-')
plot(lambda*1e9, real(nkAu)   ,'m-')
plot(lambda*1e9, real(nkAg)   ,'r-')

title('index dispersion')
xlabel('lambda (nm)')
ylabel('real part')
legend('real-GaAs','real-AlAs','real-Au','real-Ag')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,1,2)
hold on;grid on;box on;
plot(lambda*1e9, imag(nkGaAs),'b-')
plot(lambda*1e9, imag(nkAlAs),'g-')
plot(lambda*1e9, imag(nkAu),'m-')
plot(lambda*1e9, imag(nkAg),'r-')

xlabel('lambda (nm)')
ylabel('imaginary part')
legend('imag-GaAs','imag-AlAs','imag-Au','imag-Ag')

%Setting parameters

n1=nkGaAs; %Refractive index and extinction coefficient of GaAs
n2=nkAlAs; %Refractive index and extinction coefficient of AlAs
lambda0=1300e-9;      % Central wavelength

idx=find(abs(lambda-lambda0)==min(abs(lambda-lambda0)));      % take care that lambda0 MUST exists in the vector lambda
l1=lambda0/(4*abs(n1(idx)));   % thickness at lambda/4
l2=lambda0/(4*abs(n2(idx)));   % thickness at lambda/4
n3 = nkGaAs; %Refractive index and extinction coefficient of GaAs
l3=75e-9; %spacer layer control value 75nm %Highest Q is 25nm
lAu=25e-9; %metal layer control value 25nm %highest Q is 50nm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N_DBRn=20;                  %% amount of DBR n-doped pairs
N_DBRp=20;                  %% amount of DBR p-doped pairs

DBR_n=[]; DBRn=[ l1 n1 ; l2 n2 ]; %high to low (l1 is GaAs)
DBR_p=[]; DBRp=[ l2 n2 ; l1 n1 ]; %low to high (l2 is AlAs)

for jj=1:N_DBRn
  DBR_n = [ DBR_n ; DBRn ];
end
for jj=1:N_DBRp
  DBR_p = [ DBR_p ; DBRp ];
end

%Structure arrangement %Au = gold %Ag= silver

%layer=[ l3 n3 ; DBR_p ];                % without the gold layer (DBR and spacer Only)
%layer=[ lAu nkAg ; l3 n3 ; DBR_p ];    %silver layer + spacer layer + DBR
%layer=[ lAu nkAu ; l3 n3 ; DBR_p ];  %Gold + spacer + DBR
layer=[ lAu nkAu ; DBR_n ]; %no spacer



