%
% KERNEL ARMA
% Version 1.1 [20-Feb-2006]
%
% DEMO for THE PAPER:
% 
% "Support Vector Machines for Nonlinear Kernel ARMA System Identification," 
% M. Martinez-Ramon, J.L. Rojo-Alvarez, G. Camps-Valls, J. Munoz-Mari, A. Navia-Vazquez, E. Soria-Olivas, A.R. Figueiras-Vidal 
% IEEE Trans. on Neural Network, vol. 17, no. 6, pp. 1617 - 1622 , Jun 2006.
% http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=4012036&tag=1
%
% CONTENTS:
%
%	BuildData			-	Returns the training and test patterns from a signal given an order P and Delay=0 (initial conditions).
%	BuildKernels		-	Builds the kernel matrices as a function of a given method ('svr','2k','4k','svr+2k','svr+4k')
%	ComputeResults		-	Computes different accuracy/bias measurements from an actual and predicted signals.
%	DemoKARMA			-	Script demonstrating the training of SVM-ARMA methods in a given problem with fixed free parameters.
%	kernelmatrix		-	Builds the kernel matrix for a given method. At present, only RBF kernels.
%	TrainKernel			-	Trains a kernel matrix and returns the test outputs, nMSE, and model characteristics.
%
% Copyright (c) 2006
% Jordi Muñoz-marí, Gustavo Camps-Valls, Manel Martínez-Ramón, José L. Rojo-Álvarez
%
