#!/usr/bin/env bash

DELAY=3
DIR='/home/free/videos/xcast/'
DISPLAY=':0'
EDIT=false
FILE=$(date +"%y-%m-%d_%H-%M")
FPS=60
HELP=false
MARGIN=$(( 10 + 0 ))
NOTERM=false
QMAX=10
RECORD='screen'
SLOPWIDTH=2
TEMP='temp'
TITLEBAR=0

OPTS=$(getopt -o hwrf:c:q:d:e:x -l help,window,region,fps:,qmax:,delay:,edit:,no-term -- "$@")
eval set -- "$OPTS"

while : 
do
    case "$1" in
        -h|--help)    
            HELP=true              
            shift 1 
            ;;
        -w|--window)  
            RECORD='window'
            shift 1 
            ;;
        -r|--region)
            RECORD='region'
            shift 1 
            ;;
        -f|--fps)
            FPS="$2"
            shift 2 
            ;;
        -q|--qmax)
            QMAX="$2"
            shift 2
            ;;
        -d|--delay)
            DELAY="$2"
            shift 2 
            ;;
        -e|--edit)
            FILE="$2" && \
                EDIT=true
            shift 2 
            ;;
        -x|--no-term) 
            NOTERM="true"
            shift 1 
            ;;
        --) 
            shift
            break 
            ;;
        *) 
            echo "xcast: internal error"
            exit 1
    esac
done

if $HELP 
then
    echo -e \
        "Usage: xcast [OPTION]...\n" \
        "\n" \
        " -w | --window          Select record mode 'window'\n" \
        " -r | --region          Select record mode 'region'\n" \
        " -f | --fps 30          Frames per second [12-60]\n" \
        " -q | --qmax 10         Maximum Quantization [1-31]\n" \
        " -d | --delay 2         Seconds before recording\n" \
        " -e | --edit out        Edit out(.mkv) in '$DIR'\n" \
        " -x | --no-term         Record with conversion, do not prompt user in stdout\n"
    exit 0
fi

getgeometry() 
{
    unset x y w h
    eval "$($1 | 
        sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
            -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
            -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
            -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )"
}

appendmargins() 
{
	x=$(x-$MARGIN)
	y=$(y-$MARGIN-$TITLEBAR)
    w=$($MARGIN*2+w)
	h=$($MARGIN*2+h+$TITLEBAR)
}

drawrectangle() 
{
    unset x y w h
	region=$(slop -t 0 -b $SLOPWIDTH -c 1,1,1,1 -f "%x %y %w %h" --nokeyboard) || \
        exit 1
	IFS=' ' read -r x y w h <<< "$region"
}

appendrectangle() 
{
	x=$(x-$SLOPWIDTH)
	y=$(y-$SLOPWIDTH)
	w=$($SLOPWIDTH*2+w)
	h=$($SLOPWIDTH*2+h)
}

recordmkv() 
{
    notify-send "xcast" "Recording to \"$DIR$FILE.mkv\""

    ffmpeg -f x11grab -s "$w"'x'"$h" -r "$FPS" -i "$DISPLAY"'+'"$x"','"$y" \
        -preset "ultrafast" -crf 10 -c:v libx264 -y "$DIR$FILE.mkv"

    notify-send "xcast" "Recorded to \"$DIR$FILE.mkv\""
    echo -e "\nxcast: recording saved to '\033[1;32m$DIR$FILE.mkv\033[0m'\n"
}

if ! $EDIT 
then
    case "$RECORD" in
        'window')
            getgeometry 'xwininfo'
            appendmargins
            ;;
        'region')
            drawrectangle
            appendrectangle
            ;;
        *)
            getgeometry 'xwininfo -root'
            ;;
    esac

    echo -n "xcast: recording begins in "
    while [ "$DELAY" -gt 0 ]
    do
        echo -n "$DELAY"".."
        DELAY=$((DELAY-1))
        sleep 1
    done
    echo -e "\n"

    recordmkv
else
    if [ -f "$DIR$FILE.mkv" ]
    then
        echo -e "\nxcast: loaded file '\033[1;32m$DIR$FILE.mkv\033[0m'\n"
    else
        echo -e "\nxcast: \033[1;31merror: \033[0mfile '$DIR$FILE.mkv' does not exist\n"
        exit 0
    fi
fi

convertwebm() 
{
    ffmpeg -i "$DIR$FILE.mkv" \
        -c:v libvpx -qmin 1 -qmax "$QMAX" \
        "$DIR$FILE.webm"

    notify-send "xcast" "Conversion finished for \"$DIR$FILE.mkv\""
    echo -e "\nxcast: webm conversion saved to '\033[1;32m$DIR$FILE.webm\033[0m'.\n"
}

editmkv() 
{
    rm -f "$DIR$TEMP.mkv"

    while : 
    do
        read -n1 -r \
            -p $'\nxcast: press key to select \033[1;33m{edit}\033[0m action: \033[0;32m[o]riginal\033[0m \033[0;32m[p]review\033[0m \033[0;36m[t]rim\033[0m \033[0;36m[c]rop\033[0m \033[0;36m[s]cale\033[0m \033[0;36m[f]rames\033[0m \033[0;31mover[w]rite\033[0m \033[0;33m[b]ack\033[0m \n' key

        case "$key" in
            'o') mpv "$DIR$FILE.mkv" --loop=inf 
                ;;
            'p') mpv "$DIR$TEMP.mkv" --loop=inf 
                ;;
            't')
                read -r -p $'\nxcast: enter video start time (hr:min:sec.ms): \n' stime
                read -r -p $'\nxcast: enter video end time (hr:min:sec.ms): \n' etime
                ffmpeg -i "$DIR$FILE.mkv" -ss "$stime" -to "$etime" "$DIR$TEMP.mkv"
                ;;
            'c')
                read -r -p $'\nxcast: enter geometry to crop (width:height:x:y): \n' vcrop
                ffmpeg -i "$DIR$FILE.mkv" -filter:v "crop=$vcrop" "$DIR$TEMP.mkv"
                ;;
            's')
                read -r -p $'\nxcast: enter dimension to scale (width:height or iw/2:ih/2): \n' vscale
                ffmpeg -i "$DIR$FILE.mkv" -vf scale="$vscale" "$DIR$TEMP.mkv"
                ;;
            'f')
                rm -f "/tmp/output-"*.png
                read -r -p $'\nxcast: speed up video by reducing frames to (<'"$FPS$"') fps: \n' vfps
                ffmpeg -i "$DIR$FILE.mkv" -r "$vfps" -f image2 "/tmp/output-%06d.png"
                ffmpeg -r "$FPS" -i "/tmp/output-%06d.png" -c:v libx264 "$DIR$TEMP.mkv"
                ;;
            'w')
                echo -e "\nxcast: overwriting original '\033[1;32m$DIR$FILE.mkv'"
                mv "$DIR$TEMP.mkv" "$DIR$FILE.mkv"
                break
                ;;
            'b') break 
                ;;
        esac
    done
    echo -e "\n"
}

if $NOTERM
then
    convertwebm

    exit 0
fi

while : 
do
    read -n1 -r \
        -p $'\nxcast: press key to select \033[1;33m{main}\033[0m action: \033[0;32m[p]review\033[0m \033[0;34m[w]ebm\033[0m \033[0;36m[e]dit\033[0m \033[0;31me[x]it\033[0m \n' key
    
    case "$key" in
        'p')
            mpv "$DIR$FILE.mkv" --loop=inf
            ;;
        'w') 
            convertwebm 
            ;;
        'e') 
            editmkv     
            ;;
        'x')
            exit 0
            ;;
        *)
            echo
            ;;
    esac
done
echo -e "\n"

exit 0
