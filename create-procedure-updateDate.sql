delimiter $$

create procedure UpdateDate(
  in in_bid int,
  in in_months int,
  in in_add bool
) begin
  if not in_add then
    update Borrows
    set Borrows.EndDate = date_sub(Borrows.EndDate, interval in_months month)
    where Borrows.BID = in_bid;
  else
    update Borrows
    set Borrows.EndDate = date_add(Borrows.EndDate, interval in_months month)
    where Borrows.BID = in_bid;
  end if;
end $$

delimiter ;