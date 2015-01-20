#! /bin/bash

cat ../translation/transcriptions/[012].txt                                                   > page.0-2.txt
cat ../translation/transcriptions/[34567].txt                                                 > page.3-7.txt
cat ../translation/transcriptions/[89].txt ../translation/transcriptions/1[01234].txt         > page.8-14.txt
cat ../translation/transcriptions/1[56789].txt ../translation/transcriptions/2[012].txt       > page.15-22.txt
cat ../translation/transcriptions/2[3456].txt                                                 > page.23-26.txt
cat ../translation/transcriptions/2[3456].txt ../translation/transcriptions/3[012].txt        > page.27-32.txt
cat ../translation/transcriptions/3[3456789].txt                                              > page.33-39.txt
cat ../translation/transcriptions/4[0123456789].txt ../translation/transcriptions/5[0123].txt > page.40-53.txt
cat ../translation/transcriptions/5[45].txt                                                   > page.54-55.txt
cat ../translation/transcriptions/56.txt                                                      > page.56.txt
cat ../translation/transcriptions/57.txt                                                      > page.57.txt

