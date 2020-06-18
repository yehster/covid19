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

const ER_NO_SUCH_TABLE="ER_NO_SUCH_TABLE";

export async function resetData()
{
	const truncateStatement=" DELETE FROM " + TBL_CONFIRMED + ";"
	+ " DELETE FROM " + TBL_DEATHS +";"
	+ " DELETE FROM " + TBL_CONFIRMED + "_DELTA" +";"
	+ " DELETE FROM " + TBL_DEATHS + "_DELTA" +";"
	+ " DELETE FROM " + TBL_LOCATIONS  +";";
	const outcome :Array<object> =  await promiseQuery(truncateStatement,[]);
	return outcome;
;
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
	return new Promise((resolve,reject)=>
    {
        var date_pairs=[];
        var location_pairs=[];
        var date_regex = /^(0?[1-9]|1[0-2])\/(0?[1-9]|1\d|2\d|3[01])\/\d{2}$/ ; // format is DD/MM/YY

        var location={};
        var location_columns="";
        var location_parameters="";
        var location_parameters_values=[];
        for(let p in row)
        {
            if(date_regex.test(p))
            {
                var dateParts=p.split("/");
                var dateData=new Date();
                let month=parseInt(dateParts[0])-1;
                let day = parseInt(dateParts[1]);
                let year=(2000+parseInt(dateParts[2]));
                dateData.setFullYear(year,month,day);
                date_pairs.push([dateData,row[p]]);
                
            }
            else
            {
                if(p===COL_LATITUDE)
                {
                    location.latitude=row[p];
                }
                else if(p===COL_LONGITUDE)
                {
                    location.longitude=row[p];
                }
                else
                {
                    location_pairs.push(p,row[p]);
                    location_columns+=","+p;
                    location_parameters+=", ?";
                    location_parameters_values.push(row[p]);
                }
            }
        }
        location_columns = location_columns.substr(1);
        location_columns += ", geo_location";
        location_parameters = location_parameters.substr(1)+ ", POINT("+location.latitude+","+location.longitude+")";
        var createLocationSQL = " INSERT into " + TBL_LOCATIONS + " ("+location_columns+")" + " VALUES ("+location_parameters + ");";
        
        var insert_parameters=[];
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
                insert_parameters.push(row.UID,cur_date[0],cur_date[1]);
                first=false;
            }
        }
        var combinedQuery="";
        var full_parameters=[];
        console.log(row['Combined_Key']);
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
            resolve("No updates");
            return;
        }
        promiseQuery(combinedQuery,full_parameters).then((result)=>{;resolve(result);});
    });
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
		var sql="TRUNCATE TABLE confirmed_delta;"
				+"TRUNCATE TABLE deaths_delta;"
				+"INSERT INTO confirmed_delta (SELECT  intUID(),c1.location, c1.day,c1.number-IFNULL(c2.number,0) AS `number` FROM confirmed AS c1 LEFT JOIN confirmed AS c2 ON c2.day=DATE_SUB(c1.day, INTERVAL 1 DAY) AND c2.location=c1.location );"
				+"insert into deaths_delta (SELECT intUID(),c1.location, c1.day,c1.number-IFNULL(c2.number,0) AS `number` FROM deaths AS c1 LEFT JOIN deaths AS c2 ON c2.day=DATE_SUB(c1.day, INTERVAL 1 DAY) AND c2.location=c1.location) ;";
		promiseQuery(sql,[]).then((result)=>{resolve(result);});
    });
}
var dbConnection=mysql.createConnection(dbParameters());

export function end()
{
	dbConnection.end();
}
module.exports={
  dbConnection : dbConnection,
  processTimeSeries:processTimeSeries,
  updateDeltas: updateDeltas,
  end: end
};