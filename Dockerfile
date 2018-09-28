ARG CPU_CORE=4
ARG KUI=205
FROM dockerhub.iis.sinica.edu.tw/siann1-hak8_boo5-hing5:${KUI}


MAINTAINER sih4sing5hong5
RUN apt-get install -y vim

RUN cp ../../swbd/s5c/local/run_asr_segmentation.sh local
RUN cp -r ../../swbd/s5c/local/segmentation local

RUN sed -i 's/lau spn/SPN/g' local/run_asr_segmentation.sh
RUN sed -i 's/"sil"/"SIL"/g' local/run_asr_segmentation.sh
ENV LANG zh_TW.UTF-8
ENV LANGUAGE zh_TW.UTF-8
ENV LANGUAGE zh_TW.UTF-8
RUN sed 's/\(open(.*\))/\1, encoding="utf-8")/g' -i  utils/data/internal/combine_segments_to_recording.py 
#ENV PYTHONIOENCODING utf-8
ARG CPU_CORE
RUN sed -i 's/ -le 7/ -eq 7/g' local/run_asr_segmentation.sh
RUN sed -i 's/ -le 8/ -eq 8/g' local/run_asr_segmentation.sh
RUN sed -i 's/ -le 9/ -eq 9/g' local/run_asr_segmentation.sh
RUN bash -x local/run_asr_segmentation.sh \
  --nj ${CPU_CORE} \
  --lang data/lang_train \
  --lang-test data/lang_train \
  --graph_dir exp/tri3/graph \
  --data_dir data/train

CMD bash -x local/run_asr_segmentation.sh \
  --stage 7 \
  --nj ${CPU_CORE} \
  --lang data/lang_train \
  --lang-test data/lang_train \
  --graph_dir exp/tri3/graph \
  --data_dir data/train


