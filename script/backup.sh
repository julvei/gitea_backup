#!/bin/bash

# Get user and password
credentials="/root/Documents/mega_credentials"
usr=$(head -n 1 "$credentials")
pass=$(tail -n 1 "$credentials")

# Path variables
backup_folder="/home/git/gitea-backup"
gitea="/home/git/gitea/gitea"
working_dir=$(pwd)
remote_dir=/gitea_backup

# File variables
remote_files="$backup_folder"/remote_files.txt

# Other variables
nr_backups=10

# Switch to git user
su - git

# Create backup file from gitea
"$gitea" dump -c /home/git/gitea/custom/conf/app.ini
mv "$working_dir"/gitea-dump-* "$backup_folder"

# Upload file to mega
mega-login '$usr' '$pass'
mega-put "$backup_folder"/gitea-dump-* "$remote_dir"

# Delete if more then X files
mega-ls "$remote_dir" | sort -rn > "$remote_files"
number=$(wc -l "$remote_files" | cut -f 1 -d ' ')

if [ $number -gt $nr_backups ]; then
	start=$((($nr_backups+1)))
	for (( i=$start; i<=$number; i++ ))
	do
		file=$(head -n $i "$remote_files" | tail -n 1)
		mega-rm -f "$remote_dir"/"$file"
	done
fi

# Clean up
mega-logout
rm "$backup_folder"/gitea-dump-*
rm "$remote_files"
exit
