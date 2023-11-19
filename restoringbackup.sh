clear
echo -e "\n\t\t>>>>>            Starting Script            <<<<<\n"
if [ -e ./fileslist.txt ]; then
echo -e "\t\t>>>>>   'fileslist.txt' file is detected    <<<<<\n"
else
echo -e "\t>>>>>   Can't find 'fileslist.txt' file. Stopping script    <<<<<\n"
exit
fi
echo -e "\t\t>>>>>             Listing Files             <<<<<\n"
find ./ | grep -v "^./run/screen" - | sort > newfileslist.txt
echo -e "\t\t>>>>>        Listing Files Successful       <<<<<\n\n\t\t>>>>>       Deleting Unnecessary Files      <<<<<\n"
diff newfileslist.txt fileslist.txt | grep "^<" | sed 's/< //' > deletingfiles.txt
xargs rm -rf < deletingfiles.txt 2>/dev/null
rm deletingfiles.txt
rm newfileslist.txt
echo -e "\t\t>>>>> Deleting Unnecessary Files Successful <<<<<\n"
if [ -e ./backup.tar.gz ]; then
echo -e "\t\t>>>>>   'backup.tar.gz' file is detected    <<<<<\n"
else
echo -e "\t>>>>>    Can't find 'backup.tar.gz file. Stopping script    <<<<<\n"
exit
fi
echo -e "\t\t>>>>>           Restoring Backup            <<<<<\n"
tar -xzf backup.tar.gz ./ --preserve-permissions --same-owner --ignore-failed-read --overwrite
echo -e "\t\t>>>>>      Restoring Backup Successful      <<<<<\n\n\t\t>>>>>           Script Completed            <<<<<\n\n\t\t>>>>>            Rebooting VPS              <<<<<\n"
reboot