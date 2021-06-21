# See https://kevlinhenney.medium.com/need-something-sorted-sleep-on-it-11fdf8453914

function sleeper() {  # define a function that...
    sleep "$1"        # sleeps for duration of its argument in seconds
    echo "$1"         # prints its argument to the console
}

while [ -n "$1" ]   # while the script's lead argument is not empty
do
    sleeper "$1" &    # launch a sleeper with the lead argument
    shift           # shift argument list, so $2 becomes $1, etc.
done
wait                # wait for all launched processes to complete
