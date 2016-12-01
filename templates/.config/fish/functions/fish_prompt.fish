## Function to show a segment
function prompt_segment -d "Shows a prompt segment with the given colors"
  set -l fg $argv[1]
  set -l bg $argv[2]

  set_color -b $bg
  set_color $fg

  if [ -n "$argv[3]" ]
    echo -n -s "$argv[3]"
  end
end

function show_status -d "Shows the last exit status"
  if [ $LAST_STATUS != 0 ]
    prompt_segment white red "$LAST_STATUS"
    prompt_segment normal normal " "
  end
end

# function show_virtualenv -d "Show active python virtual environments"
#   if set -q VIRTUAL_ENV
#     set -l venvname (basename "$VIRTUAL_ENV")
#     prompt_segment normal white " ($venvname)"
#   end
# end

function show_user -d "Shows user and host"
  if [ "$USER" = "$default_user" ]
    prompt_segment green normal "me"
  else
    prompt_segment yellow normal (whoami)
  end
  set -l host (hostname -s)
  prompt_segment normal normal "@"
  if [ -n "$SSH_CLIENT" ]
    prompt_segment yellow normal "$host "
  else
    prompt_segment green normal "$host "
  end
end

function show_pwd -d "Shows the current directory"
  set -l pwd (prompt_pwd)
  prompt_segment blue normal "$pwd "
end

# Show prompt w/ privilege cue
function show_prompt -d "Shows prompt with cue for current priv"
  set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
    prompt_segment red normal "# "
  else
    prompt_segment normal normal "> "
    end
end

## SHOW PROMPT
function fish_prompt
  set -g LAST_STATUS $status
  show_status
  show_user
  show_pwd
  show_prompt
  set_color normal
end
