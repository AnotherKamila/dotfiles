set STUFF "$HOME/u/www"
set ENSURE_SYMLINK_TO "$HOME/stuff"

function stuff -d 'put stuff into the STUFF directory and make it world-readable'
    [ -n "$ENSURE_SYMLINK_TO" ] ; and ln -sf "$STUFF" "$ENSURE_SYMLINK_TO"
    cp -r -t "$STUFF" $argv
    chmod -R a+rX $argv
end
