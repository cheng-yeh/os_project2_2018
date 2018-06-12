This is the source code of operating system project2.

./master_device : the device moudule for master server
./slave_device  : the device moudule for slave client
./ksocket: the device moudule including the funtions used for kernel socket
./data   : input/output data
./user_program : the user program "master" and "slave"


To use it, please:
1.execute "./compile.sh" to compile codes and install modules
2.execute "./exec.sh f" to transmit all the data with file I/O
  execute "./exec.sh m" to transmit all the data with mmap I/O

Make sure that you are under the path "./user_program" when you execute user programs.
Though the execution order of user program "master" and "slave" does not matter,
it is suggested to execute "master" first to get more precise transmission time.

