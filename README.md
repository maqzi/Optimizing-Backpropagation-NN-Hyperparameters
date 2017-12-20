# Optimizing Hyperparameters for a XOR NN
A Back Propagation Neural Network was set up for the XOR problem. Its results and analysis are mentioned in this paper. The primary goal of this study was to analyze how the NN performed with respect to the change in various hyperparameters. The hyperparameters tuned include N_1 - the number of neurons in the hidden layer, alpha - the learning rate, zeta - the range of random values for initialization of weights and biases and X_0 - the denominator of the bipolar hyperbolic tangent function. The process was repeated for two different cost functions: Quadratic and Cross Entropy. Tuning these 4 variables for the different cost functions, I was able to get various interesting insights about the use of neural networks in this specific problem. During the course of the problem, I was also met with a number of challenges, topping the list though, was setting a maximum number of iterations (in case, the NN didn't converge). The range of all the configuration variables are mentioned in the list below.

* Cost Functions : Quadratic and Cost-Entropy
* Neurons in Input Layer* : 2 
* Neurons in Hidden Layer* (N_1) : 2, 4, 6, 8, 10 
* Neurons in Output Layer : 1 
* Learning Rate (alpha) : 0.1, 0.2, 0.3 
* Initial weights & biases range (zeta) : +/-0.5, +/-1, +/-1.5 
* Transfer function denominator (X_0) : 0.5, 1, 1.5
* Maximum Error allowed : 0.05 (Sum Squared Error)

\* excluding bias neurons

For each of the different weights and biases, I measured how long the program took (number of epochs) to converge. Because the weights and biases were initialized with a Gaussian Distributed random function in Matlab, each neural network was run 100 times to get as close to the actual number of epochs as possible. Each different run of the NN continued till the error was less than the threshold mentioned in the table which was the Sum Squared Error for both cost functions.

Contact me for the complete report!
