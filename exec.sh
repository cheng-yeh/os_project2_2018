if [ $1 = f ]
then
	method=f
else
	method=m
fi
echo $method
for FILE in `find ./data -name *.in`
do
    sudo ./user_program/master $FILE $method &
	sudo ./user_program/slave $FILE.out $method 127.0.0.1
done
=======
cd ./user_program
sudo ./master ../data/file1_in $method &
sudo ./slave ../data/file1_out $method 127.0.0.1
sudo ./master ../data/file2_in $method &
sudo ./slave ../data/file2_out $method 127.0.0.1
sudo ./master ../data/file3_in $method &
sudo ./slave ../data/file3_out $method 127.0.0.1
sudo ./master ../data/file4_in $method &
sudo ./slave ../data/file4_out $method 127.0.0.1
cd ../
