import * as covidDB from "./covidDB";
import * as processCSV from "./processCSVs";

async function main()
{
	await processCSV.refreshData();
	await covidDB.generate_state_codes();
	console.log("state codes");
	await covidDB.new_york_adjustment();
	await covidDB.aggregate_states("confirmed");
	console.log("aggregate");
	await covidDB.aggregate_states("deaths");	
	await covidDB.table_delta("confirmed");
	await covidDB.table_delta("deaths");
	
	await covidDB.table_delta("confirmed_states");
	await covidDB.table_delta("deaths_states");
	await covidDB.moving_average("confirmed_states_delta",7);
	await covidDB.moving_average("deaths_states_delta",7);	
	await covidDB.moving_average("confirmed_delta",7);
	await covidDB.moving_average("deaths_delta",7);		


	await covidDB.moving_average("confirmed_states_delta",14);
	await covidDB.moving_average("deaths_states_delta",14);	
	await covidDB.moving_average("confirmed_delta",14);
	await covidDB.moving_average("deaths_delta",14);	
	
	await covidDB.change_pct("confirmed_states_delta_ma_14",14,true);
		
	covidDB.end();
}

main();