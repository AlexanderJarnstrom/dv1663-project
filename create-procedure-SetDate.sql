delimiter $$
create procedure SetDate(
  in in_bid int,
  in in_newDate date
) begin
  if curdate() < in_newDate then
    update Borrows 
    set Borrows.EndDate = in_newDate
    where Borrows.BID = in_bid;
  end if;
end $$

delimiter ;