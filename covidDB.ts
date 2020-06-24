import mysql from "mysql";



function dbParameters()
{
    var retval= {
        host: 'localhost',
        port:3306,
        user : 'covid',
        supportBigNumbers: true,
        password : 'covid',
        database : 'covid',
        multipleStatements: true
    };
    return retval;
}

const TBL_LOCATIONS : string ='locations';
const TBL_DEATHS : string ='deaths';
const TBL_CONFIRMED : string ='confirmed';
const COL_LATITUDE : string ="Lat";
const COL_LONGITUDE : string ="Long_";

const TBL_LOCATION_STATES : string ='location_states';
const TBL_STATE_CODES : string ='state_codes';

const ER_NO_SUCH_TABLE="ER_NO_SUCH_TABLE";

async function truncateTables(pattern : string)
{
	const getTables = " SHOW TABLES like '"+ pattern + "%'";
	const tables = await promiseQuery(getTables,[]);
	for(let tblIdx=0;tblIdx< tables.length;tblIdx++)
	{
		let curTable = tables[tblIdx];
		
		await promiseQuery("DELETE FROM  `" +Object.values(curTable)[0] ,[]); 
	}
	
}
export async function resetData()
{
	
	await truncateTables(TBL_CONFIRMED);
	await truncateTables(TBL_DEATHS);
	const truncateStatement=" DELETE FROM " + TBL_LOCATION_STATES  +";"	
	 + " DELETE FROM " + TBL_STATE_CODES  +";"
	 + " DELETE FROM " + TBL_LOCATIONS  +";";
	console.log(truncateStatement);
	const outcome :Array<object> =  await promiseQuery(truncateStatement,[]);
	return outcome;
}

function promiseQuery(sql : string ,parameters : Array<object>)
{
	return new Promise<Array<object>>((resolve,reject)=>
	{
		dbConnection.query(sql,parameters,(err,result)=>
		{
			if(err)
			{
				console.log(err);
				reject(err);
			}
			else
			{
				resolve(result);
			}
		});
	});
}
async function addLocationTimeSeries(row : object,type : string)
{

	var table : string = type==="d" ? TBL_DEATHS : TBL_CONFIRMED;
	var date_pairs=[];
	var location_pairs=[];
	var date_regex = /^(0?[1-9]|1[0-2])\/(0?[1-9]|1\d|2\d|3[01])\/\d{2}$/ ; // format is DD/MM/YY

	var location={ latitude: new String(""),longitude: new String("")};
	var location_columns="";
	var location_parameters="";
	var location_parameters_values: Array<object>=[];
	let UID : string = "";
	for(let [p,data]  of Object.entries(row))
	{
		if(p==="UID")
		{
			UID=data;
		}
		if(date_regex.test(p))
            {
				var dateParts=p.split("/");
				var dateData=new Date();
				let month=parseInt(dateParts[0])-1;
				let day = parseInt(dateParts[1]);
				let year=(2000+parseInt(dateParts[2]));
				dateData.setFullYear(year,month,day);
				date_pairs.push([dateData,data]);
			}
			else
			{
				if(p===COL_LATITUDE)
				{
				    location.latitude=data;
				}
				else if(p===COL_LONGITUDE)
				{
					location.longitude=data;
				}
				else
				{
					location_pairs.push(p,data);
					location_columns+=","+p;
					location_parameters+=", ?";
					location_parameters_values.push(data);
				}
			}
		}
		location_columns = location_columns.substr(1);
		location_columns += ", geo_location";
		location_parameters = location_parameters.substr(1)+ ", POINT("+location.latitude+","+location.longitude+")";
		var createLocationSQL = " INSERT into " + TBL_LOCATIONS + " ("+location_columns+")" + " VALUES ("+location_parameters + ");";
		
		var insert_parameters:Array<object>=[];
		let insertSQL="INSERT into " + table + "(UID,location,day,number) VALUES ";
		var first=true;
		for(var dateIdx=0;dateIdx<date_pairs.length;dateIdx++)
		{
			var cur_date=date_pairs[dateIdx];
			if(cur_date[1]!=="0")
			{
				if(!first)
				{
				    insertSQL += ",";
				}
				insertSQL += " (intUID(),?,?,?) ";
				insert_parameters.push(UID as String,cur_date[0],cur_date[1]);
				first=false;
			}
		}
		var combinedQuery="";
		let full_parameters : Array<object>=[];
		if(type==='d')
		{
			
			var combinedQuery=createLocationSQL;   
			full_parameters=location_parameters_values;
		}
		if(!first)
		{
			combinedQuery+=insertSQL;
			full_parameters=full_parameters.concat(insert_parameters);
		}
		if(combinedQuery==="")
		{
			return;
		}
		await promiseQuery(combinedQuery,full_parameters);
}

export async function processTimeSeries(data : Array<object>,type : string)
{
	for(let idx=0;idx<data.length;idx++)
	{
		let entry : object = data[idx];
		await addLocationTimeSeries(entry,type);
	}
};


export function updateDeltas()
{
	return new Promise((resolve,reject)=>
	{
		const sql="TRUNCATE TABLE confirmed_delta;"
				+"TRUNCATE TABLE deaths_delta;"
				+"INSERT INTO confirmed_delta (SELECT  intUID(),c1.location, c1.day,c1.number-IFNULL(c2.number,0) AS `number` FROM confirmed AS c1 LEFT JOIN confirmed AS c2 ON c2.day=DATE_SUB(c1.day, INTERVAL 1 DAY) AND c2.location=c1.location );"
				+"insert into deaths_delta (SELECT intUID(),c1.location, c1.day,c1.number-IFNULL(c2.number,0) AS `number` FROM deaths AS c1 LEFT JOIN deaths AS c2 ON c2.day=DATE_SUB(c1.day, INTERVAL 1 DAY) AND c2.location=c1.location) ;";
		promiseQuery(sql,[]).then((result)=>{resolve(result);});
	});
}

const COL_DAY : string = "day";
const COL_NUMBER : string = "number";
const COL_LOCATION : string = "location";
export async function moving_average(tableName : string, period : number)
{
	const ma_table : String = tableName + "_ma_"+ period;
	await verifySeriesTable(ma_table,true,true);
	
	let sumPhrase = "(t0" + "." + COL_NUMBER;
	let joinPhrase = " FROM " + tableName + " as t0";
	for(let phaseShift: number = 1;phaseShift< period;phaseShift++)
	{
		let phaseTable : string = "t"+phaseShift;
		sumPhrase += " + "+phaseTable + "." + COL_NUMBER;
		joinPhrase += " JOIN "+tableName + " as "+phaseTable + " ON " + phaseTable + "." + COL_DAY + "= DATE_SUB(t0." + COL_DAY + ", INTERVAL " + phaseShift + " DAY) AND " + phaseTable + "." + COL_LOCATION + "= t0." + COL_LOCATION;
			
	}
	sumPhrase += " )/" + period + " as number ";
	let insertPhrase = " INSERT INTO " + ma_table;
	let completeQuery = insertPhrase + "( SELECT intUID(), t0."+COL_LOCATION + "," + "t0."+COL_DAY+", "+ sumPhrase  + joinPhrase + ")";
	console.log(completeQuery);	
	await promiseQuery(completeQuery,[]);

}

export async function table_delta(tableName : string)
{
	let delta_name = tableName + "_delta";
	let selectDeltas = " SELECT intUID(), t0."+COL_LOCATION + "," + "t0." + COL_DAY + ", (t0."+COL_NUMBER + "- IFNULL(t1."+COL_NUMBER + ",0) ) as number FROM " + tableName + " as t0 LEFT JOIN " + tableName + " as t1 ON t1." + COL_DAY + "= DATE_SUB(t0." + COL_DAY + ", INTERVAL 1 DAY)" + " AND t1." + COL_LOCATION +"= t0.location";
	await verifySeriesTable(delta_name);
	let insertQuery = " INSERT INTO " + delta_name + "(" + selectDeltas + ");";
	await promiseQuery(insertQuery,[]);
	
}
export async function verifySeriesTable(tableName : String, floatingPoint : boolean = false, drop : boolean = false, state=false)
{

	// Allow floating point for moving averages tables
	
	if(tableName.indexOf("_ma_")>0 || tableName.indexOf("_cma")>0)
	{
		floatingPoint=true;
	}
	if(tableName.indexOf("_states")>0)
	{
		state=true;
	}
	if(drop)
	{
		try
		{
			await promiseQuery("DROP TABLE "+tableName + ";",[]);			
		}
		catch(err)
		{
			console.log(err);
		}
	}
	let showTable : string = "SHOW TABLES  LIKE ?";
	const tableCheck = await promiseQuery(showTable,[tableName]);
	let foreign_table : string = state ? "state_codes" : "locations";
	let foreign_column : string = state ? "UID" : "UID";
	console.log(tableCheck);
	if((tableCheck.length===0) || drop)
	{
		let createTable : string = " CREATE TABLE " + tableName + " ("		
		+" `UID` BIGINT(20) NOT NULL, "
		+" `location` BIGINT(20) NOT NULL,"
		+" `day` DATE NOT NULL, "
		+" `number` "+ (floatingPoint ? "FLOAT " : "INT(11) " )
		 +" NOT NULL, "
		+" PRIMARY KEY (`UID`) USING BTREE, "
		+" UNIQUE INDEX `location_day` (`location`, `day`) USING BTREE, "
		+" CONSTRAINT `"+tableName+"_ibfk_1` FOREIGN KEY (`location`) REFERENCES `"+foreign_table+"` (`"+foreign_column+"`) ON UPDATE RESTRICT ON DELETE RESTRICT "
		+ ")"; // Close CREATE TABLE

		await promiseQuery(createTable,[]);
	}
	
	
}

interface series_data
{
	day : string;
	location : string;
	number : number;
}
export async function cumulative_moving_average(tableName : string)
{
	let ma_table_name : string= tableName + "_cma";
	await verifySeriesTable(ma_table_name,true);
	const getAllData = " SELECT location, day, number FROM " + tableName + " ORDER BY location, day ";
	const fullData : Array<series_data> = await promiseQuery(getAllData,[]) as Array<series_data> ;
	let curLocation : string = "";
	let curCount=0;
	let curTotal=0;
	let newData : Array<series_data> = new Array<series_data>();
	for(let rowIdx : number = 0; rowIdx<fullData.length;rowIdx++)
	{
		let curRow = fullData[rowIdx];
		if(curLocation!=curRow.location)
		{
			curCount=0;
			curLocation=curRow.location;
			curTotal=0;
		}
		curCount++;
		curTotal+=curRow.number;
		
		newData.push({
				day: curRow.day
				,location : curRow.location
				,number : (curTotal / curCount) 
			});
	}
	var insertParameters : Array<object> = new Array<object>();
	let insertQuery = " INSERT INTO " + ma_table_name + " VALUES ";
	for(var dataIdx=0;dataIdx< newData.length;dataIdx++)
	{
		let curData : series_data = newData[dataIdx];
		if(dataIdx>0)
		{
			insertQuery += ",";
		}
		insertQuery += "(intUID(),?,?,?)";
		insertParameters.push(curData.location as String ,curData.day as String,curData.number as Number);
	
	}
	await promiseQuery(insertQuery,insertParameters);
}

export async function generate_state_codes()
{
	let filter = " WHERE NOT ISNULL(state_code) AND state_code NOT LIKE '9_' AND state_code NOT LIKE '8_'";
	let generateStateCodes = " SELECT uid,Province_State,CONVERT(IF(LENGTH(locations.FIPS)=7,SUBSTRING(FIPS,1,2),IF(LENGTH(locations.FIPS)=6,SUBSTRING(FIPS,1,1),NULL)),INTEGER) AS state_code FROM locations ";
	let insert_state_codes = " INSERT into state_codes SELECT state_code as uid, Province_state as name FROM ("+generateStateCodes+") as codes " + filter + " GROUP BY state_code";
	let insert_location_states = " INSERT INTO location_states select uid,state_code from ("+generateStateCodes+") as codes " + filter;
	await promiseQuery("DELETE FROM location_states",[]);
	await promiseQuery("DELETE FROM state_codes",[]);
	await promiseQuery(insert_state_codes,[]);
	await promiseQuery(insert_location_states,[]);
	
}

export async function aggregate_states(tableName : string)
{
	let aggregateName : string = tableName + "_states";
	await verifySeriesTable(aggregateName,false,true,true);
	var selectAggregate = " SELECT intUID(),sc.state as location, day, sum(number) as number FROM " + tableName + " as t0 JOIN location_states as sc on t0.location=sc.location GROUP BY sc.state, t0.day";
	var insertQuery = " INSERT INTO " + aggregateName + selectAggregate;
	await promiseQuery(insertQuery,[]);  
}

var dbConnection=mysql.createConnection(dbParameters());




export function end()
{
	dbConnection.end();
}
