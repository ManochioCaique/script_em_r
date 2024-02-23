#!/bin/bash


VARIAVEL1="bialleliconly_lwk bialleliconly_esn bialleliconly_yri bialleliconly_msl bialleliconly_gwd bialleliconly_acb bialleliconly_asw bialleliconly_clm bialleliconly_mxl bialleliconly_pur bialleliconly_pel bialleliconly_tsi bialleliconly_ibs bialleliconly_gbr bialleliconly_ceu bialleliconly_fin bialleliconly_pjl bialleliconly_gih bialleliconly_itu bialleliconly_stu bialleliconly_beb bialleliconly_cdx bialleliconly_khv bialleliconly_chs bialleliconly_chb bialleliconly_jpt"

VARIAVEL2=("onlymaf005_lwk" "onlymaf005_esn" "onlymaf005_yri" "onlymaf005_msl" "onlymaf005_gwd" "onlymaf005_acb" "onlymaf005_asw" "onlymaf005_clm" "onlymaf005_mxl" "onlymaf005_pur" "onlymaf005_pel" "maf005_tsi" "onlymaf005_ibs" "onlymaf005_gbr" "onlymaf005_ceu" "onlymaf005_fin" "onlymaf005_pjl" "onlymaf005_gih" "onlymaf005_itu" "onlymaf005_stu" "onlymaf005_beb" "onlymaf005_cdx" "onlymaf005_khv" "onlymaf005_chs" "onlymaf005_chb" "onlymaf005_jpt")



for i in $VARIAVEL1
do

 plink --bfile "$i" --maf 0.05 --threads 2 --make-bed --out "${VARIAVEL2[index]}"

 index=$((index+1))

done
