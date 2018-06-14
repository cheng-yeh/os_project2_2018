if [ $1 = f ]
then
	method=f
else
	method=m
fi
cd ./user_program
sudo ./master ../data/file1_in $method &
sudo ./slave ../data/file_out f 127.0.0.1
sudo ./master ../data/file2_in $method &
sudo ./slave ../data/file_out f 127.0.0.1
sudo ./master ../data/file3_in $method &
sudo ./slave ../data/file_out f 127.0.0.1
sudo ./master ../data/file4_in $method &
sudo ./slave ../data/file_out f 127.0.0.1
cd ../
