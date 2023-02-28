#!/usr/bin/env zsh

temp_file=$(mktemp)

trap "echo 'User requested exit'; rm -f $temp_file ; exit;" SIGINT SIGTERM

SAMPLE_COUNT=10000

if [[ $(echo "$1" | grep -P '^[0-9]+$') == "$1" ]]
then
  echo "Sample count is being set $1"
  SAMPLE_COUNT=$1
  shift
fi

the_cmd="$@"

echo "Will repeat ${SAMPLE_COUNT} times: ${@}"

repeater() {
  for (( i=0; i<$SAMPLE_COUNT; i++ ))
  do
    echo $i
    start_time=$(date +%s.%N)
    $the_cmd
    stop_time=$(date +%s.%N)
    echo $(( $stop_time - $start_time )) >> $temp_file
  done
}

tot_start=$(date +%s.%N)
repeater
tot_stop=$(date +%s.%N)

< $temp_file sort -h | awk '
    function pstat(c,v,p) {
      i = int((c-1) * p / 100.0)
      return v[i]
    }

    {
      values[count++]=$1
      sum += $1
      sumsq += $1*$1
    }

    END {
      print "sum: " sum \
          ", mean: " sum/NR \
          ", stdev: " sqrt(sumsq/NR - (sum/NR)*(sum/NR)) \
          ", p0: " pstat(count, values, 0) \
          ", p50: " pstat(count, values, 50) \
          ", p90:" pstat(count, values, 90) \
          ", p99: " pstat(count, values, 99) \
          ", p100: " pstat(count, values, 100)
    }
'
echo "total: " $(( $tot_stop - $tot_start ))
rm -f $temp_file
