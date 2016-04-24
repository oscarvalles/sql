-- syntax to create engagements table in PosgtgreSQL
create table engagements
(
engagement_id  int,
engagement_date  date,
engagement_close  date,
product  varchar(50),
customer  varchar(50),
satisfaction  varchar(50)
)


-- inserting values into engagements table in PostgreSQL
insert into engagements values (1, '2013-01-01', '2014-09-15', 'Software', 'GM', 'Satisfied');
insert into engagements values (2, '2014-05-01', '2015-10-18', 'Hardware', 'GE', 'Unsatisfied');
insert into engagements values (3, '2013-03-01', '2014-12-21', 'Hardware', 'Google', 'Satisfied');
insert into engagements values (4, '2013-02-01', '2014-11-30', 'Hardware', 'Ford', 'Nuetral');
insert into engagements values (5, '2014-07-01', '2015-10-10', 'Software', 'IBM', 'Satisfied');
insert into engagements values (6, '2014-07-01', '2015-11-13', 'Hardware', 'Siemens', 'Unsatisfied');
insert into engagements values (7, '2013-08-01', '2014-11-21', 'Software', 'Freescale', 'Satisfied');
insert into engagements values (8, '2013-08-01', null, 'Software', 'Netflix', '');
insert into engagements values (9, '2014-08-01', null, 'Software', 'Amazon', '');



-- This table computes the highest number of days that you will need added to your time series
WITH RECURSIVE t(n) AS (
         VALUES (1)
        UNION ALL
         SELECT t.n + 1
           FROM t
          WHERE t.n <= (
                        select max(coalesce("engagement_close", current_date) - "engagement_date") as days_open
                        from engagements
                    )
        ) 

-- we join the days with your original table in order to add aging to the original
-- cutting off either at the close date or current date if the engagement is not closed
select  i.engagement_id,
i.indcident_date,
i.engagement_close,
i.product,
i.customer,
i.satisfaction,
i.engagement_date + t.n as day_opened
from engagements i
inner join t 
    on 1=1
where i.engagement_date + n <= coalesce(engagement_close, current_date)
order by 1,7
