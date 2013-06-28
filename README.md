pig-hive-wordcount
==================

Most of the Pig and Hive wordcount examples I've seen either require UDFs, 
external scripts, or they don't produce diff-able output. 
Or, they just don't do a very good job of counting words. 

So, my goal here was not efficiency (obviously), but merely to create
Pig and Hive scripts that:

1. Use only stock functions that ship with the language (no UDFs or external scripts)
2. Product diff-able output
3. Do a pretty good job of counting words

Do make it diffable, I reformat the Hive output to look like the output of the Pig dump command.
The output of the two scripts has been identical, or very close, most of the time, though
Hive still insists on counting some invisible character occasionally.
