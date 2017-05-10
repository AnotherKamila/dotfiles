set LOGFILE "$HOME/u/p.log"
function p -d 'stupid-simple "log string with date to a file" thing'
    set now (date -Iseconds)
    echo -e "$now\t$argv" >>$LOGFILE
end

function pcat
    tail -n 10 $LOGFILE
end
