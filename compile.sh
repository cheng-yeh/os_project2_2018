cd ./ksocket
make
sudo rmmod ksocket
sudo insmod ksocket.ko
cd ../master_device
make
sudo rmmod master_device
sudo insmod master_device.ko
cd ../slave_device
make
sudo rmmod slave_device
sudo insmod slave_device.ko
cd ../user_program
make
