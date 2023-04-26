print("\\Clear");

print("Choose input directory");
dir1 = getDirectory("Choose input directory ");
print("Choose output directory");
dir2 = getDirectory("Choose output directory ");
list = getFileList(dir1);

// create scale input dialog box
Dialog.create("Set Scale");
	Dialog.addMessage("Enter scale settings here");
	Dialog.addNumber("Distance in pixels:", 0);
	Dialog.addNumber("Known distance:", 1.00);
	Dialog.addString("Unit of length:", "");
Dialog.show();

// assign results of dialog box to variables
distance_in_pixels = Dialog.getNumber();
known_distance = Dialog.getNumber();;
unit_of_length = Dialog.getString();
scale = distance_in_pixels/known_distance

// print scale and files run
print("\nScale: " + scale + " pixels/ " + unit_of_length + " ");
print("\nFiles run:");

setBatchMode(true);
// LOOP to process the list of files
for (i=0; i<list.length; i++) { // start at the first index position, continue until i reaches list length-1 (as 0 indexed), increase i by 1
		showProgress(i+1, list.length); // show progress for image 1 to end of list, i+1 accounts for 0 indexing
		open(dir1+list[i]); // add file name (at index position i) to the folder path 
		
		// file name
		print(list[i]);
		
		// set scale
		run("Set Scale...", "distance=" + distance_in_pixels + " known=1 pixel=1 unit=" + unit_of_length + "");
		
		// add scale bar
		run("Scale Bar...", "width=50 height=25 thickness=4 font=25 color=White background=None location=[Lower Right] horizontal bold overlay");
		saveAs("PNG", dir2+list[i]);
		
		// close all open windows
		run("Close All");
}
setBatchMode(false);

print("\nFinished")


selectWindow("Log");
saveAs("Text", dir2+"Log.txt")