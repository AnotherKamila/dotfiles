function paste -d 'Send stdin or files to an online pastebin (sprunge.us)'
    if [ -n $argv ]
        URL="(cat $argv | curl -F 'sprunge=<-' http://sprunge.us)"
    else
        URL="(curl -F 'sprunge=<-' http://sprunge.us)"
    end
    echo "$URL"
    if [ -n "$DISPLAY" ]
        if which xclip >/dev/null
            xclip -selection clipboard -i "$URL"; and echo "[copied to clipboard]" >&2
        else if which xsel >/dev/null
            echo '[TODO xsel support needed]' >&2
        end

end
