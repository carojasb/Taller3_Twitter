/* global d3 */

function LineChartSeguidores(documento_json, country){
    
       
  // set the dimensions and margins of the graph
var margin = {top: 20, right: 70, bottom: 30, left: 70},
    width = 1200 - margin.left - margin.right,
    height = 600 - margin.top - margin.bottom;
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

function draw(documento_json, country) {  
    
}
  var data = documento_json[country];  
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
  y.domain([d3.min(data, function(d) { return (d.Seguidores); }), 
            d3.max(data, function(d) { return (d.Seguidores); })]);
  
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

function consultar_seguidores(){
    var cuenta_seleccionada = document.getElementById('candidatos');
    console.log(cuenta_seleccionada.value);
  }