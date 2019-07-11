## Introduction

The Feature-Based Molecular Networking (FBMN) is a computational method that bridges popular mass spectrometry data processing tools for LC-MS/MS and molecular networking analysis on [GNPS](http://gnps.ucsd.edu). The tools supported are: MZmine2, OpenMS, MS-DIAL, MetaboScape, and XCMS.

The main documentation for Feature-Based Molecular Networking with XCMS [can be accessed here:](https://ccms-ucsd.github.io/GNPSDocumentation/featurebasedmolecularnetworking-with-xcms3/)

This repository contains example script in python and R showing how `xcms` version >= 3 (XCMS3) can used for the
FBMN workflow in GNPS using a subset of the American Gut Project.

### Installation of XCMS-GNPS workflow for FBMN

Install the latest version of XCMS3 (version >= 3.4) from Bioconductor in R
with:

```
install("BiocManager")
BiocManager::install("xcms")
```
See also [xcms Bioconductor package](https://www.bioconductor.org/packages/release/bioc/html/xcms.html).

See or clone the Github repository for utility functions specific to this workflow.
[https://github.com/jorainer/xcms-gnps-tools](https://github.com/jorainer/xcms-gnps-tools)

### Citations and development

This work builds on the efforts of our many colleagues, please cite their work:
[https://github.com/sneumann/xcms](https://github.com/sneumann/xcms)

Tautenhahn R, Boettcher C, Neumann S. [Highly sensitive feature detection for
high resolution LC/MS](https://doi.org/10.1186/1471-2105-9-504) BMC
Bioinformatics, 9:504 (2008).

Smith, C.A., Want, E.J., O'Maille, G., Abagyan,R., Siuzdak, G. [XCMS: Processing
mass spectrometry data for metabolite profiling using nonlinear peak alignment, matching and identification.](https://pubs.acs.org/doi/10.1021/ac051437y)
Analytical Chemistry, 78, 779–787 (2006).

### Running the Feature Based Molecular Networking on GNPS

The main documentation for Feature-Based Molecular Networking with GNPS [can be accessed here:](https://ccms-ucsd.github.io/GNPSDocumentation/featurebasedmolecularnetworking)

### Contributions

The XCMS-GNPS integration was developed by Johannes Rainer and Michael Witting, in coordination with Louis Felix Nothias and Daniel Petras.
This tutorials were prepared by Madeleine Ernst and Ricardo da Silva.
