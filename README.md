pig-hive-wordcount
==================

Wordcount is the "Hello World" for Hadoop, yet 
most of the Pig and Hive wordcount examples I've seen either require UDFs, 
external scripts, or they just don't do a very good job of counting words. 

So, my goal here was not efficiency, but merely to create
Pig and Hive scripts that:

1. Use only stock functions that ship with the language (no UDFs or external scripts)
2. Are short and simple
3. Do a pretty good job of counting words
4. Produce diff-able output

To make it diffable, I reformat the Hive output to look like the output of the Pig DUMP operator.
In my few tests, output of the two scripts has been identical, or very close, most of the time, though
Hive still insists on counting some invisible character occasionally.
