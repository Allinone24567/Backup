clear
echo -e "\n\t\t>>>>>            Starting Script            <<<<<\n"
if [ -e ./fileslist.txt ]; then
echo -e "\t\t>>>>>   'fileslist.txt' file is detected    <<<<<\n"
else
echo -e "\t>>>>>   Can't find 'fileslist.txt' file. Stopping script    <<<<<\n"
exit
fi
echo -e "\t\t>>>>>             Listing Files             <<<<<\n"
version=$(find ./ -name "initrd.img-*" | head -n 1 | awk -F"-" '{print $2}')
find ./ | grep -v "^./run/screen" - | grep -v "^./boot" - | sort > file.txt
cat file.txt | grep $version - | grep oracle - | sort > ffiles.txt
diff file.txt ffiles.txt | grep "^<" | sed 's/< //' > newfileslist.txt
echo -e "\t\t>>>>>        Listing Files Successful       <<<<<\n\n\t\t>>>>>       Deleting Unnecessary Files      <<<<<\n"
diff newfileslist.txt fileslist.txt | grep "^<" | sed 's/< //' > deletingfiles.txt
xargs rm -rf < deletingfiles.txt 2>/dev/null
rm deletingfiles.txt
rm newfileslist.txt
rm ffiles.txt
echo -e "\t\t>>>>> Deleting Unnecessary Files Successful <<<<<\n"
if [ -e ./backup.tar.gz ]; then
echo -e "\t\t>>>>>   'backup.tar.gz' file is detected    <<<<<\n"
else
echo -e "\t>>>>>    Can't find 'backup.tar.gz file. Stopping script    <<<<<\n"
exit
fi
echo -e "\t\t>>>>>           Restoring Backup            <<<<<\n"
find ./ -not -writable > exclude1.txt
lsof | awk '{print $9}' | cut -d ' ' -f 1 | sort | grep "^/" | uniq | xargs file | grep -v "directory" | awk '{print $1}' | sed 's/:$//' | sed 's|^|.|' > exclude2.txt
tar -xzf backup.tar.gz --preserve-permissions --same-owner --ignore-failed-read --overwrite --exclude-from=exclude1.txt --exclude-from=exclude2.txt
rm exclude1.txt
rm exclude2.txt
echo -e "\t\t>>>>>      Restoring Backup Successful      <<<<<\n\n\t\t>>>>>           Script Completed            <<<<<\n\n\t\t>>>>>            Rebooting VPS              <<<<<\n"
reboot
