/* global d3 */

function LineChartSeguidores(){
    
  // set the dimensions and margins of the graph
var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;
// set the ranges
var x = d3.scaleTime().range([0, width]);
var y = d3.scaleLinear().range([height, 0]);
// define the line
var valueline = d3.line()
    .x(function(d) { return x(d.Date); })
    .y(function(d) { return y(d.Seguidores); });
    
var svg = d3.select("body").selectAll(".Line_chart").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");
          
var parseTime = d3.timeParse("%d-%m-%Y %H:%M:%S");

function draw(data, country) {  
  var data = data[country];  
  // format the data
  data.forEach(function(d) {     
      d.Date = parseTime(d.FechaRegDatos);
      d.Seguidores = +d.countSeguidores;
  });
  
  // sort years ascending
 data.sort(function(a, b){
    return a["Date"]-b["Date"];
	})
 
  // Scale the range of the data
  x.domain(d3.extent(data, function(d) { return d.Date; }));
  y.domain([0, d3.max(data, function(d) { return Math.max(d.Seguidores); })]);
  
  // Add the valueline path.
  svg.append("path")
      .data([data])
      .attr("class", "line")
      .attr("d", valueline);
      
  // Add the X Axis
  svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));
  // Add the Y Axis
  svg.append("g")
      .call(d3.axisLeft(y));
  }
  
  // Get the data
d3.json("../Resources/Data/data.json", function(error, data) {
  if (error) throw error;
  draw(data, "Tweet");
});

}
