lfic=`ls $1*`
echo "float_sn;cycle;parameter;value;unit" > "../tech_dot_profile_"$1".csv" 
for fic in $lfic; do echo $fic; sed -e 's/\%/\% /g' $fic > $fic".tmp";  awk 'BEGIN{i_printline=0;}{split(FILENAME,name,"_");split(name[3],cycle,".");if ($1 ~ "PROFILE_TECHNICAL_DATA"){i_printline=1;getline;};if(NF<2){i_printline=0};if(i_printline==1){print name[1]"_"name[2],cycle[1],$0}}'  $fic".tmp" | sed -e 's/\.profile / /g' | sed -e 's/-xmit/xmit/g' | awk 'BEGIN{OFS=";"}{print $1,$2,$3,$4,$6}' | grep -v "TECH;DATA" >> "../tech_dot_profile_"$1".csv" ; rm $fic".tmp" ; done



echo "list of fields encountered in .profile:"
awk -F";" '{print $3}' "../tech_dot_profile_"$1".csv" | sort -u
