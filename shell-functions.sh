subdir-do() {
    echo "=== ''${@} ==="
    for d in */
    do
    (
        cd $d
        echo ">>> entering $d"
        "${@}"
        echo "<<< exiting $d"
    )
    done
}

wz-tab() {
    python3 -c 'if True: # prevent indentation error
import argparse
import json
from os.path import expanduser
from base64 import b64encode
parser = argparse.ArgumentParser()
parser.add_argument("cmd", help="command", choices=("open-tab", "set-tab-title"))
parser.add_argument("title", help="the title")
parser.add_argument("--verbose", "-v", help="be chatty", action="store_true")
parser.add_argument("--cwd", help="the title", default=expanduser("~"))
args = parser.parse_args()
cmd_context = {
  "cmd": args.cmd,
  "title": args.title,
  "cwd": args.cwd
}
payload = f"SetUserVar=hacky-user-command={b64encode(json.dumps(cmd_context).encode()).decode()}"
if args.verbose:
  print(f"cmd_context: {cmd_context}")
  print(f"payload: {payload}")
print(f"\033]1337;{payload}\007", end="")
' "$@"
}


timeit.sh() {
    temp_file=$(mktemp)

    timeit.sh-summary() {
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
    }

    trap "echo 'User requested exit'; timeit.sh-summary ; return" SIGINT SIGTERM

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
        eval $the_cmd
        stop_time=$(date +%s.%N)
        echo $(( $stop_time - $start_time )) >> $temp_file
      done
    }

    tot_start=$(date +%s.%N)
    repeater
    tot_stop=$(date +%s.%N)

    timeit.sh-summary
}

