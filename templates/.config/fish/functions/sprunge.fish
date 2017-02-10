function sprunge -d 'Send stdin or files to an online pastebin (sprunge.us)'
    if [ -n $argv ]
        set URL (cat $argv | curl -F 'sprunge=<-' http://sprunge.us)
    else
        set URL (curl -F 'sprunge=<-' http://sprunge.us)
    end
    echo "$URL"
    if [ -n "$DISPLAY" ]
        if which xclip >/dev/null
            echo "$URL" | xclip -selection clipboard -i ; and echo "[copied to clipboard]" >&2
        else if which xsel >/dev/null
            echo '[TODO xsel support needed]' >&2
        end
    end
end
