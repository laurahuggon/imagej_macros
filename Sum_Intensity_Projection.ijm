print("\\Clear");

print("Choose input directory");
dir1 = getDirectory("Choose input directory ");
print("Choose output directory");
dir2 = getDirectory("Choose output directory ");
list = getFileList(dir1);

// print files run
print("\nFiles run:");

setBatchMode(true);
// LOOP to process the list of files
for (i=0; i<list.length; i++) { // start at the first index position, continue until i reaches list length-1 (as 0 indexed), increase i by 1
		showProgress(i+1, list.length); // show progress for image 1 to end of list, i+1 accounts for 0 indexing
		open(dir1+list[i]); // add file name (at index position i) to the folder path 
		
		// file name
		print(list[i]);
		
		// max intensity projection
		run("Z Project...", "projection=[Sum Slices]");
		saveAs("Tiff", dir2+"SUM_"+list[i]);
		
		// close all open windows
		run("Close All");
}
setBatchMode(false);

print("\nFinished")

selectWindow("Log");
saveAs("Text", dir2+"Log.txt")
