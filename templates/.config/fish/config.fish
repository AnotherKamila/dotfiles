if not status --is-interactive
  exit
end

set -x PATH {{#ADD_TO_PATH}}{{{.}}} {{/ADD_TO_PATH}} $PATH

# display "me" instead of username if it is this
set default_user "kamila"

function fish_greeting
    if which fortune cowsay > /dev/null
        # select random cowfile
        set -l cow (cowsay -l | grep -v 'Cow files in' | tr ' ' '\n' | sort -R | head -n1)
        fortune | cowsay -f $cow
    end
end

. ~/.config/fish/aliases.fish

if [ -f ~/.config/fish/cdist-generated.fish ]
    . ~/.config/fish/cdist-generated.fish
end
