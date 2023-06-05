print("\\Clear");

print("Choose input directory");
dir1 = getDirectory("Choose input directory ");
print("Choose output directory");
dir2 = getDirectory("Choose output directory ");
list = getFileList(dir1);

setBatchMode(true);
// LOOP to process the list of files
for (i=0; i<list.length; i++) { // start at the first index position, continue until i reaches list length-1 (as 0 indexed), increase i by 1
		showProgress(i+1, list.length); // show progress for image 1 to end of list, i+1 accounts for 0 indexing
		open(dir1+list[i]); // add file name (at index position i) to the folder path 
		
		// image pre-processing
		run("Make Substack...", "channels=2-3 slices=7-14");
		print("\nMake substack with channels 2-3 and slices 7-14");
		run("Subtract Background...", "rolling=10 stack");
		print("Subtract background using a rolling ball with radius of 10 pixels");
		
		// comdet
		run("Detect Particles", "calculate max=5 plot rois=Ovals add=Nothing summary=Append ch1i ch1l ch1a=3 ch1s=100 ch2i ch2l ch2a=3 ch2s=50");
		
		selectWindow("Results");
		saveAs("Text", dir2+"Results_" + list[i] + " .txt");
		
		// close all open windows
		run("Close All");
}
setBatchMode(false);

print("\nFinished")

selectWindow("Log");
saveAs("Text", dir2+"Log.txt");

selectWindow("Summary");
saveAs("Text", dir2+"Summary.txt")