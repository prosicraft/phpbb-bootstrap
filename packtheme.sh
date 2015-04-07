#!/bin/bash

# roll_out_file <include-dirs> <cssFileName> <minCssFileName>
roll_out_file () {
    # make sure prefix ends with /
    PREFIX="$(echo "$1" | sed 's/\///')/"

    FILE=$2
    MINFILE=$3
    TESTSTR=$(cat $FILE)

    # copy original to target dir
    MINFILEDIR=$(dirname $MINFILE)
    if [ ! -d "$MINFILEDIR" ]; then
        mkdir -p $MINFILEDIR
    else
        rm -f $MINFILE
    fi

    cp $FILE $MINFILE

    IFS=$'\n'
    for checkln in $(echo "$TESTSTR" | grep '@import url(.*);'); do
        echo "    $checkln"

        # pick css file name from @import line
        filenm=$(sed -e "s/@import url([\'\"]//" -e "s/[\'\"]);//" <<< $checkln)

        # replace line with file contents
        res=$(sed -e "/$checkln/r $PREFIX$filenm" -e "/$checkln/d" $MINFILE)
        echo "$res" > $MINFILE
    done
}



# Loop through all unminified css files beginning with stylesheet_ and create
# minified version of them.
for cssfile in $(ls theme/ | grep 'stylesheet_.*\.css' | grep -v '.min.css'); do
    cssfilemin="$(sed "s/\.css/\.min\.css/" <<< $cssfile)"

    echo "Rolling out theme/$cssfile..."
    roll_out_file "theme/" theme/$cssfile theme/min/$cssfilemin

    echo "Minifying theme/min/$cssfilemin..."
    minified=$(mincss.sh theme/min/$cssfilemin)
    echo "$minified" > theme/min/$cssfilemin
done

echo "Copying theme/img/ to theme/min/img/ ..."
rm -rf theme/min/img/
cp -R theme/img/ theme/min/