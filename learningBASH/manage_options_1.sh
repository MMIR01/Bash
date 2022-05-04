#!/bin/bash

#######################################################################
#
# Description:
# Script to learn how to manage options in your scripts
# It uses getopts
#
# How to use:
# ./manage_options_1.sh -o <1|2> [-v|-h]
# -o: select an option (only 1 or 2 valid)
# -v: activate verbose
# -h: help menu
#
# Prerequisites:
# - N/A
#
# Author:
# mmir01
#
# Change log:
# 2022/05/04 - V1
#
#
# Future work:
# - TBW
#
# More info:
# https://dustymabe.com/2013/05/17/easy-getopt-for-a-bash-script/
# https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/
#
######################################################################

# ----------------------------------------------------------------------------
# Help menu function
# ----------------------------------------------------------------------------
function help_menu() {
    # Display Help
    echo "OP1. How to use it:"
    echo "./manage_options_1.sh -o <1|2> [-v|-h]" 
    echo
    echo "Examples:"
    echo "./manage_options_1.sh -o >> result: Invalid option: o requires an argument"
    echo "./manage_options_1.sh -o 1 >> result: Option 1 selected"
    echo "./manage_options_1.sh -o 2 >> result: Option 2 selected"
    echo "./manage_options_1.sh -o 3 >> result: Option selected is not valid"
    echo "./manage_options_1.sh -o 1 -v >> Verbose activated | Option 1 selected"
    echo "./manage_options_1.sh -o 1 -v 4 >> Verbose activated | Option 1 selected"
    echo "./manage_options_1.sh -o 4 -v >> result: Option selected is not valid"
}

# ----------------------------------------------------------------------------
# Start program
# ----------------------------------------------------------------------------
# OP1 - using getopts
# getopts only uses short options, this is -h, -v etc. 
# How to use it:
# ':' at the beginning disables the default error handling of invalid options
# So if an invalid option is provided, the option variable is assigned the value ?
# getopts <options> follow by ':' if the option expect and argument; 

while getopts ":ho:v" OPTION; do
# 'h' option (help) does not accept arguments. If selected the program finishes
# 'o' this option accepts arguments so we use :
# 'v' option (verbose) does not accept arguments
    case $OPTION in
    o)
        option=$OPTARG
        if [[ ! $option =~ 1|2 ]]; then
            echo "Option selected is not valid"
            exit 1
        fi
        ;;
    v)
        echo "Verbose activated"
        ;;
    h)
        help_menu
        exit 0
        ;;
    :)
        echo "Invalid option: $OPTARG requires an argument"
        exit 1
        ;;
    \?)
        echo "Wrong option introduced"
        echo "Usage: ./manage_options_1.sh -o <1|2> [-v|-h]"
        exit 1
        ;;
    *)
        echo "Incorrect options provided"
        exit 1
        ;;
    esac
done
# The variable OPTIND holds the number of options parsed by the last call to getopts. 
# This command will remove options that have already been handled from $@
shift $((OPTIND -1))

echo "Option $option selected"
exit 0;
