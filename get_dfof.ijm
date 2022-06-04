/* 
This macro for imageJ is a simple macro to output deltaF and deltaF/F images from calcium imaging data (e.g. stacked tiff files).
deltaF = (Ft - F0) 
deltaF/F = deltaF / F0
Ft is the image data at time t, and
F0 is the average image of all image data in the time direction.
To run: 
Prepare a single-channel color data stack (XYT stack).
In the imageJ menu bar, select 'Plugins -> Macros -> Install....' and load the file "get_dfof.ijm".
Then select 'Plugins -> Macros -> "get_dfof"'.

2022/06/04
Satoshi Manita, University of Yamanashi
*/

windowList = getList("image.titles");
title = "Calculate DF/F";
Dialog.create("Calculate DF/F");
Dialog.addChoice("Window:", windowList);
Dialog.show();
winName = Dialog.getChoice();
print(winName);
selectWindow(winName);
winName = split(winName, ".");
rename("F_"+winName[0]);
run("Z Project...", "projection=[Average Intensity]");
rename("d0_"+winName[0]);
imageCalculator("Subtract create 32-bit stack", "F_"+winName[0],"d0_"+winName[0]);
rename("dF_"+winName[0]);
run("mpl-viridis");
run("Brightness/Contrast...");
imageCalculator("Divide create 32-bit stack", "dF_"+winName[0],"d0_"+winName[0]);
rename("dFoF_"+winName[0]);