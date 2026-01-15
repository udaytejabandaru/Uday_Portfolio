#! /bin/bash
# Read the User arguments

declare -a my_array_1=(32kB 16kB 64kB 4 8 2 32)
declare -a my_array_2=(16kB 32kB 64kB 8 4 2 32)
declare -a my_array_3=(64kB 16kB 64kB 2 8 2 32)
declare -a my_array_4=(128kB 16kB 64kB 2 8 2 32)
declare -a my_array_5=(64kB 16kB 64kB 4 8 2 32)
declare -a my_array_6=(32kB 64kB 64kB 4 4 2 32)
declare -a my_array_7=(32kB 64kB 64kB 4 2 2 32)
declare -a my_array_8=(32kB 128kB 64kB 4 2 2 32)
declare -a my_array_9=(64kB 128kB 64kB 4 2 2 32)
declare -a my_array_10=(64kB 64kB 64kB 2 2 2 32)
declare -a my_array_11=(32kB 32kB 32kB 2 2 2 32)
declare -a my_array_12=(128kB 128kB 128kB 8 8 2 32)
declare -a my_array_13=(128kB 128kB 128kB 2 2 2 32)
declare -a my_array_14=(128kB 128kB 128kB 4 4 2 32)
declare -a my_array_15=(64kB 64kB 32kB 4 4 8 32)
declare -a my_array_16=(64kB 64kB 32kB 4 4 4 32)
declare -a my_array_17=(64kB 64kB 64kB 4 4 8 32)
declare -a my_array_18=(64kB 64kB 64kB 4 4 4 32)
declare -a my_array_19=(64kB 64kB 128kB 4 4 8 32)
declare -a my_array_20=(64kB 64kB 256kB 4 4 8 32)
declare -a my_array_21=(64kB 64kB 512kB 4 4 4 32)
declare -a my_array_22=(64kB 64kB 512kB 4 4 8 32)
declare -a my_array_23=(64kB 64kB 1MB 4 4 8 32)
declare -a my_array_24=(64kB 64kB 1MB 4 4 16 32)
declare -a my_array_25=(64kB 64kB 1MB 4 4 2 32)
declare -a my_array_26=(128kB 128kB 1MB 2 2 1 64)
declare -a my_array_27=(16kB 32kB 64kB 8 4 2 64)
declare -a my_array_28=(64kB 16kB 64kB 2 8 2 64)
declare -a my_array_29=(128kB 16kB 64kB 2 8 2 64)
declare -a my_array_30=(64kB 16kB 64kB 4 8 2 64)
declare -a my_array_31=(32kB 64kB 64kB 4 4 2 64)
declare -a my_array_32=(32kB 64kB 64kB 4 2 2 64)
declare -a my_array_33=(32kB 128kB 64kB 4 2 2 64)
declare -a my_array_34=(64kB 128kB 64kB 4 2 2 64)
declare -a my_array_35=(64kB 64kB 64kB 2 2 2 64)
declare -a my_array_36=(32kB 32kB 32kB 2 2 2 64)
declare -a my_array_37=(128kB 128kB 128kB 8 8 2 64)
declare -a my_array_38=(128kB 128kB 128kB 2 2 2 64)
declare -a my_array_39=(128kB 128kB 128kB 4 4 2 64)
declare -a my_array_40=(64kB 64kB 32kB 4 4 8 64)
declare -a my_array_41=(64kB 64kB 32kB 4 4 4 64)
declare -a my_array_42=(64kB 64kB 64kB 4 4 8 64)
declare -a my_array_43=(64kB 64kB 64kB 4 4 4 64)
declare -a my_array_44=(64kB 64kB 128kB 4 4 8 64)
declare -a my_array_45=(64kB 64kB 256kB 4 4 8 128)
declare -a my_array_46=(64kB 64kB 512kB 4 4 4 128)
declare -a my_array_47=(64kB 64kB 512kB 4 4 8 128)
declare -a my_array_48=(64kB 64kB 1MB 4 4 8 128)
declare -a my_array_49=(64kB 64kB 1MB 4 4 16 128)
declare -a my_array_50=(64kB 64kB 1MB 4 4 2 128)
declare -a my_array_51=(32kB 16kB 64kB 4 8 2 64)

BENCHMARKno1=401.bzip2
BENCHMARKno2=429.mcf
BENCHMARKno3=456.hmmer
BENCHMARKno4=458.sjeng	
BENCHMARKno5=470.lbm

ca_base=$(echo ~)/CA_proj
echo $ca_base
data=$ca_base/data
echo $data

#echo -e "****** DELETING OLD BUILD FILE   ******\n"
#cd $ca_base/gem5
#rm -rf ./build/X86
#echo -e "****** COMPILING THE SOURCE CODE ******\n"
#scons build/X86/gem5.opt -j 4 
cd $ca_base

echo "Benchmark1=$BENCHMARKno1,Benchmark2=$BENCHMARKno2, Benchmark3=$BENCHMARKno3, Benchmark4=$BENCHMARKno4, Benchmark5=$BENCHMARKno5"

for i in {1..51}; do
 declare -a temp_array

 nf_e=$(eval "echo \${#my_array_$i[@]}")
 echo $nf_e
 #Copy the contents of my_array into new_array
 for ((h=0; h<nf_e; h++)); do
  el=$(eval "echo \${my_array_${i}[$h]}")
  temp_array[$h]=$el
 done
 echo ${temp_array[*]}
	l1d=${temp_array[0]}
	l1i=${temp_array[1]}
	l2=${temp_array[2]}
	l1d_assoc=${temp_array[3]}
	l1i_assoc=${temp_array[4]}
	l2_assoc=${temp_array[5]}
	cs=${temp_array[6]}


	#echo -e "****** MAKING CHANGE IN THE SOURCE CODE ******\n"
  for q in {1..4}; do
  	 sed -i "s|time.*$|time \$GEM5_DIR/build/X86/gem5.opt -d ./m5out \$GEM5_DIR/configs/example/se.py -c \$BENCHMARK -o \$ARGUMENT -I 500000000 --cpu-type=TimingSimpleCPU --caches --l2cache --l1d_size=${l1d} --l1i_size=${l1i} --l2_size=${l2} --l1d_assoc=${l1d_assoc} --l1i_assoc=${l1i_assoc} --l2_assoc=${l2_assoc} --cacheline_size=${cs}|g" $ca_base/Project1_SPEC/$(eval echo \${BENCHMARKno${q}})/runGem5.sh
	   done

		sed -i "s|time.*$|time \$GEM5_DIR/build/X86/gem5.opt -d ./m5out \$GEM5_DIR/configs/example/se.py -c \$BENCHMARK -o \'19 reference.dat 0 1 $ca_base/Project1_SPEC/470.lbm/data/100_100_130_cf_a.of' -I 500000000 --cpu-type=TimingSimpleCPU --caches --l2cache --l1d_size=${l1d} --l1i_size=${l1i} --l2_size=${l2} --l1d_assoc=${l1d_assoc} --l1i_assoc=${l1i_assoc} --l2_assoc=${l2_assoc} --cacheline_size=${cs}|g" $ca_base/Project1_SPEC/470.lbm/runGem5.sh


  for t in {1..5}; do
		echo -e "****** RUNNING THE SCRIPT FILE FOR BM$t ******\n"
		cd $ca_base/Project1_SPEC/$(eval echo \${BENCHMARKno${t}}) 
		rm -rf m5out
		sh runGem5.sh
		cd $ca_base

	  echo -e "\n"
  done



echo -e "\n\n****** RUNNING THE OUPUT DATA *******\n" 

 echo -e "Results for Benchmarks with configuration ( $(eval "echo \${my_array_${i}[*]}") ) \n\n" >> $data/output_$i.txt 
  for z in {1..5}; do
		cd $ca_base/Project1_SPEC/$(eval echo \${BENCHMARKno${z}})/m5out
		echo -e "****** "$(eval echo \${BENCHMARKno${z}}) " \n" >> $data/output_$i.txt
		cat stats.txt | grep sim_insts >> $data/output_$i.txt
		cat stats.txt | grep system.cpu.dcache.overall_misses::total >> $data/output_$i.txt
		cat stats.txt | grep system.cpu.dcache.overall_accesses::total >> $data/output_$i.txt
		cat stats.txt | grep system.cpu.icache.overall_misses::total >> $data/output_$i.txt
		cat stats.txt | grep system.cpu.icache.overall_accesses::total >> $data/output_$i.txt
		cat stats.txt | grep system.l2.overall_misses::total >> $data/output_$i.txt
		cat stats.txt | grep system.l2.overall_accesses::total >> $data/output_$i.txt
  done

  echo -e "\n\n"

done


#source Uday.sh
