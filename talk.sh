#!/bin/bash

RUNONCE="false"
voice=Tessa

voices=('Alex' 'Alice' 'Alva' 'Amelie' 'Anna' 'Carmit' 'Damayanti' 'Daniel' 'Diego' 'Ellen' 'Fiona' 'Fred' 'Ioana' 'Joana' 'Jorge' 'Juan' 'Kanya' 'Karen' 'Kyoko' 'Laura' 'Lekha' 'Luca' 'Luciana' 'Maged' 'Mariska' 'Mei-Jia' 'Melina' 'Milena' 'Moira' 'Monica' 'Nora' 'Paulina' 'Samantha' 'Sara' 'Satu' 'Sin-ji' 'Tessa' 'Thomas' 'Ting-Ting' 'Veena' 'Victoria' 'Xander' 'Yelda' 'Yuna' 'Yuri' 'Zosia' 'Zuzana')

print_voices() {
    for v in "${voices[@]}"; do
        echo $v;
    done
}

change_voice() {
    while :
    do
        echo "Enter a valid voice:";
        read input
        if [[ -n "${voices[$input]}" ]]; then
            voice=$input
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
Type .v to change voice"
Type .q to exit"
Type .l to list voices"
EOF
}

case $1 in
    "-q")
        RUNONCE="true"        
        ;;
    "-v")
        if [[ -n "${voices[$2]}" ]]; then
            voice=$2
        fi
        ;;
    "-h")
        usage
        exit 0
        ;;
esac

while :
do
    if [[ $RUNONCE == "false" ]]; then
        say -v $voice "What do you want the computer to say?"
        say -v $voice "Type .v to change voice"
        say -v $voice "Type .q to exit"
        say -v $voice "Type .l to list voices"
    fi
    echo "Type here:";
    RUNONCE="true"
    read input
    if [[ $input == ".q" ]]; then
        exit 0
    fi
    if [[ $input == ".v" ]]; then
        change_voice
    fi
    if [[ $input == ".l" ]]; then
        print_voices
        continue
    fi
    cowsay $input
    say -v $voice $input
done
