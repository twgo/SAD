ARG CPU_CORE=4
ARG KUI=205
FROM dockerhub.iis.sinica.edu.tw/siann1-hak8_boo5-hing5:${KUI}


MAINTAINER sih4sing5hong5

RUN bash -x local/run_asr_segmentation.sh \
  --lang data/lang_train \
  --lang-test data/lang_train \
  --data_dir data/train


