import * as covidDB from "./covidDB";




async function main()
{
	await covidDB.moving_average("confirmed_delta",7);
	await covidDB.moving_average("deaths_delta",7);
	covidDB.end();
}

main();