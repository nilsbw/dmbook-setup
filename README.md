# Supplementary Material for "Data Management for Social Scientists" by Nils B. Weidmann

## Project file

The `dmbook-exercises.Rproj` file can be used as a project file for RStudio.

## Data 

This repository also contains the necessary data files for the code and exercises presented in the book. 

The data preparation is documented in `prepare-data.R`. The script downloads each external dataset to a subfolder under the `raw` directory, applies the necessary modifications and copies the final files to one of the data subdirectories (`ch04` etc). 

*For readers of this book, there is no need to run this file, since the required data files can be obtained directly from this repository.*

See the code in the data preparation script for the locations of the original files online, and the subfolders where they are stored locally.

Many datasets are modified to facilitate presentation in the book. Modifications include the dropping of variables or cases, the renaming of files, or changes in the file format. See the code in the data preparation script for the modifications applied to the data.
