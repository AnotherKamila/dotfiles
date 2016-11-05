function fish_greeting
    if which fortune > /dev/null
        # select random cowfile
        set -l cow (cowsay -l | grep -v 'Cow files in' | tr ' ' '\n' | sort -R | head -n1)
        fortune | cowsay -f $cow
    end
end

# display "me" instead of username if it is this
set default_user "kamila"

. ~/.config/fish/aliases.fish
