# Supplementary Material for "Data Management for Social Scientists" by Nils B. Weidmann

## Project file

The `dmbook-exercises.Rproj` file can be used as a project file for RStudio.

## Data 

This repository also contains the necessary data files for the code and exercises presented in the book. Data files are organized by chapter (`ch04` etc). For each chapter, the references to the datasets are provided in the `REFERENCES.md` file.

The data preparation is documented in `prepare-data.R`. The script downloads each external dataset to a subfolder under the `raw` directory, applies the necessary modifications and copies the final files to one of the data subdirectories (`ch04` etc). 

*For readers of this book, there is no need to run this file, since the required data files can be obtained directly from this repository.*

See the code in the data preparation script for the locations of the original files online, and the subfolders where they are stored locally.

Many datasets are modified to facilitate presentation in the book. Modifications include the dropping of variables or cases, the renaming of files, or changes in the file format. See the code in the data preparation script for the modifications applied to the data.

## Installation Instructions

The book relies on several software tools: The R statistical toolkit, the RStudio development environment for R, as well as the PostgreSQL relational database system. Please refer to the following documents for detailed instructions on how to install these tools on your system. 

* [Instructions for Windows users](install/installation-windows.md)

* [Instructions for MacOS users](install/installation-mac.md)

* [Instructions for Linux users](install/installation-linux.md)