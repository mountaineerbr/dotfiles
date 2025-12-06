#!/usr/bin/env zsh



sumf()
{
	ps aux | grep '[f]irefox' | grep '[0-9] tab' | awk '{sum+=$6} END {print sum}';
}

pidsf()
{
	ps aux | grep '[f]irefox' | grep '[0-9] tab' | sort -n -k6 | awk '{print $2}';
}

testf()
{
	typeset memory_kb gb;
	memory_kb=${1:?err};
	gb=${2:-8};

	((memory_kb > gb * 1024 * 1024));
}


# Find the Firefox process for user jsn
PID=$(pgrep -u jsn firefox) || return

# Get the memory usage in kilobytes
#memory_kb=$(ps -o rss= -p "$pid")
echo $((10#0$(sumf) / (1024 * 1024) ))GB

# Check if memory usage exceeds x GB
GB=8 GBT=3 TOUT=60

if testf $(sumf) ${GB}; then
  
  notify-send --urgency=critical --icon=firefox "Memory Alert" "Firefox is using too much memory!"$'\n'"killer: $$";
  
  logger "Firefox (${PID}) exceeding ${GB}GB RAM, killing tabs in ${tout}s.";
  
  sleep ${tout}s;

  for p in $(pidsf); do
	testf $(sumf) ${GBT} || break;
	kill "$p";
  	sleep 20s;
  done
fi
