/*
 * WordCountWithStopList in HiveQL
 * Wordcount example with http://en.wikipedia.org/wiki/Stop_list
 * Tested on Hive version 0.9
 * Author: Jason Levitt
 * Date: June 25th, 2013
 * Note: Probably only works with ASCII English text
 * The idea for the stop list (left outer join) is from the book
 * "Enterprise Data Workflows with Cascading" by Paco Nathan
 */

-- Delete all the tables from previous runs (if any)
DROP TABLE myinput;
DROP TABLE wordscleaned;
DROP TABLE stopwords;
DROP TABLE finalcount;

-- Load the text to count and the list of stop words
CREATE TABLE myinput (line STRING);
CREATE TABLE stopwords (stop STRING);
LOAD DATA LOCAL INPATH '/user/someperson/mytext.txt' INTO TABLE myinput;
LOAD DATA LOCAL INPATH  '/user/someperson/stoplist.txt' INTO TABLE stopwords;

-- Clean up the text by removing any punctuation and control characters
CREATE TABLE wordscleaned AS
SELECT word 
FROM (SELECT EXPLODE(SPLIT(LCASE(REGEXP_REPLACE(line,'[\\p{Punct},\\p{Cntrl}]','')),' '))
AS word FROM myinput) words;

-- Count the words and filter out the stop words
CREATE TABLE finalcount AS
SELECT word, COUNT(*) AS count
FROM (SELECT * FROM wordscleaned LEFT OUTER JOIN stopwords
ON (wordscleaned.word = stopwords.stop)
WHERE stop IS NULL) removestopwords
GROUP BY word
ORDER BY count DESC, word ASC;

-- Make the Hive output look like the output of the Pig DUMP command
SELECT CONCAT_WS(',', CONCAT("\(",word), CONCAT(count,"\)")) FROM finalcount;
