/*
 * Wordcount 1.0 in Pig Latin
 * Tested on Pig version 0.10
 * Author: Jason Levitt
 * Date: May 15th, 2013
 * Note: Probably only works with ASCII English text
 */

myinput = LOAD '/user/someperson/test.txt' USING TextLoader AS (line:CHARARRAY);
words = FOREACH myinput GENERATE FLATTEN(TOKENIZE(REPLACE(LOWER(TRIM(line)),'[\\p{Punct},\\p{Cntrl}]','')));
grpd = GROUP words BY $0;
cntd = FOREACH grpd GENERATE $0, COUNT($1);
unmix = ORDER cntd BY $1 DESC, $0 ASC;
DUMP unmix;
