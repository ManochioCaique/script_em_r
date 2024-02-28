
VARIAVEL1=("onlymaf005_lwk" "onlymaf005_esn" "onlymaf005_yri" "onlymaf005_msl" "onlymaf005_gwd" "onlymaf005_acb" "onlymaf005_asw" "onlymaf005_clm" "onlymaf005_mxl" "onlymaf005_pur" "onlymaf005_pel" "onlymaf005_tsi" "onlymaf005_ibs" "onlymaf005_gbr" "onlymaf005_ceu" "onlymaf005_fin" "onlymaf005_pjl" "onlymaf005_gih" "onlymaf005_itu" "onlymaf005_stu" "onlymaf005_beb" "onlymaf005_cdx" "onlymaf005_khv" "onlymaf005_chs" "onlymaf005_chb" "onlymaf005_jpt")

VARIAVEL2=("arquivo_ld_lwk" "arquivo_ld_esn" "arquivo_ld_yri" "arquivo_ld_msl" "arquivo_ld_gwd" "arquivo_ld_acb" "arquivo_ld_asw" "arquivo_ld_clm" "arquivo_ld_mxl" "arquivo_ld_pur" "arquivo_ld_pel" "arquivo_ld_tsi" "arquivo_ld_ibs" "arquivo_ld_gbr" "arquivo_ld_ceu" "arquivo_ld_fin" "arquivo_ld_pjl" "arquivo_ld_gih" "arquivo_ld_itu" "arquivo_ld_stu" "arquivo_ld_beb" "arquivo_ld_cdx" "arquivo_ld_khv" "arquivo_ld_chs" "arquivo_ld_chb" "arquivo_ld_jpt")

for ((i = 0; i < ${#VARIAVEL1[@]}; i++))
do
    plink --bfile "${VARIAVEL1[i]}" --r2 --ld-window-kb 2000 --threads 3 --out "${VARIAVEL2[i]}_temp"

    awk '$7 < 0.8 {print $3}' "${VARIAVEL2[i]}_temp.ld" > "${VARIAVEL2[i]}_3_1.txt"
    
    awk '$7 < 0.8 {print $6}' "${VARIAVEL2[i]}_temp.ld" > "${VARIAVEL2[i]}_3_2.txt"
    
    awk '1' "${VARIAVEL2[i]}_3_1.txt" "${VARIAVEL2[i]}_3_2.txt" > "${VARIAVEL2[i]}_4t.txt"
    
    awk '!seen[$0]++' "${VARIAVEL2[i]}_4.txt" > "${VARIAVEL2[i]}_5.txt"
    
    plink --bfile "${VARIAVEL1[i]}" --extract "${VARIAVEL2[i]}_5.txt" --make-bed --threads 2 --out "${VARIAVEL2[i]}_filtered"
done
