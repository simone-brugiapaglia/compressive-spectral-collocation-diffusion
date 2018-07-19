# compressive-spectral-collocation-diffusion
Code used in the article "A compressive spectral collocation method for the diffusion equation under the restricted isometry property"

The scripts are based on the following Matlab packages:

* OMP-Box (http://www.cs.technion.ac.il/~ronrubin/software.html)
* export_fig (http://www.mathworks.com/matlabcentral/fileexchange/23629-export_fig)

These packages should be added to the Matlab path.

To generate a Figure, go to the corresponding folder and run the script VIS_Figure_X.m This will generate the figure from previously computed data. In order to perform the corresponding numerical experiment from scratch, run the cript TEST_Figure_X.m. This will save a new data file. Being the experiments random, the results may change slighlty from those used in the paper.
