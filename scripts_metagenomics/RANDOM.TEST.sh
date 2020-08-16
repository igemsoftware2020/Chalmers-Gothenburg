# RANDOM TEST CRAP

#merge humann2 files into one table/matrix
#input directory
input_humann="/cephyr/NOBACKUP/groups/snic2020-8-84/temp_results/temp_pathabundance"
TABLE="matrix_pathabundance.tsv"

# humann2_join_tables --input $INPUT_DIR --output $TABLE
humann2_join_tables --input $input_humann --output $TABLE





# copy files from different subdirectories (e.g from subdirectories of temp_results to temp_bugslist)
# $ find -iname '*.mp3' -exec cp {} /home/sk/test2/ \;
$ find -iname '*.mp3' -exec cp {} /cephyr/NOBACKUP/groups/snic2020-8-84/temp_results/temp_bugslist \;

#CHANGE .mp3 to correct bugslist name!!!
