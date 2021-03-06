if(basename(getwd()) != "dfr-analysis") {
    stop("Please run tests from the dfr-analysis root directory.")
}

random_seed <- 42

source("topics_rmallet.R")
topics_rmallet_setup()

test <- model_documents(citations.file="test_data/pmla_sample/citations.CSV",
                        dirs="test_data/pmla_sample/wordcounts",
                        stoplist.file="stoplist/mallet-2.0.7-en.txt",
                        num.topics=10,
                        seed=random_seed)

stopifnot(paste(test$wkf$word[1:20],collapse=" ") == "social james political queer cultural economic class credit imagination market culture leiris figure theory american statue white hyacinth made princess")

stopifnot(paste(test$wkf$weight[51:70],collapse=" ") == "155 137 127 114 98 95 93 92 88 87 86 77 77 73 66 64 63 61 60 58")

stopifnot(paste(test$doc_topics$id,collapse=" ") == "10.2307/1261213 10.2307/1261433 10.2307/1261475 10.2307/1261535 10.2307/25486064 10.2307/25486344 10.2307/25501708 10.2307/25501729 10.2307/2699125 10.2307/2699171 10.2307/2699218 10.2307/2699313 10.2307/456199 10.2307/456229 10.2307/456372 10.2307/456498 10.2307/456509 10.2307/456610 10.2307/456662 10.2307/456715 10.2307/456898 10.2307/457003 10.2307/457015 10.2307/457153 10.2307/457386 10.2307/457488 10.2307/457493 10.2307/457667 10.2307/457688 10.2307/458141 10.2307/458152 10.2307/458184 10.2307/458190 10.2307/458233 10.2307/458267 10.2307/458311 10.2307/458317 10.2307/458325 10.2307/458418 10.2307/458863 10.2307/458936 10.2307/459025 10.2307/459047 10.2307/459121 10.2307/459122 10.2307/459134 10.2307/459159 10.2307/459167 10.2307/459293 10.2307/459359 10.2307/459383 10.2307/459402 10.2307/459481 10.2307/459547 10.2307/459681 10.2307/459720 10.2307/459796 10.2307/459923 10.2307/459935 10.2307/460141 10.2307/460195 10.2307/460226 10.2307/460572 10.2307/460772 10.2307/460818 10.2307/460933 10.2307/461014 10.2307/461045 10.2307/461199 10.2307/461310 10.2307/461329 10.2307/461369 10.2307/461461 10.2307/461476 10.2307/461484 10.2307/461547 10.2307/461682 10.2307/462116 10.2307/462163 10.2307/462167 10.2307/462241 10.2307/462321 10.2307/462452 10.2307/462511 10.2307/462624 10.2307/462715 10.2307/462758 10.2307/462843 10.2307/462859 10.2307/462920 10.2307/462930 10.2307/462987 10.2307/463019 10.2307/463092 10.2307/463117 10.2307/463170 10.2307/463230 10.2307/463462 10.2307/823151 10.2307/823154")

stopifnot(paste(unlist(test$doc_topics[3:5,1:10]),collapse=" ") == "8 353 99 5 34 1329 34 0 0 432 45 83 9 0 0 0 0 92 36 87 339 0 18 140 0 0 0 0 0 3")


message("model check: ok")

message("saving files")
out_files = c(
    "test_out/topic_words.csv",
    "test_out/vocab.txt",
    "test_out/params.csv",
    "test_out/keys.csv",
    "test_out/mallet_state.gz",
    "test_out/diagnostics.xml",
    "test_out/instances.mallet",
    "test_out/topic_scaled.csv")
for (f in out_files) {
    if (file.exists(f)) {
        unlink(f)
    }
}
output_model(test,"test_out",save_instances=T,save_scaled=T)

for (f in out_files) {
    message("Checking for ",f,"...",appendLF=F)
    stopifnot(file.exists(f))
    message("ok")
}


# TODO check md5 hashes
message("file-writing check: ok")
