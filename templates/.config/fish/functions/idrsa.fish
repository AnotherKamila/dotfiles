function idrsa -d "cat's your *public* SSH key; generates one if needed"
    set KEY "$HOME/.ssh/id_rsa.pub"
    if [ ! -e "$KEY" ]
        ssh-keygen -t rsa -C "(whoami)@(hostname)-(date '+%Y-%m-%d')" -b 4096
    end
    # sanity check
    if head -n1 "$KEY" | grep PRIVATE >/dev/null
        echo "$KEY looks like a private key." >&2
        echo "Will not cat a private key." >&2
        return 47
    end

    cat "$KEY"
    if [ -n "$DISPLAY" ]
        if which xclip >/dev/null
            xclip -selection clipboard -i "$KEY"; and echo "[copied to clipboard]" >&2
        else if which xsel >/dev/null
            echo '[TODO xsel support needed]' >&2
        end
    end
end
