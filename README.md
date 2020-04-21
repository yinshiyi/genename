# genename

This is a R script to annoate a gene ID list, aka find the full description of each gene ID.
eg. TP53 in the input file will be assigned with "The TP53 gene provides instructions for making a protein called tumor protein p53 (or p53). This protein acts as a tumor suppressor, which means that it regulates cell division by keeping cells from growing and dividing (proliferating) too fast or in an uncontrolled way."

In order to run this script:
1. R 3.5 is required and R needs to be in path 
2. mainscript is needed.

To get the script
1. go to https://github.com/yinshiyi/genename/blob/master/genename.R and download the main script
2. use github clone or pull
3. download the zip folder then unzip

To get R installed and properly configured.

For Windows users, 
https://www.r-project.org/ to download and install R
http://yizhexu.com/2017/02/r-path/ to put R into path

Then in CMD use cd to direct yourself to the working folder with genelist of interest then run 
$Rscript genename.R

For Linux/MAC users,
https://www.r-project.org/ to download and install R
Google how to put R into path

Then in command prompt use cd to direct yourself to the working folder with genelist of interest then run 
$Rscript genename.R

$Rscript genename.R 
or 
$Rscript genename.R-h 
will bring the help page

