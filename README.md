# kaldi Installation Guide
This is a simple installation guide for how to install kaldi toolkit on Ubuntu 18.04.


**Note:** You may use [this script](install_kaldi.sh) to install Kaldi and compile it. The only thing you need is to install Openfst and SRILM library manually.


Start executing the following commands in the same order:

    sudo apt-get update
    sudo apt-get install g++ make automake autoconf sox libtool subversion python2.7
    sudo apt-get install make
    sudo apt install cmake

    sudo apt-get install git


    git clone https://github.com/kaldi-asr/kaldi.git

    cd kaldi/tools


    sudo apt-get install zlib1g-dev

    extras/install_mkl.sh


the output should be:

    extras/check_dependencies.sh: all OK.


 it means that ALL dependencies are all installed, otherwise, "extras/check_dependencies.sh" will output an error message corresponding to each dependency that is not found.
    you can find bash scripts ".sh" for missing dependencies in "extras" directory. Each time you install a dependency, you run "extras/check_dependencies.sh" to find the next missing dependency.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Run the following command to see the number of cores in your CPU:

    nproc


my output was:

    8


Since I want to compile the library using all of my CPU's cores, I ran the following command:

    make -j 8

You can choose the number of cores you want.



After that, go to the source code folder to compile it as follows:


    cd ../src

    ./configure


**IMPORTANT NOTE:** to compile Kaldi to work with GPUs, do the following:

    ./configure --use-cuda --cudatk-dir=/usr/local/cuda/ --cuda-arch=-arch=sm_70


After that, run these two commands to compile the source code


    make depend -j 8

    make -j 8



After that run the following:

    cd ../tools

    extras/install_irstlm.sh


Source:
http://jrmeyer.github.io/asr/2016/01/26/Installing-Kaldi.html


------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Donwload SRILM from this page

http://www.speech.sri.com/projects/srilm/download.html

I downloaded version 1.7.2 since it is the last version currently while I'm writing this tutorial.

    sudo mkdir /usr/share/srilm
    sudo mv srilm-1.7.2.tar.gz /usr/share/srilm
    cd /usr/share/srilm/
    sudo tar xzf srilm-1.7.2.tar.gz
    sudo apt install tcsh


Open the following file:

    sudo nano Makefile


and uncomment the following line by removing the # character:

    # SRILM = /home/speech/stolcke/project/srilm/devel

it will be like this:

    SRILM = /home/speech/stolcke/project/srilm/devel

and we have to change the path that this variable is pointing to. Since the SRILM root folder is  /usr/share/srilm/

Hence, change the variable value to be the following

    SRILM = /usr/share/srilm/


On your keyboard, press "CTRL + X" to save the file, then "Y" to confirm that you want to exit the file, and finally press "Enter" to overwrite the file "Makefile"


    sudo make MACHINE_TYPE=i686-m64 World


I chose "i686-m64" since my machine is running Ubuntu 18.04 64-bit version. For more information, check INSTALL file.
You can follow INSTALL file in "srilm" for the rest of the installation steps of srilm library.

After you finish srilm library, you need to add it to environment paths.
Open the ".bashrc" file as follows:

    nano ~/.bashrc


Add the following line at the end of the file:

    export PATH="/usr/share/srilm/bin/i686-m64:$PATH"


On your keyboard, press "CTRL + X" to save the file, then "Y" to confirm that you want to exit the file, and finally press "Enter" to overwrite the file ".bashrc"


Source:

INSTALL file within the library folder

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Download Openfst library:

www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.7.2.tar.gz

I downloaded the version 1.7.2

change directory to the extracted folder then do the following:


    ./configure

    make

Source:

INSTALL file within the library folder


------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Download Anaconda:
https://www.anaconda.com/distribution/#download-section

After you download it, you must change the file permissions as follows:



    chmod 777 Anaconda3-2019.03-Linux-x86_64.sh
    ./Anaconda3-2019.03-Linux-x86_64.sh


------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# Training Kaldi on Arabic LDC Dataset

Go to "egs" folder inside the "kaldi" folder then go to "gale_arabic" recipe.

You have to edit the files    "kaldi/egs/gale_arabic/s5b/local/prepare_data.sh"    and     "kaldi/egs/gale_arabic/s5b/run.sh"


by replacing the path of the data


    dir1=/export/corpora/LDC/LDC2013S02/

    dir2=/export/corpora/LDC/LDC2013S07/

    dir3=/export/corpora/LDC/LDC2014S07/

    text1=/export/corpora/LDC/LDC2013T17/

    text2=/export/corpora/LDC/LDC2013T04/

    text3=/export/corpora/LDC/LDC2014T17/


to your own data path


    dir1=/home/farisalasmary/Desktop/LDC_Speech_Dataset/LDC2013S02/

    dir2=/home/farisalasmary/Desktop/LDC_Speech_Dataset/LDC2013S07/

    dir3=/home/farisalasmary/Desktop/LDC_Speech_Dataset/LDC2014S07/

    text1=/home/farisalasmary/Desktop/LDC_Speech_Dataset/LDC2013T17/

    text2=/home/farisalasmary/Desktop/LDC_Speech_Dataset/LDC2013T04/

    text3=/home/farisalasmary/Desktop/LDC_Speech_Dataset/LDC2014T17/


After that,make sure that you replace the following lines in  "kaldi/egs/gale_arabic/s5b/local/cmd.sh" file:


    export train_cmd="retry.pl queue.pl --mem 2G"
    export decode_cmd="retry.pl queue.pl--mem 4G"
    export mkgraph_cmd="retry.pl queue.pl --mem 8G"


with these lines


    export train_cmd="retry.pl run.pl --mem 2G"
    export decode_cmd="retry.pl run.pl --mem 4G"
    export mkgraph_cmd="retry.pl run.pl --mem 8G"


Finally, you run the "run.sh" script and it will work -In Sha Allah-


**NOTE:**  you may need to remove the "data" folder in "s5b" folder

    (base) farisalasmary@farisalasmary:~/kaldi/egs/gale_arabic/s5b$ rm -r data/



________________________________________________________________________________________________________________________________________________________________
## Common Errors and Their Solutions

This section will be updated frequently -In Sha Allah- after each encountered error.

Since we are currently working on Ubuntu 18.04, those errors may occur again after retraining.


#### 1- Error #1

you may encounter this error:

    LOG (copy-transition-model[5.5.313~1-203c]:main():copy-transition-model.cc:62) Copied transition model.
    2019-04-30 21:31:19,610 [steps/nnet3/chain/train.py:339 - train - INFO ] Initializing a basic network for estimating preconditioning matrix
    2019-04-30 21:31:19,683 [steps/nnet3/chain/train.py:361 - train - INFO ] Generating egs
    steps/nnet3/chain/get_egs.sh --frames-overlap-per-eg 0 --constrained false --cmd retry.pl run.pl --mem 4G --cmvn-opts --norm-means=false --norm-vars=false --online-ivector-dir exp/nnet3/ivectors_train_sp_
    hires --left-context 35 --right-context 35 --left-context-initial -1 --right-context-final -1 --left-tolerance 5 --right-tolerance 5 --frame-subsampling-factor 3 --alignment-subsampling-factor 3 --stage -
    10 --frames-per-iter 1500000 --frames-per-eg 150,110,100 --srand 0 data/train_sp_hires exp/chain/tdnn_1a_sp exp/chain/tri3b_train_sp_lats exp/chain/tdnn_1a_sp/egs
    feat-to-len 'scp:head -n 10 data/train_sp_hires/feats.scp|' ark,t:-
    steps/nnet3/chain/get_egs.sh: File data/train_sp_hires/utt2uniq exists, so ensuring the hold-out set includes all perturbed versions of the same source utterance.
    steps/nnet3/chain/get_egs.sh: Number of utterances is very small. Please check your data.
    Traceback (most recent call last):
      File "steps/nnet3/chain/train.py", line 624, in main
        train(args, run_opts)
      File "steps/nnet3/chain/train.py", line 387, in train
        stage=args.egs_stage)
      File "steps/libs/nnet3/train/chain_objf/acoustic_model.py", line 118, in generate_chain_egs
       egs_opts=egs_opts if egs_opts is not None else ''))
      File "steps/libs/common.py", line 158, in execute_command
        p.returncode, command))
    Exception: Command exited with status 1: steps/nnet3/chain/get_egs.sh --frames-overlap-per-eg 0 --constrained false                 --cmd "retry.pl run.pl --mem 4G"                 --cmvn-opts "--norm-mea
    ns=false --norm-vars=false"                 --online-ivector-dir "exp/nnet3/ivectors_train_sp_hires"                 --left-context 35                 --right-context 35                 --left-context-ini
    tial -1                 --right-context-final -1                 --left-tolerance '5'                 --right-tolerance '5'                 --frame-subsampling-factor 3                 --alignment-subsamp
    ling-factor 3                 --stage -10                 --frames-per-iter 1500000                 --frames-per-eg 150,110,100                 --srand 0                 data/train_sp_hires exp/chain/tdnn
    _1a_sp exp/chain/tri3b_train_sp_lats exp/chain/tdnn_1a_sp/egs


**Solution:**

This error most probably is caused by the command "nextfile" in the "awk" command inside the file "get_egs.sh" in line 160.

    awk -v max_utt=$num_utts_subset '{

            for (n=2;n<=NF;n++) print $n;

            printed += NF-1;

            if (printed >= max_utt) nextfile; }' |

        sort > $dir/valid_uttlist

This is the path:

    kaldi/egs/gale_arabic/s5b/steps/nnet3/chain/get_egs.sh

This error occur since the "awk" command does not support the command "nextfile". So, we have o install "gawk" and use it instead.

    sudo apt install gawk


Then replace the previous command "awk" with the new one "gawk" as follows:


    gawk -v max_utt=$num_utts_subset '{

            for (n=2;n<=NF;n++) print $n;

            printed += NF-1;

            if (printed >= max_utt) nextfile; }' |

        sort > $dir/valid_uttlist


-------------------------------------------------------------------------


#### 2- Error #2

    steps/nnet3/chain/get_egs.sh: Finished preparing training examples
    2019-05-01 17:02:25,683 [steps/nnet3/chain/train.py:410 - train - INFO ] Copying the properties from exp/chain/tdnn_1a_sp/egs to exp/chain/tdnn_1a_sp
    2019-05-01 17:02:25,695 [steps/nnet3/chain/train.py:424 - train - INFO ] Computing the preconditioning matrix for input features
    2019-05-01 17:02:57,590 [steps/nnet3/chain/train.py:433 - train - INFO ] Preparing the initial acoustic model.
    2019-05-01 17:02:58,897 [steps/nnet3/chain/train.py:467 - train - INFO ] Training will run for 6.0 epochs = 441 iterations
    2019-05-01 17:02:58,991 [steps/nnet3/chain/train.py:509 - train - INFO ] Iter: 0/440    Epoch: 0.00/6.0 (0.0% complete)    lr: 0.000750    
    run.pl: job failed, log is in exp/chain/tdnn_1a_sp/log/train.0.1.log
    /home/analytics/kaldi/egs/gale_arabic/s5b/utils//retry.pl: job failed; renaming log file to exp/chain/tdnn_1a_sp/log/train.0.1.log.bak and rerunning
    run.pl: job failed, log is in exp/chain/tdnn_1a_sp/log/train.0.2.log
    /home/analytics/kaldi/egs/gale_arabic/s5b/utils//retry.pl: job failed; renaming log file to exp/chain/tdnn_1a_sp/log/train.0.2.log.bak and rerunning
    run.pl: job failed, log is in exp/chain/tdnn_1a_sp/log/train.0.3.log
    /home/analytics/kaldi/egs/gale_arabic/s5b/utils//retry.pl: job failed; renaming log file to exp/chain/tdnn_1a_sp/log/train.0.3.log.bak and rerunning
    run.pl: job failed, log is in exp/chain/tdnn_1a_sp/log/train.0.2.log
    /home/analytics/kaldi/egs/gale_arabic/s5b/utils//retry.pl: job failed 2 times; log is in exp/chain/tdnn_1a_sp/log/train.0.2.log
    2019-05-01 17:03:08,157 [steps/libs/common.py:236 - background_command_waiter - ERROR ] Command exited with status 1: retry.pl run.pl --mem 4G --gpu 1 exp/chain/tdnn_1a_sp/log/train.0.2.log                     nnet3-chain-train --use-gpu=yes                      --apply-deriv-weights=False                     --l2-regularize=0.0 --leaky-hmm-coefficient=0.1                       --xent-regularize=0.1                                          --print-interval=10 --momentum=0.0                     --max-param-change=1.414213562373095                     --backstitch-training-scale=0.0                     --backstitch-training-interval=1                     --l2-regularize-factor=0.3333333333333333 --optimization.memory-compression-level=2                     --srand=0                     "nnet3-am-copy --raw=true --learning-rate=0.00075 --scale=1.0 exp/chain/tdnn_1a_sp/0.mdl - |nnet3-copy --edits='set-dropout-proportion name=* proportion=0.0' - - |" exp/chain/tdnn_1a_sp/den.fst                     "ark,bg:nnet3-chain-copy-egs                          --frame-shift=2                         ark:exp/chain/tdnn_1a_sp/egs/cegs.2.ark ark:- |                         nnet3-chain-shuffle-egs --buffer-size=5000                         --srand=0 ark:- ark:- | nnet3-chain-merge-egs                         --minibatch-size=32,16 ark:- ark:- |"                     exp/chain/tdnn_1a_sp/1.2.raw
    run.pl: job failed, log is in exp/chain/tdnn_1a_sp/log/train.0.3.log
    /home/analytics/kaldi/egs/gale_arabic/s5b/utils//retry.pl: job failed 2 times; log is in exp/chain/tdnn_1a_sp/log/train.0.3.log
    2019-05-01 17:03:08,183 [steps/libs/common.py:236 - background_command_waiter - ERROR ] Command exited with status 1: retry.pl run.pl --mem 4G --gpu 1 exp/chain/tdnn_1a_sp/log/train.0.3.log                     nnet3-chain-train --use-gpu=yes                      --apply-deriv-weights=False                     --l2-regularize=0.0 --leaky-hmm-coefficient=0.1                       --xent-regularize=0.1                                          --print-interval=10 --momentum=0.0                     --max-param-change=1.414213562373095                     --backstitch-training-scale=0.0                     --backstitch-training-interval=1                     --l2-regularize-factor=0.3333333333333333 --optimization.memory-compression-level=2                     --srand=0                     "nnet3-am-copy --raw=true --learning-rate=0.00075 --scale=1.0 exp/chain/tdnn_1a_sp/0.mdl - |nnet3-copy --edits='set-dropout-proportion name=* proportion=0.0' - - |" exp/chain/tdnn_1a_sp/den.fst                     "ark,bg:nnet3-chain-copy-egs                          --frame-shift=0                         ark:exp/chain/tdnn_1a_sp/egs/cegs.3.ark ark:- |                         nnet3-chain-shuffle-egs --buffer-size=5000                         --srand=0 ark:- ark:- | nnet3-chain-merge-egs                         --minibatch-size=32,16 ark:- ark:- |"                     exp/chain/tdnn_1a_sp/1.3.raw
    run.pl: job failed, log is in exp/chain/tdnn_1a_sp/log/train.0.1.log
    /home/analytics/kaldi/egs/gale_arabic/s5b/utils//retry.pl: job failed 2 times; log is in exp/chain/tdnn_1a_sp/log/train.0.1.log
    2019-05-01 17:03:08,293 [steps/libs/common.py:236 - background_command_waiter - ERROR ] Command exited with status 1: retry.pl run.pl --mem 4G --gpu 1 exp/chain/tdnn_1a_sp/log/train.0.1.log                     nnet3-chain-train --use-gpu=yes                      --apply-deriv-weights=False                     --l2-regularize=0.0 --leaky-hmm-coefficient=0.1                      --write-cache=exp/chain/tdnn_1a_sp/cache.1  --xent-regularize=0.1                                          --print-interval=10 --momentum=0.0                     --max-param-change=1.414213562373095                     --backstitch-training-scale=0.0                     --backstitch-training-interval=1                     --l2-regularize-factor=0.3333333333333333 --optimization.memory-compression-level=2                     --srand=0                     "nnet3-am-copy --raw=true --learning-rate=0.00075 --scale=1.0 exp/chain/tdnn_1a_sp/0.mdl - |nnet3-copy --edits='set-dropout-proportion name=* proportion=0.0' - - |" exp/chain/tdnn_1a_sp/den.fst                     "ark,bg:nnet3-chain-copy-egs                          --frame-shift=1                         ark:exp/chain/tdnn_1a_sp/egs/cegs.1.ark ark:- |                         nnet3-chain-shuffle-egs --buffer-size=5000                         --srand=0 ark:- ark:- | nnet3-chain-merge-egs                         --minibatch-size=32,16 ark:- ark:- |"                     exp/chain/tdnn_1a_sp/1.1.raw



**Solution:**

Checkout your GPU architecture in this link:

https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/

Since our GPU is Nvidia GTX 1080 Ti, configure and re-compile kaldi with architecture "sm_61"

        ./configure --use-cuda --cudatk-dir=/usr/local/cuda/ --cuda-arch=-arch=sm_61


#### 3- Error #3

    LOG (nnet3-chain-train[5.5.313~1-203c]:AllocateNewRegion():cu-allocator.cc:506) About to allocate new memory region of 164626432 bytes; current memory info is: free:313M, used:10862M, total:11175M, free/total:0.0280524
    LOG (nnet3-chain-train[5.5.313~1-203c]:AllocateNewRegion():cu-allocator.cc:506) About to allocate new memory region of 83886080 bytes; current memory info is: free:155M, used:11020M, total:11175M, free/total:0.0139144
    LOG (nnet3-chain-train[5.5.313~1-203c]:AllocateNewRegion():cu-allocator.cc:506) About to allocate new memory region of 42991616 bytes; current memory info is: free:75M, used:11100M, total:11175M, free/total:0.00675585
    LOG (nnet3-chain-train[5.5.313~1-203c]:AllocateNewRegion():cu-allocator.cc:506) About to allocate new memory region of 17825792 bytes; current memory info is: free:33M, used:11142M, total:11175M, free/total:0.00299763
    LOG (nnet3-chain-train[5.5.313~1-203c]:AllocateNewRegion():cu-allocator.cc:506) About to allocate new memory region of 82837504 bytes; current memory info is: free:15M, used:11160M, total:11175M, free/total:0.00138696
    LOG (nnet3-chain-train[5.5.313~1-203c]:PrintMemoryUsage():cu-allocator.cc:368) Memory usage: 591856896/639631360 bytes currently allocated/total-held; 587/7 blocks currently allocated/free; largest free/allocated block sizes are 83886080/17760256; time taken total/cudaMalloc is 0.00290585/0.00194597, synchronized the GPU 0 times out of 12 frees; device memory info: free:15M, used:11160M, total:11175M, free/total:0.00138696maximum allocated: 602227968current allocated: 591856896
    ERROR (nnet3-chain-train[5.5.313~1-203c]:AllocateNewRegion():cu-allocator.cc:519) Failed to allocate a memory region of 82837504 bytes.  Possibly this is due to sharing the GPU.  Try switching the GPUs to exclusive mode (nvidia-smi -c 3) and using the option --use-gpu=wait to scripts like steps/nnet3/chain/train.py.  Memory info: free:15M, used:11160M, total:11175M, free/total:0.00



**Solution:**

As it is written in the error,  Set the GPU to the EXCLUSIVE mode as follows:

        sudo nvidia-smi -c 3


After that, edit the following file:

    /home/analytics/kaldi/egs/gale_arabic/s5b/local/chain/run_tdnn.sh


and go to this section:

      steps/nnet3/chain/train.py --stage $train_stage \

        --cmd "$decode_cmd" \

        --feat.online-ivector-dir $train_ivector_dir \

        --feat.cmvn-opts "--norm-means=false --norm-vars=false" \

        --chain.xent-regularize $xent_regularize \

        --chain.leaky-hmm-coefficient 0.1 \

        --chain.l2-regularize 0.0 \

        --chain.apply-deriv-weights false \

        --chain.lm-opts="--num-extra-lm-states=2000" \

        --trainer.dropout-schedule $dropout_schedule \

        --trainer.srand=$srand \

        --trainer.max-param-change=2.0 \

        --trainer.num-epochs 6 \

        --trainer.frames-per-iter 1500000 \

        --trainer.optimization.num-jobs-initial 3 \

        --trainer.optimization.num-jobs-final 16 \

        --trainer.optimization.initial-effective-lrate 0.00025 \

        --trainer.optimization.final-effective-lrate 0.000025 \

        --trainer.num-chunk-per-minibatch=64,32 \

        --trainer.add-option="--optimization.memory-compression-level=2" \

        --egs.chunk-width=$chunk_width \

        --egs.dir="$common_egs_dir" \

        --egs.opts "--frames-overlap-per-eg 0 --constrained false" \

        --egs.stage $get_egs_stage \

        --reporting.email="$reporting_email" \

        --cleanup.remove-egs=$remove_egs \

        --feat-dir=$train_data_dir \

        --tree-dir $tree_dir \

        --lat-dir=$lat_dir \

        --dir $dir  || exit 1;


add the following line  **--use-gpu=wait \\** as an argument to the script steps/nnet3/chain/train.py


      steps/nnet3/chain/train.py --stage $train_stage \

        --cmd "$decode_cmd" \

        --use-gpu=wait \

        --feat.online-ivector-dir $train_ivector_dir \

        --feat.cmvn-opts "--norm-means=false --norm-vars=false" \

        --chain.xent-regularize $xent_regularize \

        --chain.leaky-hmm-coefficient 0.1 \

        --chain.l2-regularize 0.0 \

        --chain.apply-deriv-weights false \

        --chain.lm-opts="--num-extra-lm-states=2000" \

        --trainer.dropout-schedule $dropout_schedule \

        --trainer.srand=$srand \

        --trainer.max-param-change=2.0 \

        --trainer.num-epochs 6 \

        --trainer.frames-per-iter 1500000 \

        --trainer.optimization.num-jobs-initial 3 \

        --trainer.optimization.num-jobs-final 16 \

        --trainer.optimization.initial-effective-lrate 0.00025 \

        --trainer.optimization.final-effective-lrate 0.000025 \

        --trainer.num-chunk-per-minibatch=64,32 \

        --trainer.add-option="--optimization.memory-compression-level=2" \

        --egs.chunk-width=$chunk_width \

        --egs.dir="$common_egs_dir" \

        --egs.opts "--frames-overlap-per-eg 0 --constrained false" \

        --egs.stage $get_egs_stage \

        --reporting.email="$reporting_email" \

        --cleanup.remove-egs=$remove_egs \

        --feat-dir=$train_data_dir \

        --tree-dir $tree_dir \

        --lat-dir=$lat_dir \

        --dir $dir  || exit 1;











------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Useful Resources:

Kaldi Installation Tutorial:
http://jrmeyer.github.io/asr/2016/01/26/Installing-Kaldi.html

Arabic Speech Recognition Article:
https://medium.com/@omar.merghany95/how-we-built-arabic-speech-recognition-system-using-kaldi-a10a54678180

The dataset used in the article above
http://www.mgb-challenge.org/arabic_download.html

An Excellent Kaldi Tutorial
https://www.eleanorchodroff.com/tutorial/kaldi/overview.html

GPU Architectures
https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/





