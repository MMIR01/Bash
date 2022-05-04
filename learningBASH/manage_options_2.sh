#!/bin/bash

#######################################################################
#
# Description:
# Script to learn how to manage options in your scripts
# It uses getopt
#
# How to use:
# ./manage_options_2.sh -o <1|2> [-v|-h]
# -o|--option: select an option (only 1 or 2 valid)
# -v|--verbose: activate verbose
# -h|--help: help menu
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
# https://stackoverflow.com/questions/16483119/an-example-of-how-to-use-getopts-in-bash
#
######################################################################

# ----------------------------------------------------------------------------
# Help menu function
# ----------------------------------------------------------------------------
function help_menu() {
    # Display Help
    echo "OP2. How to use it:"
    echo "./manage_options_2.sh -o <1|2> [-v|-h]" 
    echo
    echo "Examples:"
    echo "./manage_options_2.sh -o >> getopt: option requires an argument -- 'o'"
    echo "./manage_options_2.sh -o 1 >> result: Option 1 selected"
    echo "./manage_options_2.sh --option=2 >> result: Option 2 selected"
    echo "./manage_options_2.sh -o 3 >> result: Option selected is not valid"
    echo "./manage_options_2.sh -option=1 -v >> Verbose activated | Option 1 selected"
    echo "./manage_options_2.sh -o 4 -v >> result: Option selected is not valid"
}

# ----------------------------------------------------------------------------
# Start program
# ----------------------------------------------------------------------------
# OP2 - using getopt
# getopt can manage short (-h) and long options (--help)

options=$(getopt -o o:vh --long help,option:,verbose -a -- "$@")
# Explanation:
# $@ is all command line parameters passed to the script
# -o is for short options like -v
# -l is for long options with double dash like --version
# the comma separates different long options
# -a is for long options with single dash like -version
# ':' after the argument, we are expecting args

eval set -- "$options"
while true; do
    case "$1" in
    -o|--option)
        # The arg is next in position args, so we have to execute shift
        shift
        option=$1
        if [[ ! $option =~ 1|2 ]]; then
            echo "Option selected is not valid"
            exit 1
        fi
        ;;
    -v|--verbose)
        echo "Verbose activated"
        ;;
    -h|--help)
        help_menu
        exit 0
        ;;
    --)
        shift
        break
        ;;
    esac
    shift
done

echo "Option $option selected"
exit 0;