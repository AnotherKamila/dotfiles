function mark -d "Mark the current line to make it visible in case of long scrollback"
    set_color -b blue
    set_color white
    set -l info (date '+%a %D %T')
    # WTF why is there no explicit variable name delimiting in fish
    set -l cols (tput cols)
    set -l formatstring (echo "% *s" | sed "s/*/$cols/")
    printf "$formatstring" "$info"
end
