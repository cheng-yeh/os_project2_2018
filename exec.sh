if [ $1 = f ]
then
	method=f
else
	method=m
fi
for FILE in `find ./data -name *.in`
do
    sudo ./user_program/master $FILE $method &
	sudo ./user_program/slave $FILE.out $method 127.0.0.1
done
