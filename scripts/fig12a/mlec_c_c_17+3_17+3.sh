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

compute_log10() {
  local number=$1
  local log=$(echo "l($number)/l(10)" | bc -l)
  echo "$log"
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

k_net=17
p_net=3
k_local=17
p_local=3
local_nines=0
total_nines_rs3=0

echo "simulate durability for a local pool"
output=$(python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=2 -detection_time=30 -repair_scheme=0)
output_nines=$(parse_nines "$output")
local_nines=$(bc <<< "$local_nines + $output_nines")

output=$(python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=3 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
local_nines=$(bc <<< "$local_nines + $output_nines")

output=$(python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=4 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
local_nines=$(bc <<< "$local_nines + $output_nines")

echo "durability of each local pool is $local_nines"

echo "running repair method 3"

output=$(python main.py -io_speed 40 -cap 20 -k_net 17 -p_net 3 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 20 -placement=MLEC_C_C -concur=256 -iter=100 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=1 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=3 --manual_spool_fail)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs3=$(bc <<< "$total_nines_rs3 + $local_nines + $output_nines - $(compute_log10 $((57600/20)) )")

###


python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=2 -detection_time=30 -repair_scheme=0

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=3 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=4 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true

output=$(python main.py -io_speed 40 -cap 20 -k_net 17 -p_net 3 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 20 -placement=MLEC_C_C -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=2 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=3 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs3=$(bc <<< "$total_nines_rs3 + $local_nines + $output_nines - $(compute_log10 $((17+3-1)) )")

###


python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=2 -detection_time=30 -repair_scheme=0

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=3 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=4 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true

output=$(python main.py -io_speed 40 -cap 20 -k_net 17 -p_net 3 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 20 -placement=MLEC_C_C -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=3 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=3 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs3=$(bc <<< "$total_nines_rs3 + $local_nines + $output_nines - $(compute_log10 $((17+3-2)) )")

###

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=2 -detection_time=30 -repair_scheme=0

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=3 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 20 -drives_per_rack 20 -spool_size 20 -placement=SLEC_LOCAL_CP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=4 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true

output=$(python main.py -io_speed 40 -cap 20 -k_net 17 -p_net 3 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 20 -placement=MLEC_C_C -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=4 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=3 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs3=$(bc <<< "$total_nines_rs3 + $local_nines + $output_nines - $(compute_log10 $((17+3-3)) )")



echo "MLEC_C_C ($k_net+$p_net)/($k_local+$p_local) rs3 total nines: $total_nines_rs3"

cd /home/$USER/ReedSolomonEC
output=$(python scripts/eval_mlec.py $k_net $p_net $k_local $p_local)
throughput_result=$(parse_throughput "$output")

echo "MLEC_C_C ($k_net+$p_net)/($k_local+$p_local) throughput: $throughput_result"


result_dir="/home/$USER/mlec-sim/src/results"

if [ ! -d "$result_dir" ]; then
    mkdir -p "$result_dir"
fi
echo "MLEC_C_C ($k_net+$p_net)/($k_local+$p_local) $total_nines_rs3 $throughput_result" >> $result_dir/mlec-c-c-dur-thru.dat