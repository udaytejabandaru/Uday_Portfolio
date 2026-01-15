import itertools
import csv
import re

# Define the benchmark programs
benchmarks = ["401.bzip2", "429.mcf", "456.hmmer", "458.sjeng", "470.lbm"]
BM=benchmarks[0]
# Define the data arrays
local = [1024, 2048, 4096]
global_ = [1024, 2048, 4096]
choice = [1024, 2048, 4096]

# Define the column headers for the CSV file
headers = ["Local_Global_Choice"] + ["_BTBMisspct"] + ["_BranchMispredprc"]

# Generate all possible combinations of the entries in the data arrays
combinations = list(itertools.product(local, global_, choice))

# Create a list to hold the data for each row of the CSV file
rows = []

# Loop through each combination and create a row for the CSV file
for comb in combinations:
    foldername = "l_{}_g_{}_c_{}".format(comb[0], comb[1], comb[2])
    row = ["{}_{}_{}".format(comb[0], comb[1], comb[2])]
    benchmark_folder = "/home/013/u/ut/utb220000/CA_proj/Project1_SPEC/{0}".format(BM)
    stats_file = "{}/{}/stats.txt".format(benchmark_folder, foldername)
    with open(stats_file, 'r') as f:
        data = f.read()
    branch_mispred_pct = re.findall(r'system\.cpu\.BranchMispredPercent\s+(\d+\.\d+)\s+#', data)[0]
    btb_miss_pct = re.findall(r'system\.cpu\.branchPred\.BTBMissPct\s+(\d+\.\d+)\s+#', data)[0]
    row += [btb_miss_pct, branch_mispred_pct]
    rows.append(row)

# Write the updated table to the CSV file
with open('combinations.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(headers)
    writer.writerows(rows)

