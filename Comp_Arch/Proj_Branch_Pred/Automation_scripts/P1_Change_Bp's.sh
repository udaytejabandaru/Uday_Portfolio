
	#!/bin/bash

	BP=('TournamentBP()' 'LocalBP()' 'BiModeBP()')
	#BP=('LocalBP()')
	keywords="NULL|TournamentBP|LocalBP|BiModeBP"
	keywords_sed="NULL\\|TournamentBP()\\|LocalBP()\\|BiModeBP()"
	file="/home/013/u/ut/utb220000/CA_proj/gem5/src/cpu/simple/BaseSimpleCPU.py"
	start_class="BaseSimpleCPU(BaseCPU)"
	keyword=""
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
	#####Apply the patch before running the script#####
	for l in "${BP[@]}"
	do
			filename="${l%%\(\)}"
		echo $filename
		# Get the line numbers of the start and end classes
		start=$(grep -n "^class $start_class" $file | cut -d: -f1)

		if [ -z "$start" ]; then
			echo "Class $start not found in file $file."
			exit 1
		fi
		line_num1=$(awk 'NR>='$start' && /'$keywords'/{print NR}' $file)
		if [[ ! -z "$line_num1" ]]; then
			sed -i "${line_num1}s/$keywords_sed/${l}/g" "$file"
			echo "Line $line_num1 modified"
		fi
		if true; then
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

			for t in {1..5}; do
			cd $ca_base/Project1_SPEC/$(eval echo \${BENCHMARKno${t}}) && sh $ca_base/Project1_SPEC/$(eval echo \${BENCHMARKno${t}})/runGem5.sh &
			done
		wait
		fi
		cd $ca_base
	done
