/*
 * WordCountWithStopList in Pig Latin
 * Wordcount example with http://en.wikipedia.org/wiki/Stop_list
 * Tested on Pig version 0.10
 * Author: Jason Levitt
 * Date: June 25th, 2013
 * Note: Probably only works with ASCII English text
 * The idea for the stop list (left outer join) is from the book
 * "Enterprise Data Workflows with Cascading" by Paco Nathan
 */

-- Load the text to count and the list of stop words
myinput = LOAD '/user/someperson/mytext.txt' USING TextLoader AS (line:CHARARRAY);
stoplist = LOAD '/user/someperson/stoplist.txt' USING TextLoader AS (stop:CHARARRAY);

-- Clean and tokenize the text by removing all punctuation and control characters
words = FOREACH myinput GENERATE FLATTEN(TOKENIZE(REPLACE(LOWER(TRIM(line)),'[\\p{Punct},\\p{Cntrl}]',''))) AS word;

-- Remove any stop words using a Left Outer Join
words = JOIN words BY word LEFT, stoplist BY stop;
words = FILTER words BY stoplist::stop IS NULL;

grpd = GROUP words BY $0;
cntd = FOREACH grpd GENERATE $0, COUNT($1);
unmix = ORDER cntd BY $1 DESC, $0 ASC;
DUMP unmix;
