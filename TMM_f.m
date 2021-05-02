%Original main code by Laurent Nevou
%Github repository link: https://github.com/LaurentNevou
%Link for this code:
%https://github.com/LaurentNevou/Light_WaveTransmission1D_dispersion
% TMM code

%The cycle over wavelength. The variable wavelength is counter and it takes
%on values from 1 to length of the array lambda 
function[A,B,psi]=TMM_f(zz,zv,nt,nL,nR,lambda)

AmplitudeInput=1;
%Here we compute the wave number
k=2*pi/lambda;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Left bondary condition
M=[];
%Two-dimentional array coefMatrix(M) contains the coefficients at unknowns
%of the system of linear equations. Because the coefficient A0 is
%user-defined (as we determined from initial condition) first two rows of
%the matrix contains coefficient B0, A1, B1 only. Consequently, they should
%be defined outside the cycle (main script). Moreover, the coordinate of
%the first interface is assumed to be euqal to zero so all the exponents
%here vanish.
M(1,1:3)=[1 -1 -1];
M(2,1:3) = [-1i*k*nL -1i*k*nt(1)  1i*k*nt(1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filling the matrix

%The following cycle scans over all interfaces. The Scanning begins from
%the interface between two first layers
for j=1:length(nt)-1
%Defining the function equality condition at the boundary
  M(j*2+1,2*j:2*j+3) = [exp(1i*k*nt(j)*zz(j)) exp(-1i*k*nt(j)*zz(j)) -exp(1i*k*nt(j+1)*zz(j)) -exp(-1i*k*nt(j+1)*zz(j))];
%Defining the function derivatives equality condition at the boundary
  M(j*2+2,2*j:2*j+3) = ...
  [1i*k*nt(j)*exp(1i*k*nt(j)*zz(j)) -1i*k*nt(j)*exp(-1i*k*nt(j)*zz(j)) -1i*k*nt(j+1)*exp(1i*k*nt(j+1)*zz(j)) 1i*k*nt(j+1)*exp(-1i*k*nt(j+1)*zz(j))];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right bondary condition
% The boundary conditions at the last interface are defined manually as it
% was done for the first one because we constituted the coefficient BN+1 to
% be equal to zero
M(length(nt)*2+1,2*length(nt):2*length(nt)+2)= [exp(1i*k*nt(end)*zz(j+1)) exp(-1i*k*nt(end)*zz(j+1)) -exp(1i*k*nR*zz(j+1))];

M(length(nt)*2+2,2*length(nt):2*length(nt)+2)= [1i*k*nt(end)*exp(1i*k*nt(end)*zz(j+1)) -1i*k*nt(end)*exp(-1i*k*nt(end)*zz(j+1)) -1i*k*nR*exp(1i*k*nR*zz(j+1))];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Defining column matrix containing the array of free terms. Non-zero
%elements of this array are only two first elements because we assumed A0
%to be euqal to 1. For other equations free terms equal to zero.
D=zeros(length(M),1); %D is the freememberMatrix
D(1)=-sqrt(AmplitudeInput);
D(2)=-sqrt(AmplitudeInput)*1i*k*nL;

AB=inv(M)*D; %D is responsible for both Transmittance and Reflectance
A=[1 ; AB(2:2:end)]; %Transmittance, A0 = 1
B=[AB(1:2:end-1) ; 0]; %Reflectance, other free terms = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


psi=[]; %Electric field
for j=1:length(nt) %1i=imaginary j
  
  psi= [ psi  A(j+1)*exp(1i*k*nt(j)*zv{j}) + B(j+1)*exp(-1i*k*nt(j)*zv{j}) ]; %Helmholz's solution
  
end
