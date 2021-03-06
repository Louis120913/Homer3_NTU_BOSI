# Homer3
Homer3 is a MATLAB application used for analyzing fNIRS data to obtain estimates and maps of brain activation. It is a continuation of the work on the well-established HOMER2 software which itself evolved since the early 1990s, first as the Photon Migration Imaging Toolbox, then HOMER and HOMER2.

Homer3 is developed and maintained by the [Boston University Neurophotonics Center](http://www.bu.edu/neurophotonics/).

# Quick links
* [Downloading Homer3](https://github.com/BUNPC/Homer3/wiki/Download-and-Installation)
* [Homer3 Community & Support Forum](https://openfnirs.org/community/homer3-forum/)

===========================================================================
# Notes by Louis Chang (2021/12/15 updated)
This is rewritten from Homer3_development branch (v1.32.4), modified by Louis Tai-Jai Chang (張太睿) and used for broadband functional near-infrared spectroscopy analysis in my master thesis: "Evaluation and Comparison of the Hemodynamic Response Function of the Prefrontal Cortex by Broadband Functional Near-Infrared Spectroscopy and Functional Magnetic Resonance Imaging." (Biomedical Optical Spectroscopy and Imaging Lab, Graduate Institute of Biomedical Electronics and Bioinformatics, NTU)

Our lab (BOSI Lab, http://homepage.ntu.edu.tw/~kbsung/) has made our own CW-fNIRS system, and actually, we can measure and analyze over 5 different wavelengths at the same time.
And with the Monte Carlo method which was developed by our lab team, we can get optical parameters for different subjects (mainly for mean pathlengths).
You can also place your own probe design on the real brain model of subjects by using AltasViewer/Freesurfer/SPM12 in your experiments.

If you have any questions about using this version of Homer3, please contact me via: louis120913@gmail.com

# Recommandanded Analysis Steps from my Thesis

![image](https://user-images.githubusercontent.com/27907938/146170220-cf13a79b-7313-4ea3-8b99-0bb43fed1f89.png)
