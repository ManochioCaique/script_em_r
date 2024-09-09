VARIAVEL1=("rs_lwk" "rs_esn" "rs_yri" "rs_msl" "rs_gwd" "rs_acb" "rs_asw" "rs_clm" "rs_mxl" "rs_pur" "rs_pel" "rs_tsi" "rs_ibs" "rs_gbr" "rs_ceu" "rs_fin" "rs_pjl" "rs_gih" "rs_itu" "rs_stu" "rs_beb" "rs_cdx" "rs_khv" "rs_chs" "rs_chb" "rs_jpt")

VARIAVEL2=("arquivo_ld_lwk" "arquivo_ld_esn" "arquivo_ld_yri" "arquivo_ld_msl" "arquivo_ld_gwd" "arquivo_ld_acb" "arquivo_ld_asw" "arquivo_ld_clm" "arquivo_ld_mxl" "arquivo_ld_pur" "arquivo_ld_pel" "arquivo_ld_tsi" "arquivo_ld_ibs" "arquivo_ld_gbr" "arquivo_ld_ceu" "arquivo_ld_fin" "arquivo_ld_pjl" "arquivo_ld_gih" "arquivo_ld_itu" "arquivo_ld_stu" "arquivo_ld_beb" "arquivo_ld_cdx" "arquivo_ld_khv" "arquivo_ld_chs" "arquivo_ld_chb" "arquivo_ld_jpt")

for ((i = 0; i < ${#VARIAVEL1[@]}; i++))
do
plink --bfile "${VARIAVEL1[i]}" --ld rs56038477 rs75017182 > "${VARIAVEL2[i]}.txt"

done
