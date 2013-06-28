/*
 * Wordcount 1.0 in HiveQL
 * Tested on Hive version 0.9
 * Author: Jason Levitt
 * Date: May 15th, 2013
 * Note: Probably only works with ASCII English text
 */

DROP TABLE myinput;
DROP TABLE wordcount;
CREATE TABLE myinput (line STRING);
LOAD DATA LOCAL INPATH '/user/someperson/test.txt' INTO TABLE myinput;
CREATE TABLE wordcount AS
SELECT word, count(1) AS count 
FROM (SELECT EXPLODE(SPLIT(LCASE(REGEXP_REPLACE(line,'[\\p{Punct},\\p{Cntrl}]','')),' '))
AS word FROM myinput) words
GROUP BY word
ORDER BY count DESC, word ASC;
SELECT CONCAT_WS(',', CONCAT("\(",word), CONCAT(count,"\)")) FROM wordcount;
