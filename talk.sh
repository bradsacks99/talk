#!/bin/bash

RUNONCE="false"
VOICE=Tessa
FORMAT=""

VOICES=('Alex' 'Alice' 'Alva' 'Amelie' 'Anna' 'Carmit' 'Damayanti' 'Daniel' 'Diego' 'Ellen' 'Fiona' 'Fred' 'Ioana' 'Joana' 'Jorge' 'Juan' 'Kanya' 'Karen' 'Kyoko' 'Laura' 'Lekha' 'Luca' 'Luciana' 'Maged' 'Mariska' 'Mei-Jia' 'Melina' 'Milena' 'Moira' 'Monica' 'Nora' 'Paulina' 'Samantha' 'Sara' 'Satu' 'Sin-ji' 'Tessa' 'Thomas' 'Ting-Ting' 'Veena' 'Victoria' 'Xander' 'Yelda' 'Yuna' 'Yuri' 'Zosia' 'Zuzana')

FORMATS=('beavis.zen' 'blowfish' 'bud-frogs' 'bunny' 'cheese' 'cower' 'daemon' 'default' 'dragon' 'dragon-and-cow' 'elephant' 'elephant-in-snake' 'eyes' 'flaming-sheep' 'ghostbusters' 'head-in' 'hellokitty' 'kiss' 'kitty' 'koala' 'kosh' 'luke-koala' 'meow' 'milk' 'moofasa' 'moose' 'mutilated' 'ren' 'satanic' 'sheep' 'skeleton' 'small' 'stegosaurus' 'stimpy' 'supermilker' 'surgery' 'telebears' 'three-eyes' 'turkey' 'turtle' 'tux' 'udder' 'vader' 'vader-koala' 'www')

print_voices() {
    for v in "${VOICES[@]}"; do
        echo $v;
    done
}

print_cowsay_formats() {
    for f in "${FORMATS[@]}"; do
        echo $f
    done
}

change_cowsay_format() {
    while :
    do
        echo "Enter a format:";
        read input
        if [[ " ${FORMATS[@]} " =~ " ${input} " ]]; then
            FORMAT=$input
            echo "Format changed to $FORMAT"
            break
        fi
    done
    return
}

change_voice() {
    while :
    do
        echo "Enter a valid voice:";
        read input
        if [[ " ${VOICES[@]} " =~ " ${input} " ]]; then
            VOICE=$input
            echo "Voice changed to $VOICE"
            break
        fi
    done
    return
}

usage() {
    cat <<EOF
-h to display this message
-q to start in quiet mode
-v [voice], set start voice
-f [format], set cowsay format
Type .v to change voice"
Type .q to exit"
Type .lv to list voices"
Type .f to chagne cowsay format
Type .lf to list cowsay formats
EOF
}

case $1 in
    "-q")
        RUNONCE="true"        
        ;;
    "-v")
        if [[ -n "${VOICES[$2]}" ]]; then
            VOICE=$2
        fi
        ;;
    "-h")
        usage
        exit 0
        ;;
    "-f")
        FORMAT=$2
        ;;
esac

while :
do
    if [[ $RUNONCE == "false" ]]; then
        say -v $VOICE "What do you want the computer to say?"
        say -v $VOICE "Type .v to change voice"
        say -v $VOICE "Type .q to exit"
        say -v $VOICE "Type .lv to list voices"
        say -v $VOICE "Type .lf to list cowsay formats"
    fi

    echo "Type here:";
    
    RUNONCE="true"
    
    read input
    
    case $input in
        ".q")
            exit 0        
            ;;
        ".v")
            change_voice
            continue
            ;;
        ".lv")
            print_voices
            continue
            ;;
        ".f")
            change_cowsay_format 
            continue
            ;;
        ".lf")
            print_cowsay_formats 
            continue
            ;;
    esac


    FORMAT_STRING="" 
    if [ -n "$FORMAT" ]; then
        FORMAT_STRING="-f $FORMAT"
    fi

    cowsay $FORMAT_STRING $input
    say -v $VOICE $input
done
