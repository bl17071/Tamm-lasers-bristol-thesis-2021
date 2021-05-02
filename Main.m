%Original main code by Laurent Nevou
%Github repository link: https://github.com/LaurentNevou
%Link for this code:
%https://github.com/LaurentNevou/Light_WaveTransmission1D_dispersion

clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lambda=(1000:0.1:1600)*1e-9; %Lambda range
dz=1e-9;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Choose your structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%comment one of these structures

%input_BraggMirror_d
input_Tamm_d

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Discretisation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% here, I descretize the grid z and the optical index n

t  = layer(:,1);
nt = layer(:,2:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:length(t)
  
  if j==1
    zz(1) = t(1);
    zv{1} = 0:dz:t(1); 
    z     = zv{1};
    n     = repmat((zv{j}'*0+1),[1 length(lambda)] ) .* repmat(nt(j,:),[length(zv{j}') 1]);
  else
    zz(j) = zz(end)+t(j);
    zv{j} = (zz(end-1)+dz):dz:zz(end);
    z     = [ z  zv{j} ];
    n     = [ n  ; repmat((zv{j}'*0+1),[1 length(lambda)] ) .* repmat(nt(j,:),[length(zv{j}') 1])  ];
  end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for l=1:length(lambda)

  [AA,BB,psi] = TMM_f(zz,zv,nt(:,l),nL,nR,lambda(l)); %TMM function on structure
  
  A(:,l)=AA; %Transmittance
  B(:,l)=BB; %Reflectance
  PSI(:,l)=psi.'; %Electric field
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FS=14;
LW=2;
idx=find(abs(lambda-lambda0)==min(abs(lambda-lambda0)));

% Refractive index profile

figure()
hold on;grid on;box on;

plot(z*1e6,abs(n(:,idx)),'b','linewidth',LW)

xlim([0 z(end)]*1e6)
ylim([0 9])
xlabel('z (um)')
ylabel('optical index')
title('Refractive index profile')

%Electric field spectra

figure ()
hold on;grid on;box on;

plot(z*1e6,real(PSI(:,idx)),'b.-','linewidth',LW)
plot(z*1e6,imag(PSI(:,idx)),'g.-','linewidth',LW)

plot(z*1e6,(abs(PSI(:,idx))).^2,'r.-','linewidth',LW)

xlim([0 z(end)]*1e6)
title('Electric field spectra')
xlabel('z (um)')
ylabel('Electrical field')
legend('real(E)','imag(E)','|E|^2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(lambda)>1
figure('DefaultAxesFontSize',16)
hold on;grid on;box on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = abs(B(1,:)).^2; %Reflectance data
T = (nR/nL) * abs(A(end,:)).^2 ; %Transmittance data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(lambda*1e9,T,'g-','linewidth',LW)
plot(lambda*1e9,R,'m-','linewidth',LW)

legend('Transmittance','Reflectance')
ylabel('Reflectance index','fontsize',16)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlabel('lambda (nm)','fontsize',16)
xlim([lambda(1) lambda(end)]*1e9)
set(gca,'XTick',[lambda(1)*1e9 : 200 : lambda(end)*1e9]);
ylim([0 1.15])
title('Tamm','fontsize',16);

end
