clear
echo -e "\n\t\t>>>>>         Starting Script           <<<<<\n\n\t\t>>>>>          Listing Files            <<<<<\n"
find ./ > files.txt
echo ./fileslist.txt >> files.txt
echo ./deletingfiles.txt >> files.txt
echo ./backup.tar.gz >> files.txt
echo ./restoringbackup.sh >> files.txt
cat files.txt | sort > fileslist.txt
rm files.txt
echo -e "\t\t>>>>>     Listing Files Successful      <<<<<\n\n\t\t>>>>>         Creating Backup           <<<<<\n\n\t\t>>>>>       This takes some time        <<<<<\n"
find ./ -not -writable > exclude1.txt
lsof | awk '{print $9}' | cut -d ' ' -f 1 | sort | grep "^/" | uniq | xargs file | grep -v "directory" | awk '{print $1}' | sed 's/:$//' | sed 's|^|.|' > exclude2.txt
echo './dev/*
./proc/*
./sys/*
./tmp/*
./run/*
./boot/*
./mnt/*
./media/*
./lost+found*
./backup.tar.gz
./exclude1.txt
./exclude2.txt
./exclude3.txt
./exclude4.txt
./creatingbackup.sh
./fileslist.txt
./usr/bin/tar
./usr/bin/gzip' > exclude3.txt
version=$(find ./ -name "initrd.img-*" | head -n 1 | awk -F"-" '{print $2}')
find ./ | grep $version - | grep oracle - > exclude4.txt
tar -czpf backup.tar.gz --preserve-permissions --ignore-failed-read --same-owner --exclude-from=exclude1.txt --exclude-from=exclude2.txt --exclude-from=exclude3.txt --exclude-from=exclude4.txt ./ 2>/dev/null
rm exclude1.txt
rm exclude2.txt
rm exclude3.txt
rm exclude4.txt
echo -e "\t\t>>>>>    Creating Backup Successful     <<<<<\n\n\t\t>>>>>         Script Completed          <<<<<\n"
