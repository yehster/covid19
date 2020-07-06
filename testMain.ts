import * as covidDB from "./covidDB";


async function main()
{
//	await covidDB.generate_state_codes();
//	await covidDB.aggregate_states("confirmed");
	let results = await covidDB.get_county_case_rates();
	console.log(results);
	covidDB.end();
}

main();