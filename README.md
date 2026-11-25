<h1 align="center">Align MP2RAGE volumes to T1 using FSL FLIRT</h1>

<p align="center">
  MP2RAGE volumes (UNI, inversion magnitudes and phases) resampled into the space of an ACPC-aligned T1-weighted image.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.509"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.509-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

> 📍 **This branch, `uni-included-v1.0`, is the brainlife.io App Align mp2rage volumes to T1 using FSL Flirt** ([doi:10.25663/brainlife.app.509](https://doi.org/10.25663/brainlife.app.509)).

## 🧠 At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Aligns MP2RAGE volumes (UNI, inversion magnitudes and phases) to a T1-weighted image with FSL FLIRT, using a transform estimated from the UNI image, and outputs the aligned MP2RAGE.**

Optionally crops the MP2RAGE volumes with robustfov (field of view from UNI), skull-strips the reference T1 with bet, estimates a FLIRT transform from the UNI image to the T1 brain, and applies it to every other MP2RAGE volume. Use it to bring MP2RAGE data into the same space as an ACPC-aligned T1w for further analysis. Needs MP2RAGE data that includes the UNI image and an ACPC-aligned T1w of the same subject.

| | |
|---|---|
| 📥 **Inputs** | `neuro/anat/t1w` · `neuro/anat/mp2rage` |
| 📤 **Outputs** | `neuro/anat/mp2rage` |
| 🐳 **Container** | `brainlife/fsl:5.0.11` |
| ⚙️ **Resources** | 1 CPUs · 12 GB memory · 0.75 h walltime |
| 🔗 **Run it** | [doi.org/10.25663/brainlife.app.509](https://doi.org/10.25663/brainlife.app.509) |

#### 📥 Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `t1` | `neuro/anat/t1w` (acpc_aligned) | yes | reference t1 to align mp2rage data to |
| `mp2rage` | `neuro/anat/mp2rage` | yes | mp2rage data to align |

#### 📤 Outputs

| Output | Datatype | Description |
|---|---|---|
| `output` | `neuro/anat/mp2rage` | MP2RAGE volumes resampled into the reference T1 space. |

<details>
<summary><b>⚙️ Parameters</b> (1)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `crop` | boolean | `true` | If true, will crop using fsl robustfov. if false, will not. default == true |

</details>

<!-- brainlife-app:end -->

## 🚀 Running the App

The App crops the MP2RAGE volumes with `robustfov` (optional, field of view taken from the UNI image), skull-strips the reference T1 with `bet`, estimates a FLIRT transform from the UNI image to the T1 brain, and applies that transform to every other MP2RAGE volume. This brings MP2RAGE data into the same space as the anatomical T1w used for most analyses.

### ☁️ On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.509](https://doi.org/10.25663/brainlife.app.509), choose an ACPC-aligned T1-weighted dataset and an MP2RAGE dataset of the same subject (it must include the UNI image), and press **Execute**. The aligned MP2RAGE is archived to your project as a `neuro/anat/mp2rage` dataset tagged `acpc_aligned`.

### 💻 Locally

You need [Singularity/Apptainer](https://apptainer.org/) and [`jq`](https://jqlang.github.io/jq/). The App runs FSL 5.0.11 from the `brainlife/fsl:5.0.11` container; without Singularity you need a local [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki) installation.

1. Clone this repository and check out the registered version: `git checkout uni-included-v1.0`.
2. Create `config.json` with the paths to your inputs:

   ```json
   {
       "t1": "/input/t1/t1.nii.gz",
       "mag_inv1": "/input/mp2rage/mag.inv1.nii.gz",
       "phase_inv1": "/input/mp2rage/phase.inv1.nii.gz",
       "mag_inv2": "/input/mp2rage/mag.inv2.nii.gz",
       "phase_inv2": "/input/mp2rage/phase.inv2.nii.gz",
       "unit1": "/input/mp2rage/unit1.nii.gz",
       "crop": true
   }
   ```

   Volumes that are missing are skipped; only `unit1` (the UNI image) and `t1` are required.

3. Run the App:

   ```bash
   ./main
   ```

### 🧪 Sample data

Download sample datasets from brainlife.io with the [brainlife CLI](https://github.com/brainlife/cli):

```bash
npm install -g brainlife
bl login
mkdir input
bl dataset download <dataset id>
```

## 📦 Outputs

```text
output/
├── unit1.nii.gz        UNI image registered to the T1 brain
├── mag.inv1.nii.gz     first inversion, magnitude
├── mag.inv2.nii.gz     second inversion, magnitude
├── phase.inv1.nii.gz   first inversion, phase
└── phase.inv2.nii.gz   second inversion, phase
```

The FLIRT matrix (`mp2rage2t1.mat`) and the skull-stripped T1 (`t1_brain.nii.gz`) are left in the working directory.

## 🩺 Troubleshooting

- **Run fails with `crop` set to `false`**: on the `uni-included-v1.0` branch the uncropped copies are written as `*.cropoped.nii.gz` (a typo), so FLIRT cannot find `unit1.cropped.nii.gz`. Keep `crop` set to `true` (the default). The `master` branch fixes this.
- **Poor alignment**: the transform is estimated from the UNI image only and applied to every other volume; check that the MP2RAGE dataset includes the UNI image and that the T1 is ACPC-aligned.

## 📚 Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Woolrich MW, Jbabdi S, Patenaude B, Chappell M, Makni S, Behrens T, Beckmann C, Jenkinson M, Smith SM. Bayesian analysis of neuroimaging data in FSL. *NeuroImage* 45:S173–186 (2009).
- Smith SM, Jenkinson M, Woolrich MW, Beckmann CF, Behrens TEJ, Johansen-Berg H, Bannister PR, De Luca M, Drobnjak I, Flitney DE, Niazy R, Saunders J, Vickers J, Zhang Y, De Stefano N, Brady JM, Matthews PM. Advances in functional and structural MR image analysis and implementation as FSL. *NeuroImage* 23(S1):208–219 (2004).
- Jenkinson M, Beckmann CF, Behrens TE, Woolrich MW, Smith SM. FSL. *NeuroImage* 62:782–790 (2012).
- Align mp2rage volumes to T1 using FSL Flirt. brainlife.io App. [doi:10.25663/brainlife.app.509](https://doi.org/10.25663/brainlife.app.509)
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## 👥 Authors

- Brad Caron

**Contributors:** Sophia Vinci-Booher, Soichi Hayashi

## 💰 Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## ⚖️ License

[MIT](LICENSE). FSL itself is distributed under its own [license](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Licence).
