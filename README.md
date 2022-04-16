[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-brainlife.app.509-blue.svg)](https://doi.org/https://doi.org/10.25663/brainlife.app.509)

# Align mp2rage volumes to T1 using FSL Flirt

This app will This app will align mp2rage data to an anatomical t1w image using FSL's flirt command. This is done to ensure that mp2rage data is in same space as anatomical t1w image, which is used for most analyses.

### Authors

- Brad Caron (bacaron@utexas.edu)

### Contributors

- Sophia Vinci-Booher (svinci@iu.edu)
- Soichi Hayashi (shayashi@iu.edu)

### Funding Acknowledgement

brainlife.io is publicly funded and for the sustainability of the project it is helpful to Acknowledge the use of the platform. We kindly ask that you acknowledge the funding below in your publications and code reusing this code.

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations

We kindly ask that you cite the following articles when publishing papers and code using this code.

1. M.W. Woolrich, S. Jbabdi, B. Patenaude, M. Chappell, S. Makni, T. Behrens, C. Beckmann, M. Jenkinson, S.M. Smith. Bayesian analysis of neuroimaging data in FSL. NeuroImage, 45:S173-86, 2009

2. S.M. Smith, M. Jenkinson, M.W. Woolrich, C.F. Beckmann, T.E.J. Behrens, H. Johansen-Berg, P.R. Bannister, M. De Luca, I. Drobnjak, D.E. Flitney, R. Niazy, J. Saunders, J. Vickers, Y. Zhang, N. De Stefano, J.M. Brady, and P.M. Matthews. Advances in functional and structural MR image analysis and implementation as FSL. NeuroImage, 23(S1):208-19, 2004

3. M. Jenkinson, C.F. Beckmann, T.E. Behrens, M.W. Woolrich, S.M. Smith. FSL. NeuroImage, 62:782-90, 2012

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University

## Running the App

### On Brainlife.io

You can submit this App online at [https://doi.org/https://doi.org/10.25663/brainlife.app.509](https://doi.org/https://doi.org/10.25663/brainlife.app.509) via the 'Execute' tab.

### Running Locally (on your machine)

1. git clone this repo

2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
	"t1": "/input/t1/t1.nii.gz",
	"mag_inv1": "/input/mp2rage/mag.inv1.nii.gz",
	"phase_inv1": "/input/mp2rage/phase.inv1.nii.gz",
	"mag_inv2": "/input/mp2rage/mag.inv2.nii.gz",
	"phase_inv2": "/input/mp2rage/phase.inv2.nii.gz"
	"unit1": "/input/mp2rage/uni1.nii.gz",
	"mag_inv1_json": "/input/mp2rage/mag.inv1.json",
	"phase_inv1_json": "/input/mp2rage/phase.inv1.json",
	"mag_inv2_json": "/input/mp2rage/mag.inv2.json",
	"unit1_json": "/input/mp2rage/unit1.json",
	"crop": true
}
```

### Sample Datasets

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download
```

3. Launch the App by executing 'main'

```bash
./main
```

## Output

The main output of this App is an anat/mp2rage datatype.

#### Product.json

The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing.

### Dependencies

This App only requires [singularity](https://www.sylabs.io/singularity/) to run. If you don't have singularity, you will need to install following dependencies.   

- FSL: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University
