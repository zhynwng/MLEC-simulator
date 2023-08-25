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


local_nines=0
total_nines_rs0=0
total_nines_rs1=0
total_nines_rs2=0
total_nines_rs3=0

echo "simulate durability for a local pool"

echo “local_dp 17+3”

output=$(python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=2 -detection_time=30 -repair_scheme=0)
output_nines=$(parse_nines "$output")
local_nines=$(bc <<< "$local_nines + $output_nines")

output=$(python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=3 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
local_nines=$(bc <<< "$local_nines + $output_nines")

output=$(python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=1000000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=4 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
local_nines=$(bc <<< "$local_nines + $output_nines")

echo "durability of each local pool is $local_nines"

echo "------"
echo "Using spliting method. First simulate the probability of having 1 catastrophic local pool by manually inject catastrophic local failures."

echo “mlec_d_d rs0”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=100 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=1 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=0 --manual_spool_fail)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs0=$(bc <<< "$total_nines_rs0 + $local_nines + $output_nines - $(compute_log10 $((57600/120)) )")

echo “mlec_d_d rs1”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=100 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=1 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=1 --manual_spool_fail)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs1=$(bc <<< "$total_nines_rs1 + $local_nines + $output_nines - $(compute_log10 $((57600/120)) )")

echo “mlec_d_d rs2”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=100 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=1 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=2 --manual_spool_fail)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs2=$(bc <<< "$total_nines_rs2 + $local_nines + $output_nines - $(compute_log10 $((57600/120)) )")

echo “mlec_d_d rs3”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=100 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=1 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=3 --manual_spool_fail)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs3=$(bc <<< "$total_nines_rs3 + $local_nines + $output_nines - $(compute_log10 $((57600/120)) )")

##########################


echo "========"
echo "Next, we simulate the probability of having 2 catastrophic local pools."
echo "Before that, we first generate different samples for catastrophic local failures"

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=2 -detection_time=30 -repair_scheme=0

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=3 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=1000000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=4 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true


echo "Then, we simulate the probability of having 2 catastrophic local pool by manually inject catastrophic local failures."

echo “mlec_d_d rs0”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=2 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=0 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs0=$(bc <<< "$total_nines_rs0 + $local_nines + $output_nines - $(compute_log10 $((57600/120-1)) )")

echo “mlec_d_d rs1”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=2 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=1 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs1=$(bc <<< "$total_nines_rs1 + $local_nines + $output_nines - $(compute_log10 $((57600/120-1)) )")

echo “mlec_d_d rs2”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=2 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=2 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs2=$(bc <<< "$total_nines_rs2 + $local_nines + $output_nines - $(compute_log10 $((57600/120-1)) )")

echo “mlec_d_d rs3”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=2 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=3 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs3=$(bc <<< "$total_nines_rs3 + $local_nines + $output_nines - $(compute_log10 $((57600/120-1)) )")

##########################

echo "========"
echo "Next, we simulate the probability of having 3 catastrophic local pools."
echo "Before that, we first generate different samples for catastrophic local failures"

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=2 -detection_time=30 -repair_scheme=0

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=100000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=3 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true

python main.py -io_speed 40 -cap 20 -k_local 17 -p_local 3  -total_drives 120 -drives_per_rack 120 -spool_size 120 -placement=SLEC_LOCAL_DP -concur=256 -iter=1000000 -afr=1 -sim_mode=1 -interrack_speed=20000 -num_net_fail_to_report=0 -num_local_fail_to_report=4 -detection_time=30 -repair_scheme=0 -prev_fail_reports_filename=true


echo "Then, we simulate the probability of having 3 catastrophic local pool by manually inject catastrophic local failures."

echo “mlec_d_d rs0”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=3 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=0 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs0=$(bc <<< "$total_nines_rs0 + $local_nines + $output_nines - $(compute_log10 $((57600/120-2)) )")

echo “mlec_d_d rs1”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=3 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=1 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs1=$(bc <<< "$total_nines_rs1 + $local_nines + $output_nines - $(compute_log10 $((57600/120-2)) )")

echo “mlec_d_d rs2”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=3 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=2 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs2=$(bc <<< "$total_nines_rs2 + $local_nines + $output_nines - $(compute_log10 $((57600/120-2)) )")

echo “mlec_d_d rs3”

output=$(python main.py -io_speed 40 -cap 20 -k_net 10 -p_net 2 -k_local 17 -p_local 3  -total_drives 57600 -drives_per_rack 960 -spool_size 120 -placement=MLEC_D_D -concur=256 -iter=10000 -afr=1 -sim_mode=1 -interrack_speed=2 -num_net_fail_to_report=3 -num_local_fail_to_report=0 -detection_time=30 -repair_scheme=3 --manual_spool_fail -prev_fail_reports_filename=true)
output_nines=$(parse_nines "$output")
echo "$output_nines"
total_nines_rs3=$(bc <<< "$total_nines_rs3 + $local_nines + $output_nines - $(compute_log10 $((57600/120-2)) )")


######

# In MLEC_D_D (10+2)/(17+3), when there are 3 catastrophic local failures, the system might not experience data loss.
# We need to compute this probability and adjust it to the simulation results.
# We only do it for R-FCO, R-HYB, R-MIN. 
# We don't do it for R-ALL because it treats the entire pool as lost.

adjustment=$(python helpers/mlec_dur_adjust.py)
total_nines_rs1=$(bc <<< "$total_nines_rs1 + $adjustment")
total_nines_rs2=$(bc <<< "$total_nines_rs2 + $adjustment")
total_nines_rs3=$(bc <<< "$total_nines_rs3 + $adjustment")


##########################

echo "rs0 total nines: $total_nines_rs0"
echo "DP-DP $total_nines_rs0" >> scheme-0.dat

echo "rs1 total nines: $total_nines_rs1"
echo "DP-DP $total_nines_rs1" >> scheme-1.dat

echo "rs2 total nines: $total_nines_rs2"
echo "DP-DP $total_nines_rs2" >> scheme-2.dat

echo "rs3 total nines: $total_nines_rs3"
echo "DP-DP $total_nines_rs3" >> scheme-3.dat
