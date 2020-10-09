*------------------Header---------------------
* Analyze the data extracted from the NSF's Survey of Earned Doctorates
* Hopefully make some pretty graphs
* 03a.analyze_seds_data.do 
* Last edited date: 2020-10-09
* Last edited by: Joseph Levine
* Goal:  Import the data I cleaned in (02a.SEDs_profile_clean_merge.ipynb) ///
*        and begin analysis
* Notes: TO ANYONE CURIOUS ABOUT THIS PROJECT, THE ABOVE CLEANING FILE WILL ///
*		 BE MUCH MORE USEFUL THAN THIS ONE
*---------------------------------------------






*-------------------Program set-up-------------------------------

version 15		  // Set version number for backward compatibility
set more off      // Disable partitioned output 
pause on		  // Enables pause, to assist with debugging	
clear all  		  // Start with a clean slate
set linesize 100  // Line size limit to make output/logs more readable
set mem 15m		  // Sets usable memory in the evironment /*\ MUST CHECK FILE SIZE \*/
macro drop _all   // Clear all macros
cap log close     // Close any open log files

/*\ ATTENTION \*/

global datapath1		 "~/Dropbox/Research/Visas/Data"
global temppath 		 "~/Dropbox/Research/Visas/Analysis"
global temppath1   		 "C:/Users/240-370-8956/Desktop/temp"
global resultspath1 	 "~/Dropbox/Research/Visas/Analysis"

log using "$temppath/1_analyze_seds_$S_DATE.txt", replace text   // Open log file

*----------------------------------------------------------------


clear




********
* start with importing the cleaned data
********

import delimited "$temppath/seds_09_17.csv"

*set order of variables to something relevant

replace field = strltrim(field)
replace field = strrtrim(field)

sort field

*OK this is real ugly, but it has to be done:
replace field = "Aerospace, aeronautical, and astronautical engineering" in 7
replace field = "Aerospace, aeronautical, and astronautical engineering" in 8
replace field = "Aerospace, aeronautical, and astronautical engineering" in 9
replace field = "Agricultural sciences and natural resources" in 12
replace field = "Agricultural sciences and natural resources" in 11
replace field = "Agricultural sciences and natural resources" in 10
replace field = "All humanities fields" in 39
replace field = "All humanities fields" in 38
replace field = "All humanities fields" in 37
replace field = "All other fieldsa" in 63
replace field = "All physical sciences fields" in 65
replace field = "All physical sciences fields" in 66
replace field = "All physical sciences fields" in 64
replace field = "All social sciences fields" in 75
replace field = "All social sciences fields" in 74
replace field = "All social sciences fields" in 73
replace field = "Biological and biomedical sciences" in 97
replace field = "Biological and biomedical sciences" in 98
replace field = "Biological and biomedical sciences" in 99
replace field = "Biological and biomedical sciences" in 100
replace field = "Biological and biomedical sciences" in 101
replace field = "Biological and biomedical sciences" in 102
replace field = "Business management and administration" in 103
replace field = "Business management and administration" in 104
replace field = "Business management and administration" in 105
replace field = "Earth, atmospheric, and ocean sciences" in 151
replace field = "Electrical, electronics, and communications engineering" in 181
replace field = "Electrical, electronics, and communications engineering" in 182
replace field = "Electrical, electronics, and communications engineering" in 183
replace field = "Electrical, electronics, and communications engineering" in 184
replace field = "Electrical, electronics, and communications engineering" in 185
replace field = "Electrical, electronics, and communications engineering" in 189
replace field = "Foreign languages and literature" in 193
replace field = "Foreign languages and literature" in 194
replace field = "Foreign languages and literature" in 195
replace field = "Foreign languages and literature" in 201
replace field = "Earth, atmospheric, and ocean sciences" in 202
replace field = "Earth, atmospheric, and ocean sciences" in 203
replace field = "Earth, atmospheric, and ocean sciences" in 204
replace field = "Earth, atmospheric, and ocean sciences" in 205
replace field = "Earth, atmospheric, and ocean sciences" in 206
replace field = "Earth, atmospheric, and ocean sciences" in 207
replace field = "Industrial and manufacturing engineering" in 232
replace field = "Industrial and manufacturing engineering" in 233
replace field = "Industrial and manufacturing engineering" in 234
replace field = "Mathematics and statistics" in 258
replace field = "Mathematics and statistics" in 253
replace field = "Mathematics and statistics" in 254
replace field = "Mathematics and statistics" in 255
replace field = "Mathematics and statistics" in 256
replace field = "Mathematics and statistics" in 257
replace field = "Other humanities" in 298
replace field = "Other humanities" in 299
replace field = "Other humanities" in 300
replace field = "Political science" in 325
replace field = "Political science" in 326
replace field = "Political science" in 327





*egen fieldnum = group(field)
encode field, gen(fld)


order field fld year alldoctoraterecipientsnumbera_al

xtset fld year

save "$temppath/cleaned_working_seds.dta", replace


*xtline temporaryvisaholder_all if substr(field,1,3) == "All", overlay 

*xtline temporaryvisaholder_all if substr(field,1,3) == "All" | field == "Economics", overlay 


*These are kind of the best for illustrating my visa point
*xtline temporaryvisaholder_all if field == "All social sciences fields" | ///
*field == "Economics" | field == "All humanities fields" | ///
*field == "All engineering fields" | field == "All life sciences fields", overlay


*xtline uscitizenorpermanentresident_all if field == "All social sciences fields"///
* | field == "Economics" | field == "All humanities fields"  | ///
*field == "All life sciences fields", overlay


/*
#delimit
xtline frombachelors_all if field == "All social sciences fields" | field == "Economics" |
 field == "All humanities fields"  | field == "All life sciences fields", overlay
 scheme(s1color);
#delimit cr

*/









clear all
log close

exit
