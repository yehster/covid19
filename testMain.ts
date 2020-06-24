import * as covidDB from "./covidDB";


async function main()
{
	await covidDB.generate_state_codes();
	await covidDB.aggregate_states("confirmed");
	covidDB.end();
}

main();