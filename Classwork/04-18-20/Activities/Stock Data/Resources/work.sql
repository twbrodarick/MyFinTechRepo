create table stock_data(
stock_data_id serial not null primary key,
stock_ticker varchar(10) not null,
close_date date not null,
open float,
high float,
low float,
close float,
volume bigint
)

CREATE UNIQUE INDEX close_data ON stock_data (stock_ticker, close_date);

ALTER TABLE stock_data ADD CONSTRAINT 
     close_data UNIQUE USING INDEX close_data;

SELECT * from stock_data;

select distinct stock_ticker, min(close_date) as start_date, max(close_date) as end_date
from stock_data
group by stock_ticker
order by stock_ticker;