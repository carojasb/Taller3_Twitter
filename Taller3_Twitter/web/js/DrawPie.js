/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function drawpie(doc_graficar){
var w = 400;
var h = 400;
var r = h/2;
var color = d3.scale.category10();
/*var color = function (d,i){
    if(d.label === "Positivo"){
        return "red" ;
    }else
        return d3.scale.category20();
};*/

/*var data = [{"label":"Category A", "value":20}, 
		          {"label":"Category B", "value":50}, 
		          {"label":"Category C", "value":30}];*/

var data = doc_graficar;

var vis = d3.select('#chart').append("svg:svg").data([data]).attr("width", w).attr("height", h).append("svg:g").attr("transform", "translate(" + r + "," + r + ")");
var pie = d3.layout.pie().value(function(d){return d.value;});

// declare an arc generator function
var arc = d3.svg.arc().outerRadius(r);

// select paths, use arc generator to draw
var arcs = vis.selectAll("g.slice").data(pie).enter().append("svg:g").attr("class", "slice");
arcs.append("svg:path")
    .attr("fill", function(d, i){
        console.log(d);
        if(d.data.label === "Muy Negativo" ){
            console.log(d.data.label);
            return "red";
        }else if (d.data.label === "Negativo" ) {
             console.log(d.data.label);
            return "orange";
        }else if (d.data.label === "Neutro" ) {
             console.log(d.data.label);
            return "blue";
        }else if (d.data.label === "Positivo" ) {
             console.log(d.data.label);
            return "yellow";
        }else if (d.data.label === "Muy Positivo" ) {
             console.log(d.data.label);
            return "green";
        }
    })
    .attr("d", function (d) {
        // log the result of the arc generator to show how cool it is :)
        //console.log(arc(d));
        return arc(d);
    });

// add the text
arcs.append("svg:text").attr("transform", function(d){
			d.innerRadius = 0;
			d.outerRadius = r;
    return "translate(" + arc.centroid(d) + ")";}).attr("text-anchor", "middle").text( function(d, i) {
    return data[i].label;}
		);
    }