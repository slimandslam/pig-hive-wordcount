In this folder are the same Wordcount Hive and Pig scripts except with a
"stoplist" feature: http://en.wikipedia.org/wiki/Stop_list

A stoplist, in this case, is a list of words that get filtered out of the
final results before they are output. I'm using a Left Outer Join to
remove any words that appear in the stoplist.  I got the stop list idea from the book:
[Enterprise Data Workflows With Cascading](http://www.amazon.com/Enterprise-Data-Workflows-Cascading-Nathan/dp/1449358721) 
by [Paco Nathan](http://en.wikipedia.org/wiki/Paco_Nathan)

The directory SampleData contains a sample stop list and input text.
