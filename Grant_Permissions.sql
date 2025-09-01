-- File Name: Grant_Permissions.sql
-- Name: Palak Yogesh Chaudhary
-- Student Id: 991708879
-- Oracle Username: S1_CHAUPALA
-- Group: 4

-- Grant SELECT permission on all tables to other group members

GRANT SELECT ON movie_category TO s1_gurbaghs;
GRANT SELECT ON customer TO s1_gurbaghs;
GRANT SELECT ON dvds TO s1_gurbaghs;
GRANT SELECT ON dvd_rental TO s1_gurbaghs;

GRANT SELECT, INSERT, UPDATE, DELETE ON movie_category TO s1_gurbaghs;
GRANT SELECT, INSERT, UPDATE, DELETE ON customer TO s1_gurbaghs;
GRANT SELECT, INSERT, UPDATE, DELETE ON dvds TO s1_gurbaghs;
GRANT SELECT, INSERT, UPDATE, DELETE ON dvd_rental TO s1_gurbaghs;