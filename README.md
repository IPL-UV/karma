# Kernel ARMA

**Version:** 1.1  
**Release Date:** 20-Feb-2006  

This repository contains the implementation of Kernel ARMA methods as described in the paper:

> **"Support Vector Machines for Nonlinear Kernel ARMA System Identification"**  
> *M. Martinez-Ramon, J.L. Rojo-Alvarez, G. Camps-Valls, J. Munoz-Mari, A. Navia-Vazquez, E. Soria-Olivas, A.R. Figueiras-Vidal*  
> IEEE Transactions on Neural Networks, vol. 17, no. 6, pp. 1617 - 1622, June 2006.  
> [View Paper](https://ieeexplore.ieee.org/abstract/document/4012036)  

## Table of Contents
- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [File Descriptions](#file-descriptions)
- [License and Copyright](#license-and-copyright)

## Description
This project provides an implementation of Kernel ARMA models for nonlinear system identification using Support Vector Machines (SVMs). The code includes scripts and functions for building datasets, constructing kernel matrices, training kernel ARMA models, and computing the accuracy of predictions.

The implementation allows for various kernel methods including RBF kernels, multi-kernel combinations, and supports multiple approaches for training and testing kernel ARMA models.

## Installation
To use the Kernel ARMA scripts, follow these steps:

1. **Download or Clone the Repository:**
   ```bash
   git clone https://github.com/IPL-UV/karma.git
   cd karma
   ```
2. **Ensure you have MATLAB or GNU Octave installed.**

3. **Run the Demo:**
   Open MATLAB or Octave, navigate to the repository folder, and run the following command:
   ```matlab
   DemoKARMA
   ```

## Usage
1. **Data Preparation:** Use `BuildData.m` to create training and test datasets from the input signal.
2. **Kernel Construction:** Use `BuildKernels.m` to construct the necessary kernel matrices for the model.
3. **Training:** Use `TrainKernel.m` to train the SVM-ARMA model.
4. **Evaluation:** Use `ComputeResults.m` to compute performance metrics such as normalized mean squared error (nMSE) and model bias.

## File Descriptions

### **Main Scripts**
- **`DemoKARMA.m`**: Demonstrates the training of SVM-ARMA methods using a given set of input parameters. The demo shows how to initialize the problem, configure the model, and visualize the training results. It provides step-by-step guidance on how to replicate the results presented in the paper.  
  **Features of the Demo:**
  - **Problem Setup**: Selection of the method and loss function for training. Supported methods include `svr`, `2k`, `svr+2k`, `4k`, and `svr+4k`. Loss functions include L2 norm (`l2`), epsilon-insensitive loss (`eps`), and epsilon-Huber loss (`ehuber`).
  - **Data Handling**: Loads datasets, generates input-output pairs, and builds kernel matrices using `BuildData.m` and `BuildKernels.m`.
  - **Training**: Trains the model using `TrainKernel.m` with different loss functions, producing comparative results.
  - **Visualization**: Generates scatter plots and boxplots to visualize the prediction performance and residuals for each loss method.

### **Functions**
- **`BuildData.m`**: Prepares the training and testing datasets from a given signal using specified parameters such as order (P) and delay. The function splits the signal into input-output pairs for SVM training.
- **`BuildKernels.m`**: Builds the kernel matrices for training using various kernel methods. Supported methods include 'svr', '2k', '4k', 'svr+2k', and 'svr+4k'. The function constructs kernel representations for multiple input data sources.
- **`TrainKernel.m`**: Trains the kernel ARMA model using the specified kernel matrices. It outputs the predictions for the test data and provides key performance metrics, such as nMSE, model characteristics, and training error.
- **`ComputeResults.m`**: Computes performance metrics from the predicted and actual signals, including nMSE, model bias, and other accuracy measurements. The results are displayed for analysis and can be used to validate the model's effectiveness.
- **`kernelmatrix.m`**: Constructs a kernel matrix for a given method (currently, only RBF kernels are supported). This function is used in the `BuildKernels.m` script to compute the kernel representations required for training.

## License and Copyright
Copyright (c) 2006

Authors:
- Jordi Muñoz-Marí  
- Gustavo Camps-Valls  
- Manel Martínez-Ramón  
- José L. Rojo-Álvarez  

This code is made available for academic and research purposes. Please cite the corresponding paper if you use this code in your work. For licensing inquiries, please contact the authors directly.

