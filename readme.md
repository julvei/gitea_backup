# Gitea backup
The backup.sh bash script can backup the [gitea server](https://gitea.io/en-us/) repositories by using the [gitea dump command](https://docs.gitea.io/en-us/backup-and-restore/) to the [mega cloud](https://mega.nz/). A number of history files can be configured. Advantage is, that the mega cloud has a [command line tool](https://mega.nz/cmd), such that the backup can be scheduled on a regular basis via a script and furthermore this cloud is end-to-end encrypted.

**Disclaimer: I have nothing to do with the gitea project, this is only my way to backup my private gitea repositories. This script is running actively on my server without problems, but I have only tested it there, so no guarantee it works anywhere else!**  

**Be careful: This script has not been made failsafe, so be sure you know what this script is doing and which files and folders have to be available. I am planning to change this by times.**

## Mega Command-Line
The MEGAcmd can be installed by via their [github repository](https://github.com/meganz/MEGAcmd). [Documentation](https://github.com/meganz/MEGAcmd/blob/master/UserGuide.md) about it can also found in the github repository.

## Script Configuration
Following steps have to be done in order to make this script running:
* My gitea user is named `git`.
* The script is running by root. **Be careful, root has all rights, so be sure you know what you are doing in the script!**
* Provide a credential document with your mega-credentials under the `credentials` path.
  * The script must have exactly following structure:
  ```
  <username>
  <password>
  ```
  * **It is not secure to save your credentials in clear text!** I have only given my root user the rights to read, write and execute the credentials file with `chown` and `chmod`, this makes it a litte more secure. Nobody but you should have root rights on your server, otherwise you have some bigger problems!
* Create a backup folder and provide the path via `backup_folder`.
* Define the gitea base path via `gitea`.
* Define the working directory (where the gitea-backup folder and gitea is located) via `working_dir`.
* Define the remote directory in the mega cloud via `remote_dir`.
* Define how long the history of gitea backups should be with the `nr_backups` tag.

## Schedule the script
In order to do a regular backup of your gitea repositories, schedule to run the script regulary with [crontab](https://www.man7.org/linux/man-pages/man5/crontab.5.html) which should be available in most of the linux distributions. Schedule it for example once a day by running `sudo crontab -e` and configure the crontab schedule with the path to the script. By running crontab with sudo, you make sure the script is executed by root.  

Please feel free to ask questions or to add issues.
