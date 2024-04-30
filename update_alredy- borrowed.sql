delimiter $$

create procedure UpdateDate(
  in in_bid int,
  in in_months int,
  in in_add bool
) 
begin
  declare row_count int;
  
  select count(*) into row_count from Borrows where BID = in_bid;
  
  if row_count = 0 then
    signal sqlstate '45000' set message_text = 'BID does not exist';
  end if;

  if not in_add then
    update Borrows
    set EndDate = date_sub(EndDate, interval in_months month)
    where BID = in_bid;
  else
    update Borrows
    set EndDate = date_add(EndDate, interval in_months month)
    where BID = in_bid;
  end if;
end $$

create procedure SetDate(
  in in_bid int,
  in in_newDate date
) 
begin
  declare cur_date date;
  
  select curdate() into cur_date;
  
  if cur_date < in_newDate then
    update Borrows 
    set EndDate = in_newDate
    where BID = in_bid;
  else
    signal sqlstate '45000' set message_text = 'New date must be later than current date';
  end if;
end $$

delimiter ;
