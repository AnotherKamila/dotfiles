set LOGFILE "$HOME/u/quicklog.txt"
function quicklog -d 'stupid-simple "log string with date to a file" thing'
    set now (date -Iseconds)
    echo -e "$now\t$argv" >> $LOGFILE
end

function quicklogcat
    tail -n 10 $LOGFILE
end
