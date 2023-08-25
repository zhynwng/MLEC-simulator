#!/usr/bin/bash

export PATH="/home/$USER/anaconda3/bin:$PATH"

cd /home/$USER/mlec-sim/src

parse_avg_net_traffic() {
  local output="$1"

  while IFS= read -r line; do
    if [[ $line =~ avg_net_traffic:[[:space:]]([0-9.]+) ]]; then
      local avg_net_traffic="${BASH_REMATCH[1]}"
      echo "$avg_net_traffic"
    fi
  done <<< "$output"
}


result_dir="/home/$USER/mlec-sim/src/results/fig8"
if [ ! -d "$result_dir" ]; then
    mkdir -p "$result_dir"
fi

for i in 0 1 2 3
do
  output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=100 -afr=1 -sim_mode=0 -interrack_speed=2 -num_net_fail_to_report=3 -num_local_fail_to_report=0 -detection_time=30 -dist=catas_local_failure -repair_scheme=$i)
  avg_net_traffic=$(parse_avg_net_traffic "$output")
  echo "DP-DP $avg_net_traffic" >> $result_dir/scheme-$i.dat
done