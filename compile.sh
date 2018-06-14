cd ./ksocket
make
sudo insmod ksocket.ko
cd ../master_device
make
sudo insmod master_device.ko
cd ../slave_device
make
sudo insmod slave_device.ko
cd ../user_program
make


