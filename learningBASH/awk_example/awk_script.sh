#!/bin/bash

#######################################################################
#
# Description:
# Script with an example about how to use awk tool
# The script is going to process the data for a file called test.txt
# and create a csv file
#
# How to use:
# ./awk_script.sh
# 
# Output:
# A file called output.txt
#
# Prerequisites:
# - test.txt file is needed
# - test2.txt file is needed
#
# Author:
# mmir01
#
# Change log:
# 2022/05/05 - V1
#
#
# Future work:
# - TBW
#
# More info:
# - N/A
#
######################################################################

# --------------------------------------------------------------------
# Start program
# --------------------------------------------------------------------

input_file="test.txt"
output_file="output.txt"

# First line of the csv is the Title Row
echo "File, Processed, Average, Failure Rate" > $output_file

echo -n "test," >> $output_file
# Processing file

# Look for Processed word in the file
# When found, get the second part (where it indicates the ops) and stop there
awk '/Processed/ {print $2; exit}' $input_file | xargs echo -n >> $output_file
# print $2 ? get the second part 
# exit > it means stop after the first match
# with xargs we are getting the results of the awk as a parameter for the echo command

echo -n ',' >> $output_file
# We need ',' as a delimeter for csv files

# Get the average response time
grep "Average" $input_file | awk '{split($0,a,"= "); print a[2]}' | xargs echo -n >> $output_file
# Grep is going to get only the line wher Average is found and sent it to awk
# split($0,a,"= "): 
# split $0 > use all the line
# a > the name of the string
# "= " > the delimiter
# print a[2] > a[1] is the left part of the delimiter, a[2] the right one

echo -n ',' >> $output_file

# Get Failure rate
grep "Failure Rate" $input_file | awk '{split($0,a,"= "); print a[2]}' | xargs echo >> $output_file

# Now we process the second file
input_file="test2.txt"

echo -n "test2," >> $output_file
awk '/Processed/ {print $2; exit}' $input_file | xargs echo -n >> $output_file
echo -n ',' >> $output_file
grep "Average" $input_file | awk '{split($0,a,"= "); print a[2]}' | xargs echo -n >> $output_file
echo -n ',' >> $output_file
grep "Failure Rate" $input_file | awk '{split($0,a,"= "); print a[2]}' | xargs echo >> $output_file


# Extra
# To print the result in a table you can use this script from my repository "Python"
# Just copy and paste the file print_csv.py in the awk_example folder
#echo "| Summary |"
#python print_csv.py $output_file
