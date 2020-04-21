#here is an example Rscript sy.r "./example/VPinfo.txt", this is a script written by shiyi apr212020.

VERSION <- '1.00'

get_script_path <- function(path=NULL) {
  if( is.null( path ) ){
    cmdArgs = commandArgs(trailingOnly = FALSE)
    needle = "--file="
    match = grep(needle, cmdArgs)
    if (length(match) > 0) {
      # Rscript
      return(normalizePath(sub(needle, "", cmdArgs[match])))
    } else {
      ls_vars = ls(sys.frames()[[1]])
      if ("fileName" %in% ls_vars) {
        # Source'd via RStudio
        return(normalizePath(sys.frames()[[1]]$fileName))
      } else {
        # Source'd via R console
        return(normalizePath(sys.frames()[[1]]$ofile))
      }
    }
  } else {
    return(path)
  }
}













#################################################################################################################
### PARSING THE INPUT ###########################################################################################
#################################################################################################################
if( !suppressMessages(require( "optparse", character.only = TRUE ) ) ) stop( "Package not found: optparse" )

option_list = list(
  make_option(c("-v", "--vpFile"), type="character", default=NULL, 
              help="path to viewpoint file [required]", metavar="/path/to/vp_file")
)

helptext<-"Values stored in the configuration file (conf.yml) are used by default."

opt_parser = OptionParser(option_list=option_list, description=helptext)
argsL <- parse_args(opt_parser)
#most important

if (is.null(argsL$vpFile)){
  print_help(opt_parser)
  stop("vpFile is required.\n", call.=FALSE)
}



#################################################################################################################
### Load packages ###############################################################################################
#################################################################################################################
message( '\n------ Loading functions and configuration file' )

if (!require('rentrez')) install.packages('rentrez'); library('rentrez')
if (!require('org.Hs.eg.db')) install.packages('org.Hs.eg.db'); library('org.Hs.eg.db')
if (!require('openxlsx')) install.packages('openxlsx'); library('openxlsx')
setwd("./")
Run.4Cpipeline <- function(filename){
  print("xxxx")
  a=read.csv(filename)
  a$id <- mapIds(org.Hs.eg.db, keys = as.vector(a[,1]), keytype ="SYMBOL", column="ENTREZID")
  a[is.na(a)] <- ""
  for (i in c(1:nrow(a))) {
    try(a$summary[i] <- entrez_summary(db="gene",id=a$id[i])$summary,silent = TRUE)
    print(i)
  }
  
  wb <- createWorkbook()
  
  
  addWorksheet(wb, "AFE high")
  # Write data frame to new worksheet
  writeData(wb, x = a,sheet ="AFE high" )
  
  
  saveWorkbook(wb, file = "helping_jk_apr212020.xlsx", overwrite = T)
}
  

#################################################################################################################
### PIPELINE ####################################################################################################
#################################################################################################################




Run.4Cpipeline( filename= argsL$vpFile )



#################################################################################################################
### END #########################################################################################################
#################################################################################################################
