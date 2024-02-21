ulimit -c unlimited
BASE=/home/huangl/workspace/RF_DATE/
EXAMPLE=data
#!/bin/bash
op=$1
if [ "$op" == "start" ]; then
  export LD_LIBRARY_PATH=/usr/local/lib
  rm ./log/test.log
  dir="test.txt"
  echo $BASE/$EXAMPLE/$dir
  ./rf_tcad --dfg_file=$BASE/$EXAMPLE/$dir --II=1 --childNum=4 --pea_column=4 --pea_row=4 >> log/test.log 2>&1 &

elif [ "$op" == "clear" ]; then
  rm -rf log/*
else
  echo "./run (start | clear)"
fi
