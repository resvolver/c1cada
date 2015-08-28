samp <- 8000 # sampling frequency
dura <- .125    # duration (1 s)
cf <- 440 # carrier frequecy (440 Hz, i.e. flat A tone)
notenames(c( 2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79 83,89,97,101,103,107,109))

s <- synth(f=f,d=d/8,cf=testers[[1]], signal="square",listen=TRUE,output="Wave")
th <- synth(f=f,d=d/8,cf=cf, signal="square",listen=TRUE,output="Wave")
l <- synth(f=f,d=d/8,cf=cf/2, signal="square",listen=TRUE,output="Wave")
n <- synth(f=f,d=d/8,cf=cf*2, signal="square",listen=TRUE,output="Wave")
testers <- notefreq(-7:21)
names(testers) <- gems$english[1:29]
f <- synth(f=samp,d=dura,cf=testers["f"], signal="square",listen=TRUE,output="Wave")
u <- synth(f=samp,d=dura,cf=testers["u"], signal="square",listen=TRUE,output="Wave")
th <- synth(f=samp,d=dura,cf=testers["th"], signal="square",listen=TRUE,output="Wave")
o <- synth(f=samp,d=dura,cf=testers["o"], signal="square",listen=TRUE,output="Wave")
r <- synth(f=samp,d=dura,cf=testers["r"], signal="square",listen=TRUE,output="Wave")
ck <- synth(f=samp,d=dura,cf=testers["ck"], signal="square",listen=TRUE,output="Wave")
g <- synth(f=samp,d=dura,cf=testers["g"], signal="square",listen=TRUE,output="Wave")
w <- synth(f=samp,d=dura,cf=testers["w"], signal="square",listen=TRUE,output="Wave")
h <- synth(f=samp,d=dura,cf=testers["h"], signal="square",listen=TRUE,output="Wave")
n <- synth(f=samp,d=dura,cf=testers["n"], signal="square",listen=TRUE,output="Wave")
i <- synth(f=samp,d=dura,cf=testers["i"], signal="square",listen=TRUE,output="Wave")
j <- synth(f=samp,d=dura,cf=testers["j"], signal="square",listen=TRUE,output="Wave")
eo <- synth(f=samp,d=dura,cf=testers["eo"], signal="square",listen=TRUE,output="Wave")
p <- synth(f=samp,d=dura,cf=testers["p"], signal="square",listen=TRUE,output="Wave")
x <- synth(f=samp,d=dura,cf=testers["x"], signal="square",listen=TRUE,output="Wave")
sz <- synth(f=samp,d=dura,cf=testers["sz"], signal="square",listen=TRUE,output="Wave")
t <- synth(f=samp,d=dura,cf=testers["t"], signal="square",listen=TRUE,output="Wave")
b <- synth(f=samp,d=dura,cf=testers["b"], signal="square",listen=TRUE,output="Wave")
e <- synth(f=samp,d=dura,cf=testers["e"], signal="square",listen=TRUE,output="Wave")
m <- synth(f=samp,d=dura,cf=testers["m"], signal="square",listen=TRUE,output="Wave")
l <- synth(f=samp,d=dura,cf=testers["l"], signal="square",listen=TRUE,output="Wave")
ing <- synth(f=samp,d=dura,cf=testers["ing"], signal="square",listen=TRUE,output="Wave")
oe <- synth(f=samp,d=dura,cf=testers["oe"], signal="square",listen=TRUE,output="Wave")
d <- synth(f=samp,d=dura,cf=testers["d"], signal="square",listen=TRUE,output="Wave")
a <- synth(f=samp,d=dura,cf=testers["a"], signal="square",listen=TRUE,output="Wave")
ae <- synth(f=samp,d=dura,cf=testers["ae"], signal="square",listen=TRUE,output="Wave")
y <- synth(f=samp,d=dura,cf=testers["y"], signal="square",listen=TRUE,output="Wave")
ia <- synth(f=samp,d=dura,cf=testers["ia"], signal="square",listen=TRUE,output="Wave")
ea <- synth(f=samp,d=dura,cf=testers["ea"], signal="square",listen=TRUE,output="Wave")


testa <- bind(get(an[[1]]),get(an[[2]]))
words_list <- all_dat_ass$word_c[unique(all_dat_ass$word_c)]
word_dat <- data.table()
for(i in 2:length(all_dat_ass$ttl_pos)){
  word_dat[i] <- word_dat[as.character(unique(all_dat_ass$word[which(all_dat_ass$word_c == words_list[i])])),unique(all_dat_ass$w_length[which(all_dat_ass$word_c == words_list[i])]),unique(all_dat_ass$w_pos[which(all_dat_ass$word_c == words_list[i])]),unique(all_dat_ass$page_n[which(all_dat_ass$word_c == words_list[i])])]
  
}
word_dat <- data.table(words_list[[i]],unique(all_dat_ass$word[which(all_dat_ass$word_c == words_list[[i]])]),