function htpass -d "Generate a line suitable for >>'ing into .htpasswd"
    if [ -n "$argv[1]" ]
        set user "$argv[1]"
    else
        read -p 'echo "Username: "' user
    end
    openssl passwd -apr1 | read pass
    echo "$user:$pass"
end
