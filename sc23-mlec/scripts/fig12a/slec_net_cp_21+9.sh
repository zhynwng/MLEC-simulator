#!/usr/bin/bash

export PATH="/home/$USER/anaconda3/bin:$PATH"

cd /home/$USER/mlec-sim/src

parse_nines() {
  local output="$1"

  while IFS= read -r line; do
    if [[ $line =~ nines:[[:space:]]([0-9.]+) ]]; then
      local nines="${BASH_REMATCH[1]}"
      echo "$nines"
    fi
  done <<< "$output"
}

parse_throughput() {
  local output="$1"

  while IFS= read -r line; do
    if [[ $line =~ throughput_result:[[:space:]]([0-9.]+) ]]; then
      local throughput_result="${BASH_REMATCH[1]}"
      echo "$throughput_result"
    fi
  done <<< "$output"
}

k=21
p=9
total_nines=0

commands=(
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=1000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=2"
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=10000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=3 -prev_fail_reports_filename=true"
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=10000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=4 -prev_fail_reports_filename=true"
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=10000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=5 -prev_fail_reports_filename=true"
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=10000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=6 -prev_fail_reports_filename=true"
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=10000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=7 -prev_fail_reports_filename=true"
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=10000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=8 -prev_fail_reports_filename=true"
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=10000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=9 -prev_fail_reports_filename=true"
  "python main.py -afr=1 -k_net=21 -p_net=9 -total_drives=57600 -drives_per_rack=960 -io_speed=40 -placement=SLEC_NET_CP -concur=256 -iter=10000 -sim_mode=1 -repair_scheme=0 -interrack_speed=2 -detection_time=30 -num_net_fail_to_report=10 -prev_fail_reports_filename=true"
)

# Use the splitting method to run simulation in multple stages.

for command in "${commands[@]}"; do
  output=$(eval "$command")
  output_nines=$(parse_nines "$output")
  total_nines=$(bc <<< "$total_nines + $output_nines")
done

echo "SLEC_NET_CP $k+$p durability: $total_nines"


cd /home/$USER/ReedSolomonEC
output=$(python scripts/eval_slec.py $k $p)
throughput_result=$(parse_throughput "$output")

echo "SLEC_NET_CP $k+$p throughput: $throughput_result"



result_dir="/home/$USER/mlec-sim/src/results"

if [ ! -d "$result_dir" ]; then
    mkdir -p "$result_dir"
fi
echo "SLEC_NET_CP $k+$p $total_nines $throughput_result" >> $result_dir/slec-net-cp-dur-thru.dat