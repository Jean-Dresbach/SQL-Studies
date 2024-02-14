select avg("PTS") from player_stats ps
where player = 'Paul George';

select avg(ps."PTS") from player_stats ps
where ps.player = 'Paul George'
and ps."FG" > 2;

select max(ps."TRB") as rebounds, ps.player, ps.team
from player_stats ps
where ps."DRB" is not null
group by (ps.player, ps.team) 
	order by rebounds desc
	limit 1;

select gi.season, gi.home_score, gi.home_team  from game_info gi
join 
	(
        select max(home_score) as max_score, season  
        from game_info
        group by season 
    ) as subQuery 
    	on gi.season = subQuery.season 
    	and gi.home_score = subQuery.max_score
	