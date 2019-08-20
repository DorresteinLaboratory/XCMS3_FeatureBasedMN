## Introduction

The Feature-Based Molecular Networking (FBMN) workflow is a computational method that bridges popular mass spectrometry data processing tools for LC-MS/MS and molecular networking analysis on [GNPS](http://gnps.ucsd.edu). The tools supported are: MZmine2, OpenMS, MS-DIAL, MetaboScape, and XCMS.

The main documentation for Feature-Based Molecular Networking with XCMS can be accessed [here](https://ccms-ucsd.github.io/GNPSDocumentation/featurebasedmolecularnetworking-with-xcms3/).

This repository contains example scripts in Python and R showing how `XCMS` version >= 3 (XCMS3) can be used for the
FBMN workflow in GNPS using a subset of samples of the American Gut Project ([MSV000082678](https://massive.ucsd.edu/ProteoSAFe/dataset.jsp?task=de2d18fd91804785bce8c225cc94a444)) and soil bacteria ([MSV000079204](https://massive.ucsd.edu/ProteoSAFe/dataset.jsp?task=d74ca92d9dec4e2883f28506c670e3ca)).

### Installation of the XCMS-GNPS workflow for FBMN

Install the latest version of XCMS3 (version >= 3.4) from Bioconductor in R
with:

```
install("BiocManager")
BiocManager::install("xcms")
```
For more information, also refer to the [xcms Bioconductor package](https://www.bioconductor.org/packages/release/bioc/html/xcms.html).

For utility functions specific to this workflow refer to the Github repository:
[https://github.com/jorainer/xcms-gnps-tools](https://github.com/jorainer/xcms-gnps-tools)

### Citations and development

This work builds on the efforts of our many colleagues, please cite their work:
[https://github.com/sneumann/xcms](https://github.com/sneumann/xcms)

Tautenhahn R, Boettcher C, Neumann S. [Highly sensitive feature detection for
high resolution LC/MS](https://doi.org/10.1186/1471-2105-9-504). BMC
Bioinformatics, 9:504 (2008).

Smith, C.A., Want, E.J., O'Maille, G., Abagyan,R., Siuzdak, G. [XCMS: Processing
mass spectrometry data for metabolite profiling using nonlinear peak alignment, matching and identification.](https://pubs.acs.org/doi/10.1021/ac051437y). Analytical Chemistry, 78, 779–787 (2006).

### Running the Feature Based Molecular Networking on GNPS

The main documentation for Feature-Based Molecular Networking with GNPS can be accessed[here](https://ccms-ucsd.github.io/GNPSDocumentation/featurebasedmolecularnetworking/).

### Contributions

The XCMS-GNPS integration was developed by Johannes Rainer and Michael Witting, in coordination with Louis-Félix Nothias and Daniel Petras.
This tutorial was prepared by Madeleine Ernst and Ricardo da Silva.
