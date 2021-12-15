# Homer3
Homer3 is a MATLAB application used for analyzing fNIRS data to obtain estimates and maps of brain activation. It is a continuation of the work on the well-established HOMER2 software which itself evolved since the early 1990s, first as the Photon Migration Imaging Toolbox, then HOMER and HOMER2.

Homer3 is developed and maintained by the [Boston University Neurophotonics Center](http://www.bu.edu/neurophotonics/).

# Quick links
* [Downloading Homer3](https://github.com/BUNPC/Homer3/wiki/Download-and-Installation)
* [Homer3 Community & Support Forum](https://openfnirs.org/community/homer3-forum/)

=======================================================================================
This is rewritten from Homer3 development branch (v1.31.2).
	A. 製作.nirs 格式檔案
	1. 根據欲分析的波長，清理出raw intensitty <=波長校正線性公式：Y = 3.5126 X+532.49 (X=pixel; Y=校正波長)
	2. 扣掉background (可最後於GLM扣除? 但多層模型一定要先) 
  =>  由於dark current 和baseline並沒有差很多，代表光路確實有完全避光，因此可以將baseline 以及background當作一樣的，而不需要另外扣除。(強度大約在1300-1800之間)
	3. 提取Result的採樣頻率 (t) 等差數列 <= 需要確定穩定度，可能也要公式/另外每道題目開始的時間都是第一個採樣點

	B. 訊號篩選
	1. 選擇性: CV >5%剔除
	2. Motion Detection <= auto?
	3. Motion Artifact Removal by channels  <= how to do? 
	4. Intensity =>OD

	C. Filter
	1. Wavelet or Spline correction   (For Motion)
	2. Band-pass filter (HPF & LPF)  (Physiology Signal)
	3. OD => Conc. <= wavelength restriction?

 D.  Model & Analysis
	1. Block design (Block Avg.)
	2. GLM: Short channel separation
	3. tCCA: with GLM?
![image](https://user-images.githubusercontent.com/27907938/146158609-f67df2d1-1bcc-403b-a894-849f3ff12393.png)


