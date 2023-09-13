# Project Configuration and Data for "Data Management for Social Scientists" by Nils B. Weidmann

## Installation Instructions

Please refer to the main website for the book at [https://dmbook.org](https://dmbook.org).

## Project Configuration

The `dmbook.Rproj` file should be used as a project file for RStudio. The `renv` lock file specifies the used packages for the book, it is applied automatically when the project is first opened. 

## Data 

This repository also contains the necessary data files for the code and exercises presented in the book. Data files are organized by chapter (`ch04` etc). For each chapter, the references to the datasets are provided in the `REFERENCES.md` file.

The data preparation is documented in `prepare-data.R`. The script downloads each external dataset to a subfolder under the `raw` directory, applies the necessary modifications and copies the final files to one of the data subdirectories (`ch04` etc). 

*For readers of this book, there is no need to run this file, since the required data files can be obtained directly from this repository.*

Many datasets are modified to facilitate presentation in the book. Modifications include the dropping of variables or cases, the renaming of files, or changes in the file format. See the code in the data preparation script for the modifications applied to the data.

## Issues

If you encounter an error in the data and configuration provided here, please file an issue at [https://github.com/nilsbw/dmbook-setup/issues](https://github.com/nilsbw/dmbook-setup/issues). 

## Errata

A list of errors identified after publication can be found [here](https://github.com/nilsbw/dmbook-setup/blob/main/ERRORS.md). 
