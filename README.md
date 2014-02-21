xsqutils
===

Converts XSQ format files to FASTQ format files.

Reuires anaconda to be installed and searchable in PATH. After doing `git clone https://github.com/biocyberman/xsqutils.git`, do `cd xsquitils && ./setup.sh`. Follow instructions fromt there
Requires the [pytables](http://pytables.org/) library. If you prefer to use pip, this will require HDF5-devel and cython libraries to be installed.

HDF5 libraries can be downloaded from [http://www.hdfgroup.org/HDF5/](http://www.hdfgroup.org/HDF5/). 
They can also be found in the EPEL yum repository. Pytables requires HDF5 1.6.10 or better.

By default: The installation script `setup.sh` will copy the package to `<ANACONDA_ROOT/envs/xsqutils_env/xsqutils` and the executable will be linked to ANACONDA_ROOT/envs/xsqutils_env/bin.
In the alternative setup, which uses setup a virtualenv environment and installing Pytables and its dependencies. The virtualenv will be setup in the 'xsqutils_env' directory. The default `xsq` driver script expects this setup and will automatically setup the virtualenv accordingly.

When converting a sample or entire file, multiple processors can be used to speed the conversion.

Usage
---
    xsq cmd {opts} filename.xsq

    Commands:
        info      - Lists all of the data associated with the XSQ file
        list      - Lists the samples and tags (R3/F3/etc) present in the file
            Options:
              -c           Show the number of reads present for each tag
              -min {val}   Hide samples that have less than {val} reads

        convert   - Converts XSQ samples and fragments to FASTQ format
            Options:
              -a           Convert all samples (saves to sample_name.fastq.gz)
                  [-a additional options]
                  -desc          Use descriptions for the sample name
                  -f             Overwrite existing files
                  -min {val}     Skip samples that have less than {val} reads
                  -noz           Don't compress the output FASTQ files with gzip
                  -fsuf {val}    Add suffix to file name
                  -unclassified  Export "Unclassified" library (usually skipped)

              -n name        Convert only sample "name" (writes to stdout)
                             (can be only one, written uncompressed)
              -procs {val}   Use {val} number of threads (CPUs) to convert one
                             region at a time. (default 1)
              -s suffix      Append a suffix to all read names
              -t tag         Convert only this tag (can be more than one)
                             If more than one tag is given, the sequences for
                             each read will be written out together.
                               For example:
                               @read1 F3
                               F3 seq
                               +
                               F3 qual
                               @read1 R5
                               R5 seq
                               +
                               R5 qual
                               @read2
                               ...

            The default is to convert all samples and all fragments/tags.