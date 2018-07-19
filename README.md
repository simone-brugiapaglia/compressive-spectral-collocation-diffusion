# compressive-spectral-collocation-diffusion
Code used to generate the figures of the article "A compressive spectral collocation method for the diffusion equation under the restricted isometry property" (https://arxiv.org/abs/1807.06606)

## Article's abstract

We propose a compressive spectral collocation method for the numerical approximation of Partial Differential Equations (PDEs). The approach is based on a spectral Sturm-Liouville approximation of the solution and on the collocation of the PDE in strong form at random points, by taking advantage of the compressive sensing principle. The proposed approach makes use of a number of collocation points substantially less than the number of basis functions when the solution to recover is sparse or compressible. Focusing on the case of the diffusion equation, we prove that, under suitable assumptions on the diffusion coefficient, the matrix associated with the compressive spectral collocation approach satisfies the restricted isometry property of compressive sensing with high probability. Moreover, we demonstrate the ability of the proposed method to reduce the computational cost associated with the corresponding full spectral collocation approach while preserving good accuracy through numerical illustrations.

## Requirements

The scripts are based on the following Matlab packages:

* OMP-Box (http://www.cs.technion.ac.il/~ronrubin/software.html)
* export_fig (http://www.mathworks.com/matlabcentral/fileexchange/23629-export_fig)

These packages should be added to the Matlab path before running the scripts.

## How to use this code

To generate Figure X (with X = 1,2,3,4), open the corresponding folder (callsed “Figure_X“) and run the script VIS_Figure_X.m This will generate the figure from previously computed data. In order to perform the corresponding numerical experiment from scratch, run the cript TEST_Figure_X.m. This will save a new data file that can be used to produce new figures (the new data file should be loaded in the script VIS_Figure_X.m). 


### Disclaimer 

Being the experiments random by nature, the results may change slighlty from those used in the paper when running the scripts.
