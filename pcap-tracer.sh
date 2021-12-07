#!/bin/sh

# function to clean up old files
# if file count is greater than maxFileCount then
# clean function will delete it
cleanUp () {
    yourfilenames=`ls -t`
    # echo "${#yourfilenames[@]}"

    index=0
    increment=1
    for eachfile in $yourfilenames
    do
    #echo $eachfile
    #echo $index
    index=`expr $index + $increment`

    if [ $index -gt $maxFileCount ]
    then
            echo "deleting ${eachfile}"
            rm "$eachfile"
    fi
    done
}

# enter into folder specified 
cd ./pcaps

# below command capture tcpdump on 
# portrange 2775-2778
# -w filename
# -C file size 1m (1 MB)
# file name for capture traces trace-pcap0,..trace-pcap1 etc
sudo tcpdump portrange 2775-2778 -w trace-pcap -C 1m &


# Max file count 
maxFileCount=10


# infinte loop to clean up every 30 seconds
while [ true ]
do 
    cleanUp
    sleep 30
done
