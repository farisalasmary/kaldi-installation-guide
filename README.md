# kaldi-installation-guide
a simple installation guide for how to install kaldi toolkit on Ubuntu 18.04

Start executing the following commands in the same order:

```bash
sudo apt-get update
sudo apt-get install g++ make automake autoconf sox libtool subversion python2.7
sudo apt-get install make
sudo apt install cmake

sudo apt-get install git


git clone https://github.com/kaldi-asr/kaldi.git

cd kaldi/tools


sudo apt-get install zlib1g-dev

extras/install_mkl.sh
```

the output should be:

    extras/check_dependencies.sh: all OK.


    it means that ALL dependencies are all installed, otherwise, "extras/check_dependencies.sh" will output an error message corresponding to each dependency that is not found.
    you can find bash scripts ".sh" for missing dependencies in "extras" directory. Each time you install a dependency, you run "extras/check_dependencies.sh" to find the next missing dependency.

    The following
    -----------------------------------------------------------------------------------------------------------
    ** extras directory **
    -----------------------------------------------------------------------------------------------------------
    (base) farisalasmary@farisalasmary:~/kaldi/tools$ ls extras/
    check_dependencies.sh    install_ffv.sh            install_miniconda.sh  install_openblas.sh       install_sctk_patched.sh   install_wpe.sh       sequitur.patch
    check_for_rnnlm.sh       install_irstlm.sh         install_mkl.sh        install_pfile_utils.sh    install_sequitur.sh       irstlm.patch         srilm.patch
    install_beamformit.sh    install_jieba.sh          install_mmseg.sh      install_phonetisaurus.sh  install_speex.sh          mikolov_rnnlm.patch  travis_install_bindeps.sh
    install_cffi.sh          install_kaldi_lm.sh       install_morfessor.sh  install_pocolm.sh         install_srilm.sh          portaudio.patch      travis_script.sh
    install_chainer.sh       install_liblbfgs.sh       install_mpg123.sh     install_portaudio.sh      install_tensorflow_cc.sh  pthread-2.9.1.patch  travis_show_failures.sh
    install_faster_rnnlm.sh  install_mikolov_rnnlm.sh  install_nkf.sh        install_sacc.sh           install_tensorflow_py.sh  README.txt
    (base) farisalasmary@farisalasmary:~/kaldi/tools$
    -----------------------------------------------------------------------------------------------------------


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


IMPORTANT NOTE: to compile Kaldi to work with GPUs, do the following:

    ./configure --use-cuda --cudatk-dir=/usr/local/cuda/ --cuda-arch=-arch=sm_70


After that, run these two commands to compile the source code


    make depend -j 8

    make -j 8



After that run the following:

    cd ../tools

    extras/install_irstlm.sh


Source:
http://jrmeyer.github.io/asr/2016/01/26/Installing-Kaldi.html


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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


