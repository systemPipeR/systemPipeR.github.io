---
title: "About Project"
linkTitle: "Project"
type: docs
description: >
weight: 2
exclude_search: true
---

## Overview

<img src="systemPipe_logo.png" width="20%" alt="Right Aligned" align="right" style="display: block; margin: auto;" />

The systemPipe project provides a suite of R/Bioconductor packages for designing, building and running end-to-end analysis workflows on local machines and HPC systems, while generating at the same time publication quality analysis reports.

This site serves mainly as a landing page providing a high-level overview of each package and links to the corresponding pages on Bioconductor. Detailed usage instructions are provided in the vignetted of each package on Bioconductor. 

### Core Packages

  * __systemPipeR: Workflow Management System (WMS)__ <br/>
[_systemPipeR_](https://bioconductor.org/packages/release/bioc/html/systemPipeR.html) is the core workflow management package, enabling users to define, organize, and run workflows that combine R functions with external command-line software([H Backman and Girke 2016](https://link.springer.com/article/10.1186/s12859-016-1241-0)). A scientific reporting system is integral part of the package.

  * __systemPipeRdata: Workflow Templates__ <br/>
[_systemPipeRdata_](https://www.bioconductor.org/packages/release/data/experiment/html/systemPipeRdata.html) offers a set of pre-configured workflow templates and associated resources that simplify the setup of common analysis pipelines.

  * __systemPipeShiny: Visualization Toolbox__ <br/>
[_systemPipeShiny_](https://bioconductor.org/packages/release/bioc/html/systemPipeShiny.html) provides a Shiny-based graphical interface for executing selected workflows and accessing a collection of interactive visualizations.


## Workflow 

### Templates

The [_systemPipeRdata_](https://www.bioconductor.org/packages/release/data/experiment/html/systemPipeRdata.html) package provides preconfigured workflow templates that are compatible with the systemPipeR WMS. These templates include the necessary CWL parameter files for running a chosen workflow. Many of the templates come equipped with sample data. This setup serves several purposes: it simplifies the learning curve for using systemPipeR, allows for easy workflow testing, and provides a starting point for developing new workflows. 


### Contributions

For contributing workflows, we recommend the following fork and pull request approach.

1. Create a "Template" Repository: Within your organization, create a public repository that serves as a template or a starting point for submissions. It should contain contribution guidelines (CONTRIBUTING.md), a code of conduct, license information, and potentially a project structure.
2. Community Forks the Repository: Users interested in submitting a project will fork this "Template" repository to their personal GitHub account. This creates their own copy where they can work independently.
3. User Development: The user develops their project within their personal fork.
4. User Opens a Pull Request: When the user is ready to submit their project, they open a pull request from their personal repository back to the main "Template" repository in your organization. This pull request serves as the formal submission and review mechanism.
5. Review Process: Organization members review the pull request, provide feedback, request changes, and ensure the submission meets community standards.
6. Integration into the Organization:
   + If the goal is to integrate their code into the template project, you merge the pull request. 
   + If the goal is for their entire repository to become a standalone repository within your organization, you would accept the submission via the pull request review process, and then work with the user offline to have them transfer ownership of their repository to the organization.
