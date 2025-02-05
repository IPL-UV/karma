% --------------------------------------------------------------------------------------------------------------------------
%
% DEMO FOR TRAINING COMPOSITE SVM-ARMA METHODS in a GIVEN PROBLEM WITH FIXED FREE PARAMETERS
%
% METHODS:
%
%       1) 'svr'     % K1(z,z) only uses parameter p1.z with Gaussian width sigma, the rest are ignored
%       2) '2k';     % K1(x,x) + K2(y,y), where parameters p1.x, p1.y are used
%       3) 'svr+2k'  % K1(x,x) + K2(y,y) + K3(z,z), where parameters p1.x, p1.y are use and p1.z is used for K3 ('svr')
%       4) '4k';     % K1(x,x) + K2(x,y) + K3(y,x) + K4(y,y).
%       5) 'svr+4k'  % composite kernels for improved versatility. We combine '4k' with 'svr'
%
% SOLVERS:
%
%       1) 'l2'    :  L2 norm of errors, which yields the kernel ridge
%       regression solution (suited for Gaussian noise)
%       2) 'eps'   :  epsilon insensitivity cost, which yields the standard SVR solution
%       3) 'ehuber':  epsilon-Huber loss is a composition of the previous
%       loss functions
%
% Jordi Munoz-Mari & Gustavo Camps-Valls, 2006(c)
% {jordi,gcamps}@uv.es
%
% --------------------------------------------------------------------------------------------------------------------------

clear;clc;close all

%% ADD SOME FOLDERS TO THE PATH
addpath('./data/')
addpath('./svm_code/')

%% SETUP of FIGURES
fontname = 'AvantGarde';
fontsize = 16;
fontunits = 'points';
set(0,'DefaultAxesFontName',fontname,'DefaultAxesFontSize',fontsize,'DefaultAxesFontUnits',fontunits,...
    'DefaultTextFontName',fontname,'DefaultTextFontSize',fontsize,'DefaultTextFontUnits',fontunits,...
    'DefaultLineLineWidth',2,'DefaultLineMarkerSize',10,'DefaultLineColor',[0 0 0]);

% --------------------------------------------------------------------------------------------------------------------------
% Problem and method selection:
% --------------------------------------------------------------------------------------------------------------------------
%methods = {'svr' '2k' 'svr+2k' '4k' 'svr+4k'};
%loss    = {'l2' 'eps' 'ehuber'};
method  = '4k';
problem = 'mg17';

% --------------------------------------------------------------------------------------------------------------------------
% Free Parameters (cost function and data)
% --------------------------------------------------------------------------------------------------------------------------
D		= 0;	% no delay of the signal
p		= 2;	% number of taps
e       = 1e-5;	% epsilon insensitivity zone
C		= 1e2;	% Penalization parameter
gam		= 1e-4;	% Regularization factor of the kernel matrix (gam*C is the amount of Gaussian noise region in the loss)

% --------------------------------------------------------------------------------------------------------------------------
% Free Parameters (kernel)
% --------------------------------------------------------------------------------------------------------------------------
ker      = 'rbf';
kparams.x	 = 2;	 % Gaussian kernel width for the input signal kernel
kparams.y	 = 2;    % Gaussian kernel width for the output signal kernel
kparams.z	 = 2;    % Gaussian kernel width for the stacked signal kernel
kparams.xy	 = 2;    % Gaussian kernel width for the cross-information signal kernel

% -----------------------------------------------------------------------------
% Load data
% -----------------------------------------------------------------------------
load mg17.dat
N = 500;
M = 1000;
X = mg17(1:N-1);
Y = mg17(2:N);
X2 = mg17(N+1:N+M-1);
Y2 = mg17(N+2:N+M);

% -----------------------------------------------------------------------------
% Generate input/output data matrices with a given signal delay D and tap
% order p. The data matrices are not scaled/standardized.
% -----------------------------------------------------------------------------
[Hx,Hy,Hx2,Hy2] = BuildData(X,Y,X2,Y2,D,p);

% -----------------------------------------------------------------------------
% Build kernel matrices from these data matrices:
% -----------------------------------------------------------------------------
[K,K2] = BuildKernels(Hx,Hy,Hx2,Hy2,ker,kparams,method);

% -----------------------------------------------------------------------------
% Train a regression algorithm (KRR, e-SVR, e-Huber-SVR) with the previous
% kernel matrices
% -----------------------------------------------------------------------------
[Y2hat_krr,results_krr,model_krr]          = TrainKernel(K,K2,Y,Y2,D,p,gam,e,C,'l2');
[Y2hat_svr,results_svr,model_svr]          = TrainKernel(K,K2,Y,Y2,D,p,gam,e,C,'eps');
[Y2hat_ehuber,results_ehuber,model_ehuber] = TrainKernel(K,K2,Y,Y2,D,p,gam,e,C,'ehuber');

results_krr
results_svr
results_ehuber

% -----------------------------------------------------------------------------
% Results
% -----------------------------------------------------------------------------

% Scatter plots of Actual vs Predictions
figure,scatterhist(Y2(p+1:end-D),Y2hat_krr), title('KRR')
figure,scatterhist(Y2(p+1:end-D),Y2hat_svr), title('\epsilon-SVR')
figure,scatterhist(Y2(p+1:end-D),Y2hat_ehuber), title('\epsilon-Huber SVR')

% Boxplot of residuals
E1 = Y2hat_krr-Y2(p+1:end-D);
E2 = Y2hat_svr-Y2(p+1:end-D);
E3 = Y2hat_ehuber-Y2(p+1:end-D);
figure, boxplot([E1 E2 E3])
set(gca,'xtick',1:3,'XTickLabel',{'KRR', 'e-SVR', 'e-Huber SVR'})
