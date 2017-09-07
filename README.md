## Move Files to Separate Folders:

The motivation for this small bash script is that when you want to make a big
backup of files, let's say to google drive, dropbox, icloud etc., it can simply
take forever before your files are uploaded. In my case, I wanted to backup
32000 separate files (photo's) from an external drive directly to the cloud.
This can take a couple of days to be uploaded, so the idea is to create smaller
batches so that you can also turn your computer off and continue later.

So, I wanted to move / copy these separate 32000 files into separate folders of
size `N`.

## Usage

Make part directories of size 10 (default is 10 per folder)

> 10 files
~~~shell
./mftsf.sh -i inputDir -o outputDir
~~~

Make part directories of size 500 (default is 10 per folder)

> 500 files

~~~shell
./mftsf.sh -i inputDir -o outputDir -n 500
~~~

An example of how this looks like:
~~~shell
├── folder (here all your files are located for example).
└── output
    ├── part_0
    ├── part_1000
    ├── part_1500
    └── part_500
~~~

> Skip the first 100 and then make folders of size 100
~~~shell
./mftsf.sh -i inputDir -o outputDir -s 100 -n 100
~~~

## Disclaimer
I used this myself to make it work for my purpose, I'm not guaranteeing
anything for anyone else with respect to the result. I deliberately use the
`cp` command instead of the `mv` because I don't want to remove files. With the
skip command you can easily start off.
