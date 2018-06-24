# OS Project 2 2018

This is the source code of operating system project2.

```
./master_device : the device moudule for master server
./slave_device  : the device moudule for slave client
./ksocket: the device moudule including the funtions used for kernel socket
./data   : input/output data
./user_program : the user program "master" and "slave"
```

## How to Run

```
sh compile.sh
sh exec.sh
```

## Analyze Steps:

make dummy data:

```bash
bash createDummyFiles.sh 
```

files will be created in `/data`

Comment `#difine DUBUG` in `master.c` and `slave.c`

```
sh exec.sh
```

the output format:
```
 trans_time, file_size, method
```