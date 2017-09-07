## Move Files to Separate Folders - Introduction

The motivation for this small bash script is that when you want to perform a big backup of files to an online cloud system, let's say to google drive, dropbox, icloud etc.. This can simply take forever if you try to upload all your files at once. In my case, I wanted to backup 32000 separate files (photo's) from an external drive directly to the cloud. This can take a couple of days to be uploaded, so the idea is to create smaller batches so that you can also turn your computer off and continue later.

## What the tool does
So, I wanted to move / copy these separate 32000 files into separate folders of size `N` and then select all the files in the folder and **drag-and-drop** or **select-and-upload** without the risk or annoying fact of uploading a lot of files twice. Because I don't exactly know where I left off the next day when I turned my computer off... sound familiar?

So what I want it to subdivide all these 32000 files into separate folders like so (forget about how `tree` sorted it :))
~~~shell
├── folder # (here all your files are located for example).
└── output
    ├── part_0
    ├── part_1000
    ├── part_1500
    └── part_500
~~~
and then upload then by selecting a couple of 100 files, this is often far more manageable.

The tool itself uses the `cp` command to copy files to a new folder in given `outputDir`, so `cp inputDir/some-awesome-photo.jpg outputDir/part_0/some-awesome-photo.jpg` and it does this for all the files at -maxdepth 1 in the `inputDir` folder. 

## Usage
Now that you copied a bunch of files, let's see 1500 files you, you just stop the command using CTRL+C and use the `skip` at a later point in time and set it to 1500 again. It will then start at `part_1500` and start copying again. Of course you have a potential problem if you have some files in the 1500 directory and you've uploaded them leaving you with some (potential!!) duplicates. I say potential, because maybe your online cloud system filters those?

Notice that I purposely not use the `mv` command because I don't want anyone (including me) to use this
teeny tiny tool to delete their files.. don't want that responsibility.. 

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

> Skip the first 100 and then make folders of size 100, which starts at making the `part_100` folder and putting the files there.
~~~shell
./mftsf.sh -i inputDir -o outputDir -s 100 -n 100
~~~

## Lousy quote
I wish you a 'Happy Move Files to Separate Folders' time!!

## Disclaimer
I used this myself to make it work for my purpose, and hopefully can help someone else. I'm not guaranteeing
anything for anyone else with respect to the results. When you f&(*cked up and deleted all your important files for example.. don't do that. Again, I deliberately use the `cp` command instead of the `mv` because I don't want to remove files. Despite of what the tools is called ;) 
