select region,
	sum(population)
from "populationdb"."population"
where region='Sul'
group by region;
