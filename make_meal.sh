#! /bin/sh

md () 
{ 
    local htmldir="../recipies";
    test -d $htmldir || mkdir $htmldir;
    local base="$(basename $1 '.md')";
    local htmlfile="$htmldir/${base}.html";
    pandoc --ascii -f markdown+pipe_tables $1 > "$htmlfile";
    echo "$htmlfile"
}

title="$*"
name="$(echo $title | sed 's/ /_/g;s/\(.*\)/\L\1/')"
if [ -z "$name" ]
then
    echo "usage: $0 NAME"
    echo "       NAME was not specified"
    exit 1
fi

if [ ! -e ./$name.md ]; then
    cp ./markdown_template.txt ./$name.md
    sed -i "s/TITLE/$title/" ./$name.md
fi
vim ./$name.md
md ./$name.md
