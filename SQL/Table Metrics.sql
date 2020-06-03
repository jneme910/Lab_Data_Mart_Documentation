set nocount on

declare @old_tname varchar(100)

declare @avg_row int

declare @tname varchar(100)

declare @data int

declare @row int

create table #size (tname varchar(1024),

row int,

reserve char(18),

data char(18),

index_size char(18),

unused char(18))

create table #results (tname varchar(100),

data_size int,

rows int)

select top 1 @tname=name from sysobjects where xtype = 'u' order by name

set @old_tname = ''

while @old_tname < @tname

begin

insert into #size exec ('sp_spaceused ' + @tname + ',true')

select @row=row, @data=substring(data,1,charindex(' ',data)-1) from #size

insert into #results values (@tname,@data,@row)

set @old_tname = @tname

select top 1 @tname=name from sysobjects where xtype = 'u' and name > @old_tname order by name

end

select left(tname, 45),

rows, data_size,

case rows when 0 then 0

else (1024*cast(data_size as float))/cast(rows as float)

end as avg_row_size,

case rows when 0 then 0

else 8024.0/((1024*cast(data_size as float))/cast(rows as float))

end as num_rows_per_page

from #results

drop table #results

drop table #size