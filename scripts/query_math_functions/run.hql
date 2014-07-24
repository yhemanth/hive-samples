use samples;

create table if not exists query_math_functions (
  int_col1 int,
  int_col2 int
)
row format delimited
fields terminated by ',';

load data local inpath '${hivevar:datadir}/query_math_functions.txt' overwrite into table query_math_functions;

select 
  int_col1,
  int_col2,
  int_col1 / int_col2,
  round(int_col1 / int_col2, 2)
from query_math_functions;

select
  floor(rand() * 100),
  floor(rand() * 100),
  floor(rand() * 100)
from query_math_functions;

select
  bin(4), conv(bin(4), 2, 16),
  bin(16), conv(bin(16), 2, 16),
  bin(256), conv(bin(256), 2, 16)
from query_math_functions limit 1;

select
  sin(30), cos(30), tan(30), round(sin(30)/cos(30), 2)
from query_math_functions limit 1;

select
  int_col2,
  pi()*pow(int_col2, 2)
from query_math_functions;

drop table if exists query_math_functions;
