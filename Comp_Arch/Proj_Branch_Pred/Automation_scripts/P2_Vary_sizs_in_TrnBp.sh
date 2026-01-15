
	#!/bin/bash

	local=(1024 2048 4096 8192)
	global=(1024 2048 4096 8192)
	choice=(1024 2048 4096 8192)
	
	file="/home/013/u/ut/utb220000/CA_proj/gem5/src/cpu/pred/BranchPredictor.py"
	start_class="TournamentBP(BranchPredictor)"
	end_class="BiModeBP(BranchPredictor)"
	keyword1="localPredictorSize"
	keyword2="globalPredictorSize"
	keyword3="choicePredictorSize"
	BENCHMARKno1=401.bzip2
	BENCHMARKno2=429.mcf
	BENCHMARKno3=456.hmmer
	BENCHMARKno4=458.sjeng	
	BENCHMARKno5=470.lbm
	l1d="128kB"
	l1i="128kB"
	l2="1MB"
	l1d_assoc=2
	l1i_assoc=2
	l2_assoc=4
	cs=64


	ca_base=$(echo ~)/CA_proj
	echo $ca_base
	data=$ca_base/data
	echo $data
	
    cd /home/013/u/ut/utb220000/CA_proj/gem5/src/ 
	git checkout .
	for l in "${local[@]}"
	do
	 for g in "${global[@]}"
	 do
	  for c in "${choice[@]}"
	  do
			filename="l_${l}_g_${g}_c_${c}"
		echo $filename
		# Get the line numbers of the start and end classes
		start=$(grep -n "^class $start_class" $file | cut -d: -f1)
		end=$(grep -n "^class $end_class" $file | cut -d: -f1)

		if [ -z "$start" ]; then
		  echo "Class $start not found in file $file."
		  exit 1
		fi

		if [ -z "$end" ]; then
		  echo "Class $end not found in file $file."
		  exit 1
		fi
		line_num1=$(awk 'NR>='$start' && NR<= '$end' && /'$keyword1'/{print NR}' $file)
		line_num2=$(awk 'NR>='$start' && NR<= '$end' && /'$keyword2'/{print NR}' $file)
		line_num3=$(awk 'NR>='$start' && NR<= '$end' && /'$keyword3'/{print NR}' $file)
		if [[ ! -z "$line_num1" ]]; then
			sed -i "${line_num1}s/[0-9][0-9][0-9][0-9]/${l}/g" "$file"
			echo "Line $line_num1 modified"
		fi
		if [[ ! -z "$line_num2" ]]; then
			sed -i "${line_num2}s/[0-9][0-9][0-9][0-9]/${g}/g" "$file"
			echo "Line $line_num2 modified"
		fi
		if [[ ! -z "$line_num3" ]]; then
			sed -i "${line_num3}s/[0-9][0-9][0-9][0-9]/${c}/g" "$file"
			echo "Line $line_num3 modified"
		fi

		echo -e "****** DELETING OLD BUILD FILE   ******\n"
		cd $ca_base/gem5
		rm -rf ./build/X86
		echo -e "****** COMPILING THE SOURCE CODE ******\n"
		scons build/X86/gem5.opt -j 4

		echo -e "****** MAKING CHANGE IN THE SOURCE CODE ******\n"
		for q in {1..4}; do
			 sed -i "s|time.*$|time \$GEM5_DIR/build/X86/gem5.opt -d ./${filename} \$GEM5_DIR/configs/example/se.py -c \$BENCHMARK -o \$ARGUMENT -I 500000000 --cpu-type=TimingSimpleCPU --caches --l2cache --l1d_size=${l1d} --l1i_size=${l1i} --l2_size=${l2} --l1d_assoc=${l1d_assoc} --l1i_assoc=${l1i_assoc} --l2_assoc=${l2_assoc} --cacheline_size=${cs}|g" $ca_base/Project1_SPEC/$(eval echo \${BENCHMARKno${q}})/runGem5.sh
		   done

		sed -i "s|time.*$|time \$GEM5_DIR/build/X86/gem5.opt -d ./${filename} \$GEM5_DIR/configs/example/se.py -c \$BENCHMARK -o \'19 reference.dat 0 1 $ca_base/Project1_SPEC/470.lbm/data/100_100_130_cf_a.of' -I 500000000 --cpu-type=TimingSimpleCPU --caches --l2cache --l1d_size=${l1d} --l1i_size=${l1i} --l2_size=${l2} --l1d_assoc=${l1d_assoc} --l1i_assoc=${l1i_assoc} --l2_assoc=${l2_assoc} --cacheline_size=${cs}|g" $ca_base/Project1_SPEC/470.lbm/runGem5.sh

		echo starting_sleep
		  for t in {1..5}; do
			cd $ca_base/Project1_SPEC/$(eval echo \${BENCHMARKno${t}}) && sh $ca_base/Project1_SPEC/$(eval echo \${BENCHMARKno${t}})/runGem5.sh &
		  done
		wait

	cd $ca_base
	  done
	 done
	done
