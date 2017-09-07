#!/bin/bash
N=500

#Set Script Name variable
SCRIPT=`basename ${BASH_SOURCE[0]}`

function HELP {
    echo -e \\n"Help documentation for ${SCRIPT}."\\n
    echo -e "Basic usage: $SCRIPT gradebook.zip"\\n
    echo "Command line switches are optional. The following switches are
    recognized."
    echo "-d --Set output directory. ${BOLD}$OUTPUT_DIR${NORM}."
    echo -e "-h --Displays this help message. No further functions
    are performed."\\n
    echo -e "Example: ${BOLD}$SCRIPT -d assignment1
    gradebook.zip${NORM}"\\n
    exit 1
}

NUMARGS=$#
if [ $NUMARGS -lt 0 ]; then
    HELP
    exit 1
fi


findDir=""
outputDir=""
skip=0

while getopts :i:o:n:s:h FLAG; do
    case $FLAG in
        s)
            skip=$OPTARG
            ;;
        i)
            findDir=$OPTARG
            ;;
        o)
            outputDir=$OPTARG
            ;;
        n)
            N=$OPTARG
            ;;
        h)  #show help
            HELP
            ;;
        \?)
            echo -e
            \\n"Option
            -${BOLD}$OPTARG${NORM}
            not allowed."
            HELP
            ;;
    esac
done

if [ -z $findDir ]; then
    HELP;
    exit 1;
fi

if [ -z $outputDir ]; then
    HELP;
    exit 1;
fi

echo finddir $findDir
echo outputDir $outputDir
# shift ops, all optional args are now removed $1 will have to be the filename
shift $((OPTIND-1))
#
echo "Creating folder '$outputDir' .. "
mkdir -p $outputDir
#
echo "Searching files in '$findDir'"

fileList=(`find "$findDir" -maxdepth 1 -type f`) || echo ''

if [ ${#fileList[*]} -eq 0 ]; then
    echo "No files in '$findDir' detected, exiting...";
    exit 1;
fi

fileList=`find "$findDir" -maxdepth 1 -type f`
IFS=$'\n'
counter=0


currentOutputPath="$outputDir/part_$counter"
echo "Creating first folder '$currentOutputPath' ..."

mkdir -p "$currentOutputPath"

echo "Skipping $skip files ..."
for f in $fileList; do
    let counter=counter+1;

    if [ $counter -lt $skip ]; then
        echo "Skipping $counter $f"
        continue
    fi

    echo "cp $f $currentOutputPath/`basename "$f"`"
    cp $f $currentOutputPath/`basename "$f"`

    if [ `expr $counter % $N` -eq 0 ]; then
        currentOutputPath="$outputDir""/part_$counter"
        mkdir -p "$currentOutputPath"
        echo "Counter $counter"
    fi
done
